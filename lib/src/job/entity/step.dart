// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/entity.dart';
import 'package:batch/src/job/entity/task.dart';
import 'package:batch/src/job/precondition.dart';

/// This class represents the processing of each step that constitutes a job in batch processing.
class Step extends Entity<Step> {
  /// Returns the new instance of [Step].
  Step({
    required String name,
    Precondition? precondition,
    Function(ExecutionContext context)? onStarted,
    Function(ExecutionContext context)? onSucceeded,
    Function(ExecutionContext context, dynamic error, StackTrace stackTrace)?
        onFailed,
    Function(ExecutionContext context)? onCompleted,
  }) : super(
          name: name,
          precondition: precondition,
          onStarted: onStarted,
          onSucceeded: onSucceeded,
          onFailed: onFailed,
          onCompleted: onCompleted,
        );

  /// The tasks
  final List<Task> tasks = [];

  /// Adds next [Task].
  ///
  /// Tasks added by this [nextTask] method are executed in the order in which they are stored.
  void nextTask(final Task task) => tasks.add(task);
}
