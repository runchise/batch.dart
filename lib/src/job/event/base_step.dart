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
import 'package:batch/src/job/task/task.dart';

/// This class represents the processing of each step that constitutes a job in batch processing.
abstract class BaseStep extends Event<BaseStep> {
  /// Returns the new instance of [Step].
  BaseStep({
    required String name,
    required List<Task> tasks,
    FutureOr<bool> Function(ExecutionContext context)? precondition,
    Function(ExecutionContext context)? onStarted,
    Function(ExecutionContext context)? onSucceeded,
    Function(ExecutionContext context, dynamic error, StackTrace stackTrace)?
        onError,
    Function(ExecutionContext context)? onCompleted,
    SkipConfiguration? skipConfig,
    RetryConfiguration? retryConfig,
    List<BaseStep> branchesOnSucceeded = const [],
    List<BaseStep> branchesOnFailed = const [],
    List<BaseStep> branchesOnCompleted = const [],
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
          branchesOnSucceeded: branchesOnSucceeded,
          branchesOnFailed: branchesOnFailed,
          branchesOnCompleted: branchesOnCompleted,
        );

  /// Returns the tasks.
  final List<dynamic> _tasks;

  /// Returns the copied tasks.
  List<dynamic> get tasks => List.from(_tasks);
}
