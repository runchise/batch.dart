// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/context/execution_stack.dart';
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

  /// The execution stack
  final ExecutionStack _executionStack = ExecutionStack();

  void startNewExecution({required String name}) {
    if (T == Job) {
      context.jobExecution = _newExecution(name);
      info(
          'Job:  [name=$name] launched with the following shared parameters: ${SharedParameters.instance}');
    } else if (T == Step) {
      context.stepExecution = _newExecution(name);
      info(
          'Step: [name=$name] launched with the following job parameters: ${context.jobParameters}');
    } else {
      context.taskExecution = _newExecution(name);
      info(
          'Task: [name=$name] launched with the following step parameters: ${context.stepParameters}');
    }
  }

  void finishExecution({required String name, ProcessStatus? status}) {
    if (T == Job) {
      context.jobExecution = _finishedExecution(status: status);
      info(
          'Job:  [name=$name] finished with the following shared parameters: ${SharedParameters.instance} and the status: [${(status ?? ProcessStatus.completed).name}]');
    } else if (T == Step) {
      context.stepExecution = _finishedExecution(status: status);
      info(
          'Step: [name=$name] finished with the following job parameters: ${context.jobParameters} and the status: [${(status ?? ProcessStatus.completed).name}]');
    } else {
      context.taskExecution = _finishedExecution(status: status);
      info(
          'Task: [name=$name] finished with the following step parameters: ${context.stepParameters} and the status: [${(status ?? ProcessStatus.completed).name}]');
    }
  }

  dynamic _newExecution(final String name) {
    final execution = Execution<T>(name: name, startedAt: DateTime.now());
    _executionStack.push(execution);
    return execution;
  }

  dynamic _finishedExecution({required ProcessStatus? status}) {
    final execution = _executionStack.pop();

    return Execution<T>(
      name: execution.name,
      status: status ?? ProcessStatus.completed,
      startedAt: execution.startedAt,
      updatedAt: DateTime.now(),
      finishedAt: DateTime.now(),
    );
  }

  BranchStatus get branchStatus {
    final execution = _executionStack.pop();
    _executionStack.push(execution);
    return execution.branchStatus;
  }
}
