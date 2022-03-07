// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/entity.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/entity/step.dart';
import 'package:batch/src/job/execution.dart';
import 'package:batch/src/job/parameter/shared_parameters.dart';
import 'package:batch/src/job/process_status.dart';
import 'package:batch/src/log/logger_provider.dart';

abstract class ContextSupport<T extends Entity<T>> {
  /// Returns the new instance of [ContextSupport].
  ContextSupport({
    required this.context,
  });

  /// The execution context
  final ExecutionContext context;

  void startNewExecution({required String name}) {
    if (T == Job) {
      context.jobExecution = Execution(name: name, startedAt: DateTime.now());
      info(
          'Job:  [name=$name] launched with the following shared parameters: ${SharedParameters.instance}');
    } else if (T == Step) {
      context.stepExecution = Execution(name: name, startedAt: DateTime.now());
      info(
          'Step: [name=$name] launched with the following job parameters: ${context.jobParameters}');
    } else {
      context.taskExecution = Execution(name: name, startedAt: DateTime.now());
      info(
          'Task: [name=$name] launched with the following step parameters: ${context.stepParameters}');
    }
  }

  void finishExecution({ProcessStatus? status}) {
    if (T == Job) {
      context.jobExecution = Execution(
        name: context.jobExecution!.name,
        status: status ?? ProcessStatus.completed,
        startedAt: context.jobExecution!.startedAt,
        updatedAt: DateTime.now(),
        finishedAt: DateTime.now(),
      );
      info(
          'Job:  [name=${context.jobExecution!.name}] finished with the following shared parameters: ${SharedParameters.instance} and the status: [${context.jobExecution!.status.name}]');
    } else if (T == Step) {
      context.stepExecution = Execution(
        name: context.stepExecution!.name,
        status: status ?? ProcessStatus.completed,
        startedAt: context.stepExecution!.startedAt,
        updatedAt: DateTime.now(),
        finishedAt: DateTime.now(),
      );

      info(
          'Step: [name=${context.stepExecution!.name}] finished with the following job parameters: ${context.jobParameters} and the status: [${context.stepExecution!.status.name}]');
    } else {
      context.taskExecution = Execution(
        name: context.taskExecution!.name,
        status: status ?? ProcessStatus.completed,
        startedAt: context.taskExecution!.startedAt,
        updatedAt: DateTime.now(),
        finishedAt: DateTime.now(),
      );

      info(
          'Task: [name=${context.taskExecution!.name}] finished with the following step parameters: ${context.stepParameters} and the status: [${context.taskExecution!.status.name}]');
    }
  }

  BranchStatus get branchStatus {
    if (T == Job) {
      return context.jobExecution!.branchStatus;
    } else if (T == Step) {
      return context.stepExecution!.branchStatus;
    }

    return context.taskExecution!.branchStatus;
  }
}
