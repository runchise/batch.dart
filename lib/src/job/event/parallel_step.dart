// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:batch/batch.dart';
import 'package:batch/src/job/event/base_step.dart';

class ParallelStep extends BaseStep<ParallelStep> {
  /// Returns the new instance of [ParallelStep].
  ParallelStep({
    required String name,
    required List<ParallelTask> tasks,
    FutureOr<bool> Function(ExecutionContext context)? precondition,
    Function(ExecutionContext context)? onStarted,
    Function(ExecutionContext context)? onSucceeded,
    Function(ExecutionContext context, dynamic error, StackTrace stackTrace)?
        onError,
    Function(ExecutionContext context)? onCompleted,
    SkipConfiguration? skipConfig,
    RetryConfiguration? retryConfig,
  })  : _tasks = tasks,
        super(
          name: name,
          precondition: precondition,
          onStarted: onStarted,
          onError: onError,
          onSucceeded: onSucceeded,
          onCompleted: onCompleted,
          skipConfig: skipConfig,
          retryConfig: retryConfig,
        );

  /// The parallel tasks
  final List<ParallelTask> _tasks;

  /// Returns the copied tasks.
  List<ParallelTask> get tasks => _tasks;
}
