// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:batch/src/job/context/context_helper.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/entity.dart';
import 'package:batch/src/log/logger_provider.dart';
import 'package:batch/src/runner.dart';

abstract class Launcher<T extends Entity<T>> extends ContextHelper<T>
    implements Runner {
  /// Returns the new instance of [Launcher].
  Launcher({
    required ExecutionContext context,
  }) : super(context: context);

  Future<void> executeRecursively({
    required T entity,
    required Function(dynamic entity) execute,
  }) async {
    if (!entity.canLaunch()) {
      info('Skipped ${entity.name} because the precondition is not met.');
      return;
    }

    super.startNewExecution(name: entity.name);

    try {
      entity.onStarted?.call(context);

      await execute.call(entity);

      entity.onSucceeded?.call(context);
    } catch (error, stackTrace) {
      entity.onFailed?.call(context, error, stackTrace);
    } finally {
      entity.onCompleted?.call(context);
    }

    super.finishExecution();

    if (entity.hasBranch) {
      for (final branch in entity.branches) {
        if (branch.on == super.branchStatus ||
            branch.on == BranchStatus.completed) {
          await executeRecursively(entity: branch.to, execute: execute);
        }
      }
    }

    super.resetBranchStatus();
  }
}
