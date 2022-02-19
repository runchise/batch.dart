// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:cron/cron.dart';

// Project imports:
import 'package:batch/src/job.dart';
import 'package:batch/src/log/logger_provider.dart';
import 'package:batch/src/step_launcher.dart';

/// This class provides the feature to securely execute registered jobs.
class JobLauncher {
  /// Returns the new instance of [JobLauncher].
  JobLauncher({
    required this.jobs,
  });

  /// The jobs
  final List<Job> jobs;

  /// Cron
  final _cron = Cron();

  /// Runs all scheduled jobs.
  void execute() {
    if (jobs.isEmpty) {
      throw Exception(
        'The job to be launched is required.',
      );
    }

    info('The job schedule is being configured...');

    for (final job in jobs) {
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
  }
}
