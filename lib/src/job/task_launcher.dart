// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/const/repeat_status.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/context/context_helper.dart';
import 'package:batch/src/job/entity/task.dart';

class TaskLauncher extends ContextHelper<Task> {
  /// Returns the new instance of [TaskLauncher].
  TaskLauncher({
    required ExecutionContext context,
    required this.tasks,
  }) : super(context: context);

  /// The tasks
  final List<Task> tasks;

  /// Runs all tasks.
  Future<void> execute() async {
    if (tasks.isEmpty) {
      throw Exception(
        'Register the task to be launched is required.',
      );
    }

    for (final task in tasks) {
      super.startNewExecution(name: task.name);

      RepeatStatus repeatStatus = RepeatStatus.continuable;
      do {
        repeatStatus = await task.execute(super.context);
      } while (repeatStatus.isContinuable);

      super.finishExecution();
    }

    super.clearParameters();
  }
}
