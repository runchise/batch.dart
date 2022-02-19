// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/banner.dart';
import 'package:batch/src/batch_application.dart';
import 'package:batch/src/job.dart';
import 'package:batch/src/job_launcher.dart';
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/log/logger_instance.dart';
import 'package:batch/src/log/logger_provider.dart';
import 'package:batch/src/log_configuration.dart';

class BatchApplicationImpl implements BatchApplication {
  BatchApplicationImpl({
    this.logConfig,
  });

  /// The jobs
  final _jobs = <Job>[];

  /// The configuration for logging
  final LogConfiguration? logConfig;

  @override
  BatchApplication addJob(final Job job) {
    for (final registeredJob in _jobs) {
      if (registeredJob.name == job.name) {
        throw Exception('The job name "${job.name}" is already registered.');
      }
    }

    _jobs.add(job);

    return this;
  }

  @override
  void run() {
    try {
      //! The logging functionality provided by the batch library
      //! will be available when this loading process is complete.
      //! Also an instance of the Logger is held as a static field in LoggerInstance.
      Logger.loadFrom(config: logConfig ?? LogConfiguration());

      info(
        '🚀🚀🚀🚀🚀🚀🚀 The batch process has started! 🚀🚀🚀🚀🚀🚀🚀\n${Banner.layout}',
      );

      JobLauncher(jobs: _jobs).execute();
    } catch (e) {
      LoggerInstance.instance!.dispose();
      throw Exception(e);
    }
  }
}
