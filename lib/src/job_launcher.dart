// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:cron/cron.dart';

// Project imports:
import 'package:batch/src/job.dart';
import 'package:batch/src/step_launcher.dart';

/// This class provides the feature to securely execute registered jobs.
class JobLauncher {
  /// Returns the new instance of [JobLauncher].
  JobLauncher.newInstance();

  /// The jobs
  final _jobs = <Job>[];

  /// Cron
  final _cron = Cron();

  /// Adds [Job].
  ///
  /// The name of the Job must be unique, and an exception will be raised
  /// if a Job with a duplicate name has already been registered.
  JobLauncher addJob(final Job job) {
    for (final registeredJob in _jobs) {
      if (registeredJob.name == job.name) {
        throw Exception('The job name "${job.name}" is already registred.');
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

    try {
      for (final job in _jobs) {
        _cron.schedule(Schedule.parse(job.cron), () async {
          await StepLauncher.from(steps: job.steps).execute();
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
