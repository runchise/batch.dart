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
import 'package:batch/src/job/process_status.dart';
import 'package:batch/src/job/repository/service/job_parameters.dart';
import 'package:batch/src/job/repository/service/shared_parameters.dart';
import 'package:batch/src/job/repository/service/step_parameters.dart';
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
          'Job: [name=$name] launched with the following shared parameters: ${SharedParameters.instance.records}');
    } else if (T == Step) {
      context.stepExecution = Execution(name: name, startedAt: DateTime.now());
      info(
          'Executing Step: [${context.jobExecution!.name} -> $name] with the following job parameters: ${JobParameters.instance.records}');
    } else {
      context.taskExecution = Execution(name: name, startedAt: DateTime.now());
      info(
          'Executing Task: [${context.jobExecution!.name} -> ${context.stepExecution!.name} -> $name] with the following step parameters: ${StepParameters.instance.records}');
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
      info('Finished Job [${context.jobExecution!.name}]');
    } else if (T == Step) {
      context.stepExecution = Execution(
        name: context.stepExecution!.name,
        status: ProcessStatus.completed,
        startedAt: context.stepExecution!.startedAt,
        finishedAt: DateTime.now(),
      );

      info(
          'Finished Step [${context.jobExecution!.name} -> ${context.stepExecution!.name}]');
    } else {
      context.taskExecution = Execution(
        name: context.taskExecution!.name,
        status: ProcessStatus.completed,
        startedAt: context.taskExecution!.startedAt,
        finishedAt: DateTime.now(),
      );

      info(
          'Finished Task [${context.jobExecution!.name} -> ${context.stepExecution!.name} -> ${context.taskExecution!.name}]');
    }
  }

  void resetBranchStatus() {
    if (T == Job) {
      context.branchContribution.jobStatus = BranchStatus.succeeded;
    } else if (T == Step) {
      context.branchContribution.stepStatus = BranchStatus.succeeded;
    } else {
      context.branchContribution.taskStatus = BranchStatus.succeeded;
    }
  }

  BranchStatus get branchStatus {
    if (T == Job) {
      return context.branchContribution.jobStatus;
    } else if (T == Step) {
      return context.branchContribution.stepStatus;
    }

    return context.branchContribution.taskStatus;
  }
}
