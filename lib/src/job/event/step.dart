// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:batch/src/job/config/retry_configuration.dart';
import 'package:batch/src/job/config/skip_configuration.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/event/event.dart';
import 'package:batch/src/job/event/parallel.dart';
import 'package:batch/src/job/event/task.dart';
import 'package:batch/src/job/task/shutdown_task.dart';

/// This class represents the processing of each step that constitutes a job in batch processing.
class Step extends Event<Step> {
  /// Returns the new instance of [Step].
  Step({
    required String name,
    FutureOr<bool> Function()? precondition,
    Function(ExecutionContext context)? onStarted,
    Function(ExecutionContext context)? onSucceeded,
    Function(ExecutionContext context, dynamic error, StackTrace stackTrace)?
        onError,
    Function(ExecutionContext context)? onCompleted,
    SkipConfiguration? skipConfig,
    RetryConfiguration? retryConfig,
  }) : super(
          name: name,
          precondition: precondition,
          onStarted: onStarted,
          onError: onError,
          onSucceeded: onSucceeded,
          onCompleted: onCompleted,
          skipConfig: skipConfig,
          retryConfig: retryConfig,
        );

  /// The tasks include parallels
  final List<dynamic> _tasks = [];

  /// Returns the copied tasks.
  List<dynamic> get tasks => List.from(_tasks);

  /// Adds next [Task].
  void nextTask(final Task task) => _tasks.add(task);

  /// Stores next [Parallel].
  void nextParallel(final Parallel parallel) => _tasks.add(parallel);

  /// Add a task to shutdown this application.
  void shutdown() => _tasks.add(ShutdownTask());
}
