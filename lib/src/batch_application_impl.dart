// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/banner/banner.dart';
import 'package:batch/src/batch_application.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/job_launcher.dart';
import 'package:batch/src/job/parameter/shared_parameters.dart';
import 'package:batch/src/log/log_configuration.dart';
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/log/logger_provider.dart';

/// This class is an implementation class of [BatchApplication].
class BatchApplicationImpl implements BatchApplication {
  /// Returns the new instance of [BatchApplicationImpl].
  BatchApplicationImpl({
    this.logConfig,
  });

  /// The jobs
  final _jobs = <Job>[];

  /// The configuration for logging
  final LogConfiguration? logConfig;

  @override
  void addJob(final Job job) {
    for (final registeredJob in _jobs) {
      if (registeredJob.name == job.name) {
        throw Exception('The job name "${job.name}" is already registered.');
      }
    }

    _jobs.add(job);
  }

  @override
  void addSharedParameter({
    required String key,
    required dynamic value,
  }) {
    SharedParameters.instance.put(
      key: key,
      value: value,
    );
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
      Logger.instance.dispose();
      throw Exception(e);
    }
  }
}
