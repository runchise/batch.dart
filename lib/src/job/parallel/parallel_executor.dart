// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:async_task/async_task.dart';

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/task/parallel_task.dart';
import 'package:batch/src/log/log_configuration.dart';
import 'package:batch/src/log/logger.dart';

class ParallelExecutor extends AsyncTask<String, void> {
  /// Returns the new instance of [ParallelExecutor].
  ParallelExecutor({required this.parallelTask});

  /// The parallel task
  final ParallelTask parallelTask;

  /// The log configuration from main thread
  LogConfiguration? logConfig;

  @override
  AsyncTask<String, void> instantiate(String parameters,
      [Map<String, SharedData>? sharedData]) {
    return this;
  }

  @override
  String parameters() {
    return '';
  }

  @override
  FutureOr<void> run() async {
    assert(logConfig != null);
    Logger.loadFrom(config: logConfig!);

    try {
      await parallelTask.execute(ExecutionContext());
    } catch (e) {
      rethrow;
    }
  }
}
