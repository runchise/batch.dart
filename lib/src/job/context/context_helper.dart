// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/const/branch_status.dart';
import 'package:batch/src/job/const/process_status.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/entity.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/entity/step.dart';
import 'package:batch/src/job/execution.dart';
import 'package:batch/src/log/logger_provider.dart';

abstract class ContextHelper<T extends Entity<T>> {
  /// Returns the new instance of [ContextHelper].
  ContextHelper({
    required this.context,
  });

  /// The execution context
  final ExecutionContext context;

  void startNewExecution({required String name}) {
    if (T == Job) {
      context.jobExecution = Execution(name: name, startedAt: DateTime.now());
      info('STARTED JOB ($name)');
    } else if (T == Step) {
      context.stepExecution = Execution(name: name, startedAt: DateTime.now());
      info('STARTED STEP (${context.jobExecution!.name} -> $name)');
    } else {
      context.taskExecution = Execution(name: name, startedAt: DateTime.now());
      info(
          'STARTED TASK (${context.jobExecution!.name} -> ${context.stepExecution!.name} -> $name)');
    }
  }

  void finishExecution() {
    if (T == Job) {
      context.jobExecution = Execution(
        name: context.jobExecution!.name,
        status: ProcessStatus.completed,
        startedAt: context.jobExecution!.startedAt,
        finishedAt: DateTime.now(),
      );
      info('FINISHED JOB (${context.jobExecution!.name})');
    } else if (T == Step) {
      context.stepExecution = Execution(
        name: context.stepExecution!.name,
        status: ProcessStatus.completed,
        startedAt: context.stepExecution!.startedAt,
        finishedAt: DateTime.now(),
      );

      info(
          'FINISHED STEP (${context.jobExecution!.name} -> ${context.stepExecution!.name})');
    } else {
      context.taskExecution = Execution(
        name: context.taskExecution!.name,
        status: ProcessStatus.completed,
        startedAt: context.taskExecution!.startedAt,
        finishedAt: DateTime.now(),
      );

      info(
          'FINISHED TASK (${context.jobExecution!.name} -> ${context.stepExecution!.name} -> ${context.taskExecution!.name})');
    }
  }

  void resetBranchStatus() =>
      context.branchContribution.status = BranchStatus.completed;

  void clearParameters() => context.parameters.clear();
}
