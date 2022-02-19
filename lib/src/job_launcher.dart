// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:cron/cron.dart';

// Project imports:
import 'package:batch/src/banner.dart';
import 'package:batch/src/job.dart';
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/log/logger_instance.dart';
import 'package:batch/src/log/logger_provider.dart';
import 'package:batch/src/log_configuration.dart';
import 'package:batch/src/step_launcher.dart';

/// This class provides the feature to securely execute registered jobs.
class JobLauncher {
  /// Returns the new instance of [JobLauncher].
  JobLauncher({
    this.logConfig,
  });

  /// The jobs
  final _jobs = <Job>[];

  /// Cron
  final _cron = Cron();

  /// The configuration for logging
  LogConfiguration? logConfig;

  /// Adds [Job].
  ///
  /// The name of the Job must be unique, and an exception will be raised
  /// if a Job with a duplicate name has already been registered.
  JobLauncher addJob(final Job job) {
    for (final registeredJob in _jobs) {
      if (registeredJob.name == job.name) {
        throw Exception('The job name "${job.name}" is already registered.');
      }
    }

    _jobs.add(job);

    return this;
  }

  /// Runs all scheduled jobs.
  void execute() {
    if (_jobs.isEmpty) {
      throw Exception(
        'Register the job to be launched is required. Use "addJob(Job job) method."',
      );
    }

    //! The logging functionality provided by the batch library
    //! will be available when this loading process is complete.
    //! Also an instance of the Logger is held as a static field in LoggerInstance.
    Logger.loadFrom(config: logConfig ?? LogConfiguration());

    info(
        '🚀🚀🚀🚀🚀🚀🚀 The batch process has started! 🚀🚀🚀🚀🚀🚀🚀\n${Banner.layout}');

    try {
      info('The job schedule is being configured...');

      for (final job in _jobs) {
        _cron.schedule(Schedule.parse(job.cron), () async {
          info('STARTED JOB (${job.name})');

          await StepLauncher(
            parentJobName: job.name,
            steps: job.steps,
          ).execute();

          info('FINISHED JOB (${job.name})');
        });
      }

      info('The job schedule has configured!');
    } catch (e) {
      LoggerInstance.instance!.dispose();
      throw Exception(e);
    }
  }
}
