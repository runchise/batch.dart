// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:batch/src/job/context/context_helper.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/entity.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/entity/step.dart';
import 'package:batch/src/job/launcher/step_launcher.dart';
import 'package:batch/src/job/launcher/task_launcher.dart';
import 'package:batch/src/job/repeat_status.dart';
import 'package:batch/src/log/logger_provider.dart';

abstract class Launcher<T extends Entity<T>> extends ContextHelper<T> {
  /// Returns the new instance of [Launcher].
  Launcher({
    required ExecutionContext context,
  }) : super(context: context);

  void execute();

  Future<void> executeRecursively({required T entity}) async {
    if (!entity.canLaunch()) {
      info('Skipped ${entity.name} because the precondition is not met.');
      return;
    }

    await _execute(entity: entity);

    if (entity.hasBranch) {
      for (final branch in entity.branches) {
        if (branch.on == super.branchStatus ||
            branch.on == BranchStatus.completed) {
          await executeRecursively(entity: branch.to);
        }
      }
    }

    super.resetBranchStatus();
  }

  Future<void> _execute({required dynamic entity}) async {
    super.startNewExecution(name: entity.name);

    if (entity is Job) {
      await StepLauncher(
        context: super.context,
        steps: entity.steps,
        parentJobName: entity.name,
      ).execute();
    } else if (entity is Step) {
      await TaskLauncher(
        context: super.context,
        tasks: entity.tasks,
      ).execute();
    } else {
      RepeatStatus repeatStatus = RepeatStatus.continuable;
      do {
        repeatStatus = await entity.execute(super.context);
      } while (repeatStatus.isContinuable);
    }

    super.finishExecution();
  }
}
