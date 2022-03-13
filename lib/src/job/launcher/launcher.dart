// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/batch_instance.dart';
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:batch/src/job/context/context_support.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/entity.dart';
import 'package:batch/src/job/process_status.dart';
import 'package:batch/src/log/logger_provider.dart';
import 'package:batch/src/runner.dart';

abstract class Launcher<T extends Entity<T>> extends ContextSupport<T>
    implements Runner {
  /// Returns the new instance of [Launcher].
  Launcher({
    required ExecutionContext context,
  }) : super(context: context);

  Future<void> executeRecursively({
    required T entity,
    required Function(dynamic entity) execute,
  }) async {
    entity.onStarted?.call(context);
    super.startNewExecution(name: entity.name);

    if (!await entity.shouldLaunch()) {
      info('Skipped ${entity.name} because the precondition is not met.');
      super.finishExecution(name: entity.name, status: ProcessStatus.skipped);
      return;
    }

    if (BatchInstance.instance.isShuttingDown) {
      info(
          'Skipped ${entity.name} because this batch application is shutting down.');
      super.finishExecution(name: entity.name, status: ProcessStatus.skipped);
      return;
    }

    try {
      await execute.call(entity);
      entity.onSucceeded?.call(context);

      if (BatchInstance.instance.isRunning) {
        if (entity.hasBranch) {
          for (final branch in entity.branches) {
            if (branch.on == super.branchStatus ||
                branch.on == BranchStatus.completed) {
              await executeRecursively(entity: branch.to, execute: execute);
            }
          }
        }
      }

      super.finishExecution(name: entity.name);
    } catch (error, stackTrace) {
      entity.onError?.call(context, error, stackTrace);

      //! Do not skip if it is an Error.
      //! Only Exception can be skipped.
      if (error is Exception) {
        if (entity.skipPolicy.shouldSkip(error)) {
          warn(
            'An exception is detected on Entity [name=${entity.name}] but processing continues because it can be skipped',
            error,
            stackTrace,
          );

          super.finishExecution(
            name: entity.name,
            status: ProcessStatus.skipped,
          );

          return;
        }
      }

      rethrow;
    } finally {
      entity.onCompleted?.call(context);
    }
  }
}
