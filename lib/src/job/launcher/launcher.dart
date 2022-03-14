// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/batch_instance.dart';
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:batch/src/job/context/context_support.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/entity.dart';
import 'package:batch/src/log/logger_provider.dart' as log;
import 'package:batch/src/runner.dart';

abstract class Launcher<T extends Entity<T>> extends ContextSupport<T>
    implements Runner {
  /// Returns the new instance of [Launcher].
  Launcher({
    required ExecutionContext context,
  }) : super(context: context);

  /// The retry count
  int _retryCount = 0;

  Future<bool> executeRecursively({
    required T entity,
    required Function(dynamic entity) execute,
    bool retry = false,
  }) async {
    if (!retry) {
      await entity.onStarted?.call(context);
    }

    super.startNewExecution(name: entity.name, retry: retry);

    if (!await entity.shouldLaunch()) {
      log.info('Skipped ${entity.name} because the precondition is not met.');
      super.finishExecutionAsSkipped(name: entity.name, retry: retry);
      return true;
    }

    if (BatchInstance.instance.isShuttingDown) {
      log.info(
          'Skipped ${entity.name} because this batch application is shutting down.');
      super.finishExecutionAsSkipped(name: entity.name, retry: retry);
      return true;
    }

    try {
      await execute.call(entity);
      await entity.onSucceeded?.call(context);

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

      _retryCount = 0;
      super.finishExecutionAsCompleted(name: entity.name, retry: retry);

      return true;
    } catch (error, stackTrace) {
      await entity.onError?.call(context, error, stackTrace);

      //! Do not skip and retry if it is an Error.
      //! Only Exception can be skipped and retried.
      if (error is Exception) {
        if (entity.hasSkipPolicy && entity.skipPolicy!.shouldSkip(error)) {
          log.warn(
            'An exception is detected on Entity [name=${entity.name}] but processing continues because it can be skipped',
            error,
            stackTrace,
          );

          super.finishExecutionAsSkipped(name: entity.name, retry: retry);

          return true;
        } else if (entity.hasRetryPolicy &&
            entity.retryPolicy!.shouldRetry(error)) {
          if (entity.retryPolicy!.isExceeded(_retryCount)) {
            log.error(
              'The maximum number of retry attempts has been reached on Entity [name=${entity.name}]',
              error,
              stackTrace,
            );

            rethrow;
          }

          log.warn(
            'An exception is detected on Entity [name=${entity.name}] but processing retries',
            error,
            stackTrace,
          );

          await entity.retryPolicy!.wait();
          _retryCount++;

          if (await executeRecursively(
            entity: entity,
            execute: execute,
            retry: true,
          )) {
            if (!retry) {
              super.finishExecutionAsCompleted(name: entity.name, retry: retry);
            }

            return true;
          }
        }

        rethrow;
      }
    } finally {
      if (!retry) {
        await entity.onCompleted?.call(context);
      }
    }

    return true;
  }
}
