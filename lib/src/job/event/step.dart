// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:batch/src/job/config/retry_configuration.dart';
import 'package:batch/src/job/config/skip_configuration.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/event/base_step.dart';
import 'package:batch/src/job/task/shutdown_task.dart';
import 'package:batch/src/job/task/task.dart';

/// It represents the step responsible for the sequential process.
///
/// This step has a single [task] and is processed in sequential.
class Step extends BaseStep {
  /// Returns the new instance of [Step].
  Step({
    required String name,
    required Task task,
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
  }) : super(
          name: name,
          tasks: [task],
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

  /// Returns the new instance of [Step].
  Step.ofShutdown({String name = 'Shutdown Step'})
      : super(name: name, tasks: [ShutdownTask()]);
}
