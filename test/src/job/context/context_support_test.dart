// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:batch/src/job/context/context_support.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/entity/step.dart';
import 'package:batch/src/job/entity/task.dart';
import 'package:batch/src/log/log_configuration.dart';
import 'package:batch/src/log/logger.dart';

void main() {
  //! Required to load logger to run ContextSupport.
  Logger.loadFrom(config: LogConfiguration(printLog: false));

  group('Test ContextSupport for Job', () {
    test('Test when not a retry and complete', () {
      final contextSupport = _JobContextSupport();
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);

      contextSupport.startNewExecution(name: 'Job', retry: false);
      expect(contextSupport.context.jobExecution!.name, 'Job');
      expect(contextSupport.context.jobExecution!.isRunning, true);
      expect(contextSupport.context.jobExecution!.isCompleted, false);
      expect(contextSupport.context.jobExecution!.isSkipped, false);
      expect(contextSupport.context.jobExecution!.updatedAt, null);
      expect(contextSupport.context.jobExecution!.finishedAt, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);
      expect(contextSupport.branchStatus, BranchStatus.completed);

      // Try to change branch status.
      contextSupport.context.jobExecution!.branchToSucceeded();
      expect(contextSupport.branchStatus, BranchStatus.succeeded);
      contextSupport.context.jobExecution!.branchToFailed();
      expect(contextSupport.branchStatus, BranchStatus.failed);

      contextSupport.finishExecutionAsCompleted(retry: false);
      expect(contextSupport.context.jobExecution!.name, 'Job');
      expect(contextSupport.context.jobExecution!.isRunning, false);
      expect(contextSupport.context.jobExecution!.isCompleted, true);
      expect(contextSupport.context.jobExecution!.isSkipped, false);
      expect(contextSupport.context.jobExecution!.updatedAt != null, true);
      expect(contextSupport.context.jobExecution!.finishedAt != null, true);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);
    });

    test('Test when a retry and skip', () {
      final contextSupport = _JobContextSupport();
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);

      contextSupport.startNewExecution(name: 'Job', retry: false);
      expect(contextSupport.context.jobExecution!.name, 'Job');
      expect(contextSupport.context.jobExecution!.isRunning, true);
      expect(contextSupport.context.jobExecution!.isCompleted, false);
      expect(contextSupport.context.jobExecution!.isSkipped, false);
      expect(contextSupport.context.jobExecution!.updatedAt, null);
      expect(contextSupport.context.jobExecution!.finishedAt, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);
      expect(contextSupport.branchStatus, BranchStatus.completed);

      // Try to change branch status.
      contextSupport.context.jobExecution!.branchToSucceeded();
      expect(contextSupport.branchStatus, BranchStatus.succeeded);
      expect(contextSupport.context.jobExecution!.updatedAt != null, true);
      contextSupport.context.jobExecution!.branchToFailed();
      expect(contextSupport.branchStatus, BranchStatus.failed);
      expect(contextSupport.context.jobExecution!.updatedAt != null, true);

      // Should skip create new and finish execution on retry
      contextSupport.startNewExecution(name: 'Job2', retry: true);
      expect(contextSupport.context.jobExecution!.name, 'Job');
      expect(contextSupport.context.jobExecution!.isRunning, true);
      expect(contextSupport.context.jobExecution!.isCompleted, false);
      expect(contextSupport.context.jobExecution!.isSkipped, false);
      expect(contextSupport.context.jobExecution!.updatedAt != null, true);
      expect(contextSupport.context.jobExecution!.finishedAt, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);
      expect(contextSupport.branchStatus, BranchStatus.failed);
      contextSupport.finishExecutionAsCompleted(retry: true);
      expect(contextSupport.context.jobExecution!.name, 'Job');

      contextSupport.finishExecutionAsSkipped(retry: false);
      expect(contextSupport.context.jobExecution!.name, 'Job');
      expect(contextSupport.context.jobExecution!.isRunning, false);
      expect(contextSupport.context.jobExecution!.isCompleted, false);
      expect(contextSupport.context.jobExecution!.isSkipped, true);
      expect(contextSupport.context.jobExecution!.updatedAt != null, true);
      expect(contextSupport.context.jobExecution!.finishedAt != null, true);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);
    });
  });

  group('Test ContextSupport for Step', () {
    test('Test when not a retry and complete', () {
      final contextSupport = _StepContextSupport(context: ExecutionContext());
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);

      contextSupport.startNewExecution(name: 'Step', retry: false);
      expect(contextSupport.context.stepExecution!.name, 'Step');
      expect(contextSupport.context.stepExecution!.isRunning, true);
      expect(contextSupport.context.stepExecution!.isCompleted, false);
      expect(contextSupport.context.stepExecution!.isSkipped, false);
      expect(contextSupport.context.stepExecution!.updatedAt, null);
      expect(contextSupport.context.stepExecution!.finishedAt, null);
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.taskExecution, null);
      expect(contextSupport.branchStatus, BranchStatus.completed);

      // Try to change branch status.
      contextSupport.context.stepExecution!.branchToSucceeded();
      expect(contextSupport.branchStatus, BranchStatus.succeeded);
      contextSupport.context.stepExecution!.branchToFailed();
      expect(contextSupport.branchStatus, BranchStatus.failed);

      contextSupport.finishExecutionAsCompleted(retry: false);
      expect(contextSupport.context.stepExecution!.name, 'Step');
      expect(contextSupport.context.stepExecution!.isRunning, false);
      expect(contextSupport.context.stepExecution!.isCompleted, true);
      expect(contextSupport.context.stepExecution!.isSkipped, false);
      expect(contextSupport.context.stepExecution!.updatedAt != null, true);
      expect(contextSupport.context.stepExecution!.finishedAt != null, true);
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.taskExecution, null);
    });

    test('Test when a retry and skip', () {
      final contextSupport = _StepContextSupport(context: ExecutionContext());
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);

      contextSupport.startNewExecution(name: 'Step', retry: false);
      expect(contextSupport.context.stepExecution!.name, 'Step');
      expect(contextSupport.context.stepExecution!.isRunning, true);
      expect(contextSupport.context.stepExecution!.isCompleted, false);
      expect(contextSupport.context.stepExecution!.isSkipped, false);
      expect(contextSupport.context.stepExecution!.updatedAt, null);
      expect(contextSupport.context.stepExecution!.finishedAt, null);
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.taskExecution, null);
      expect(contextSupport.branchStatus, BranchStatus.completed);

      // Try to change branch status.
      contextSupport.context.stepExecution!.branchToSucceeded();
      expect(contextSupport.branchStatus, BranchStatus.succeeded);
      expect(contextSupport.context.stepExecution!.updatedAt != null, true);
      contextSupport.context.stepExecution!.branchToFailed();
      expect(contextSupport.branchStatus, BranchStatus.failed);
      expect(contextSupport.context.stepExecution!.updatedAt != null, true);

      // Should skip create new and finish execution on retry
      contextSupport.startNewExecution(name: 'Step2', retry: true);
      expect(contextSupport.context.stepExecution!.name, 'Step');
      expect(contextSupport.context.stepExecution!.isRunning, true);
      expect(contextSupport.context.stepExecution!.isCompleted, false);
      expect(contextSupport.context.stepExecution!.isSkipped, false);
      expect(contextSupport.context.stepExecution!.updatedAt != null, true);
      expect(contextSupport.context.stepExecution!.finishedAt, null);
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.taskExecution, null);
      expect(contextSupport.branchStatus, BranchStatus.failed);
      contextSupport.finishExecutionAsCompleted(retry: true);
      expect(contextSupport.context.stepExecution!.name, 'Step');

      contextSupport.finishExecutionAsSkipped(retry: false);
      expect(contextSupport.context.stepExecution!.name, 'Step');
      expect(contextSupport.context.stepExecution!.isRunning, false);
      expect(contextSupport.context.stepExecution!.isCompleted, false);
      expect(contextSupport.context.stepExecution!.isSkipped, true);
      expect(contextSupport.context.stepExecution!.updatedAt != null, true);
      expect(contextSupport.context.stepExecution!.finishedAt != null, true);
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.taskExecution, null);
    });
  });

  group('Test ContextSupport for Task', () {
    test('Test when not a retry and complete', () {
      final contextSupport = _TaskContextSupport(context: ExecutionContext());
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);

      contextSupport.startNewExecution(name: 'Task', retry: false);
      expect(contextSupport.context.taskExecution!.name, 'Task');
      expect(contextSupport.context.taskExecution!.isRunning, true);
      expect(contextSupport.context.taskExecution!.isCompleted, false);
      expect(contextSupport.context.taskExecution!.isSkipped, false);
      expect(contextSupport.context.taskExecution!.updatedAt, null);
      expect(contextSupport.context.taskExecution!.finishedAt, null);
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.branchStatus, BranchStatus.completed);

      // Try to change branch status.
      contextSupport.context.taskExecution!.branchToSucceeded();
      expect(contextSupport.branchStatus, BranchStatus.succeeded);
      contextSupport.context.taskExecution!.branchToFailed();
      expect(contextSupport.branchStatus, BranchStatus.failed);

      contextSupport.finishExecutionAsCompleted(retry: false);
      expect(contextSupport.context.taskExecution!.name, 'Task');
      expect(contextSupport.context.taskExecution!.isRunning, false);
      expect(contextSupport.context.taskExecution!.isCompleted, true);
      expect(contextSupport.context.taskExecution!.isSkipped, false);
      expect(contextSupport.context.taskExecution!.updatedAt != null, true);
      expect(contextSupport.context.taskExecution!.finishedAt != null, true);
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
    });

    test('Test when a retry and skip', () {
      final contextSupport = _TaskContextSupport(context: ExecutionContext());
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.context.taskExecution, null);

      contextSupport.startNewExecution(name: 'Task', retry: false);
      expect(contextSupport.context.taskExecution!.name, 'Task');
      expect(contextSupport.context.taskExecution!.isRunning, true);
      expect(contextSupport.context.taskExecution!.isCompleted, false);
      expect(contextSupport.context.taskExecution!.isSkipped, false);
      expect(contextSupport.context.taskExecution!.updatedAt, null);
      expect(contextSupport.context.taskExecution!.finishedAt, null);
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.branchStatus, BranchStatus.completed);

      // Try to change branch status.
      contextSupport.context.taskExecution!.branchToSucceeded();
      expect(contextSupport.branchStatus, BranchStatus.succeeded);
      expect(contextSupport.context.taskExecution!.updatedAt != null, true);
      contextSupport.context.taskExecution!.branchToFailed();
      expect(contextSupport.branchStatus, BranchStatus.failed);
      expect(contextSupport.context.taskExecution!.updatedAt != null, true);

      // Should skip create new and finish execution on retry
      contextSupport.startNewExecution(name: 'Task2', retry: true);
      expect(contextSupport.context.taskExecution!.name, 'Task');
      expect(contextSupport.context.taskExecution!.isRunning, true);
      expect(contextSupport.context.taskExecution!.isCompleted, false);
      expect(contextSupport.context.taskExecution!.isSkipped, false);
      expect(contextSupport.context.taskExecution!.updatedAt != null, true);
      expect(contextSupport.context.taskExecution!.finishedAt, null);
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
      expect(contextSupport.branchStatus, BranchStatus.failed);
      contextSupport.finishExecutionAsCompleted(retry: true);
      expect(contextSupport.context.taskExecution!.name, 'Task');

      contextSupport.finishExecutionAsSkipped(retry: false);
      expect(contextSupport.context.taskExecution!.name, 'Task');
      expect(contextSupport.context.taskExecution!.isRunning, false);
      expect(contextSupport.context.taskExecution!.isCompleted, false);
      expect(contextSupport.context.taskExecution!.isSkipped, true);
      expect(contextSupport.context.taskExecution!.updatedAt != null, true);
      expect(contextSupport.context.taskExecution!.finishedAt != null, true);
      expect(contextSupport.context.jobExecution, null);
      expect(contextSupport.context.stepExecution, null);
    });
  });
}

class _JobContextSupport extends ContextSupport<Job> {
  _JobContextSupport() : super(context: ExecutionContext());
}

class _StepContextSupport extends ContextSupport<Step> {
  _StepContextSupport({required ExecutionContext context})
      : super(context: context);
}

class _TaskContextSupport extends ContextSupport<Task> {
  _TaskContextSupport({required ExecutionContext context})
      : super(context: context);
}
