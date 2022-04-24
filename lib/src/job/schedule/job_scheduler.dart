// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:clock/clock.dart';

// Project imports:
import 'package:batch/src/batch_instance.dart';
import 'package:batch/src/batch_status.dart';
import 'package:batch/src/job/event/scheduled_job.dart';
import 'package:batch/src/job/launcher/job_launcher.dart';
import 'package:batch/src/job/schedule/model/schedule.dart';
import 'package:batch/src/job/schedule/scheduled_task.dart';
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/log/logger_provider.dart';

class JobScheduler {
  /// Returns the new instance of [JobScheduler].
  JobScheduler(List<ScheduledJob> scheduledJobs)
      : _scheduledJobs = scheduledJobs;

  /// The jobs
  final List<ScheduledJob> _scheduledJobs;

  /// The schedules
  final List<ScheduledTask> _scheduledTasks = [];

  /// The timer
  Timer? _timer;

  void run() {
    log.info('Started Job scheduling on startup');
    log.info('Detected ${_scheduledJobs.length} Jobs on the root');

    for (final job in _scheduledJobs) {
      log.info('Scheduling Job [name=${job.name}]');

      _schedule(job.schedule.parse(), () async {
        try {
          await JobLauncher(job: job).run();
        } catch (error, stackTrace) {
          BatchInstance.updateStatus(BatchStatus.shuttingDown);
          log.fatal('Shut down the application due to a fatal exception', error,
              stackTrace);
        }
      });
    }

    BatchInstance.updateStatus(BatchStatus.running);

    log.info(
      'Job scheduling has been completed and the batch application is now running',
    );
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
    if (BatchInstance.isShuttingDown) {
      _dispose();
      return;
    }

    _timer = null;

    final now = clock.now();
    for (final scheduledTask in _scheduledTasks) {
      scheduledTask.tick(now);
    }

    _scheduleNext();
  }

  void _dispose() {
    log.warn('Preparing for shutdown the batch application safely');

    for (final scheduledTask in _scheduledTasks) {
      scheduledTask.dispose();
    }

    log.warn('Allocation memory is releasing');
    log.warn('Shutdown the batch application');

    Logger.instance.dispose();
    BatchInstance.updateStatus(BatchStatus.shutdown);
  }
}
