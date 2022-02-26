// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:cron/cron.dart';

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/launcher/launcher.dart';
import 'package:batch/src/log/logger_provider.dart';

/// This class provides the feature to securely execute registered jobs.
class JobLauncher extends Launcher<Job> {
  /// Returns the new instance of [JobLauncher].
  JobLauncher({
    required this.jobs,
  }) : super(context: ExecutionContext());

  /// The jobs
  final List<Job> jobs;

  @override
  void execute() {
    if (jobs.isEmpty) {
      throw Exception('The job to be launched is required.');
    }

    info('The job schedule is being configured...');

    for (final job in jobs) {
      if (job.hasNotSchedule) {
        throw StateError('Be sure to specify a schedule for the root job.');
      }

      Cron().schedule(Schedule.parse(job.schedule!.build()), () async {
        await super.executeRecursively(entity: job);
      });
    }

    info('The job schedule has configured!');
  }
}
