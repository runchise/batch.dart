// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/execution_context.dart';
import 'package:batch/src/job/repeat_status.dart';
import 'package:batch/src/job/task.dart';

class TaskLauncher {
  /// Returns the new instance of [TaskLauncher].
  TaskLauncher({
    required this.context,
    required this.tasks,
  });

  /// The execution context
  final ExecutionContext context;

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
      RepeatStatus repeatStatus = RepeatStatus.continuable;
      do {
        repeatStatus = await task.execute(context);
      } while (repeatStatus.isContinuable);
    }
  }
}
