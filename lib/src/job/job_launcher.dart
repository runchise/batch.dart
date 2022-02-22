// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:;
import 'package:cron/cron.dart';

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/context/context_helper.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/step_launcher.dart';
import 'package:batch/src/log/logger_provider.dart';

/// This class provides the feature to securely execute registered jobs.
class JobLauncher extends ContextHelper<Job> {
  /// Returns the new instance of [JobLauncher].
  JobLauncher({
    required this.jobs,
  }) : super(context: ExecutionContext());

  /// The jobs
  final List<Job> jobs;

  /// Cron
  final _cron = Cron();

  /// Runs all scheduled jobs.
  void execute() {
    if (jobs.isEmpty) {
      throw Exception('The job to be launched is required.');
    }

    info('The job schedule is being configured...');

    for (final job in jobs) {
      _cron.schedule(Schedule.parse(job.cron), () async {
        if (!job.canLaunch()) {
          info('Skipped ${job.name} because the precondition is not met.');
          return;
        }

        await _executeJob(job: job);
      });
    }

    info('The job schedule has configured!');
  }

  Future<void> _executeJob({required Job job}) async {
    super.startNewExecution(name: job.name);

    await StepLauncher(
      context: super.context,
      steps: job.steps,
      parentJobName: job.name,
    ).execute();

    super.finishExecution();
  }
}
