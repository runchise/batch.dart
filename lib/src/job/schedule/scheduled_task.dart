// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:batch/src/job/schedule/model/schedule.dart';

typedef Task = FutureOr<dynamic> Function();

class ScheduledTask {
  /// Returns the new instance of [ScheduledTask].
  ScheduledTask({required this.schedule, required Task task}) : _task = task;

  /// The schedule
  final Schedule schedule;

  /// The task
  final Task _task;

  bool _closed = false;
  Future? _running;
  bool _overrun = false;

  void tick(DateTime now) {
    if (_closed) return;
    if (!schedule.shouldRunAt(now)) return;
    _run();
  }

  void _run() {
    if (_closed) return;
    if (_running != null) {
      _overrun = true;
      return;
    }

    _running = Future.microtask(() => _task()).then(
      (_) => null,
      onError: (_) => null,
    );

    _running!.whenComplete(() {
      _running = null;
      if (_overrun) {
        _overrun = false;
        _run();
      }
    });
  }

  Future dispose() async {
    _closed = true;
    _overrun = false;

    if (_running != null) {
      await _running;
    }
  }
}
