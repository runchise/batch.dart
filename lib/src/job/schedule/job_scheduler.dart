// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:clock/clock.dart';

// Project imports:
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/launcher/job_launcher.dart';
import 'package:batch/src/job/schedule/model/schedule.dart';
import 'package:batch/src/job/schedule/scheduled_task.dart';
import 'package:batch/src/runner.dart';

class JobScheduler implements Runner {
  JobScheduler({required List<Job> jobs}) : _jobs = jobs;

  final List<Job> _jobs;

  /// The schedules
  final List<ScheduledTask> _scheduledTasks = [];

  /// The timer
  Timer? _timer;

  @override
  void run() {
    for (final job in _jobs) {
      if (job.isNotScheduled) {
        throw StateError('Be sure to specify a schedule for the root job.');
      }

      _schedule(
        job.schedule!.parse(),
        () async => await JobLauncher(job: job).run(),
      );
    }
  }

  void _schedule(Schedule schedule, Task task) {
    _scheduledTasks.add(ScheduledTask(schedule: schedule, task: task));
    _scheduleNext();
  }

  void _scheduleNext() {
    if (_timer != null) {
      return;
    }

    final now = clock.now();
    final isTickSeconds =
        _scheduledTasks.any((task) => task.schedule.hasSeconds);
    final ms = (isTickSeconds ? 1 : 60) * Duration.millisecondsPerSecond -
        (now.millisecondsSinceEpoch %
            ((isTickSeconds ? 1 : 60) * Duration.millisecondsPerSecond));

    _timer = Timer(Duration(milliseconds: ms), _tick);
  }

  void _tick() {
    _timer = null;

    final now = clock.now();
    for (final scheduledTask in _scheduledTasks) {
      scheduledTask.tick(now);
    }

    _scheduleNext();
  }
}
