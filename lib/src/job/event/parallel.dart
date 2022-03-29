// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/event/event.dart';
import 'package:batch/src/job/task/parallel_task.dart';

class Parallel extends Event<Parallel> {
  /// Returns the new instance of [Parallel].
  Parallel({
    required String name,
    required this.tasks,
    FutureOr<bool> Function()? precondition,
    Function(ExecutionContext context)? onStarted,
    Function(ExecutionContext context)? onSucceeded,
    Function(ExecutionContext context, dynamic error, StackTrace stackTrace)?
        onError,
    Function(ExecutionContext context)? onCompleted,
  }) : super(
          name: name,
          precondition: precondition,
          onStarted: onStarted,
          onSucceeded: onSucceeded,
          onError: onError,
          onCompleted: onCompleted,
        );

  /// The parallel tasks
  final List<ParallelTask> tasks;

  @override
  @Deprecated('not supported operation and always UnsupportedError throws')
  void branchOnSucceeded({required Parallel to}) =>
      UnsupportedError('Branch feature is not supported for parallel.');

  @override
  @Deprecated('not supported and always UnsupportedError throws')
  void branchOnFailed({required Parallel to}) =>
      UnsupportedError('Branch feature is not supported for parallel.');

  @override
  @Deprecated('not supported and always UnsupportedError throws')
  void branchOnCompleted({required Parallel to}) =>
      UnsupportedError('Branch feature is not supported for parallel.');
}
