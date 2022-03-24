// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/execution.dart';
import 'package:batch/src/job/parameter/shared_parameters.dart';

void main() {
  test('Test without parameters', () {
    final context = ExecutionContext();
    expect(context.jobExecution, null);
    expect(context.stepExecution, null);
    expect(context.taskExecution, null);
    expect(context.sharedParameters, SharedParameters.instance);
    expect(context.jobParameters.isEmpty, true);
    expect(context.stepParameters.isEmpty, true);
  });

  test('Test with executions', () {
    final context = ExecutionContext();
    final now = DateTime.now();
    context.jobExecution = Execution(name: 'Job', startedAt: now);
    context.stepExecution = Execution(name: 'Step', startedAt: now);
    context.taskExecution = Execution(name: 'Task', startedAt: now);

    expect(context.jobExecution!.name, 'Job');
    expect(context.stepExecution!.name, 'Step');
    expect(context.taskExecution!.name, 'Task');
    expect(context.sharedParameters, SharedParameters.instance);
    expect(context.jobParameters.isEmpty, true);
    expect(context.stepParameters.isEmpty, true);
  });

  test('Test with sharedParameters', () {
    final context = ExecutionContext();
    expect(context.sharedParameters, SharedParameters.instance);
    expect(context.sharedParameters.isEmpty, true);
    expect(context.sharedParameters.isNotEmpty, false);

    context.sharedParameters['test'] = true;

    expect(context.sharedParameters.isEmpty, false);
    expect(context.sharedParameters.isNotEmpty, true);
    expect(context.sharedParameters['test'], true);
  });

  test('Test with jobParameters', () {
    final context = ExecutionContext();
    expect(context.jobParameters != context.sharedParameters, true);
    expect(context.jobParameters != context.stepParameters, true);
    expect(context.jobParameters.isEmpty, true);
    expect(context.jobParameters.isNotEmpty, false);

    context.jobParameters['test'] = true;

    expect(context.jobParameters.isEmpty, false);
    expect(context.jobParameters.isNotEmpty, true);
    expect(context.jobParameters['test'], true);
  });

  test('Test with stepParameters', () {
    final context = ExecutionContext();
    expect(context.stepParameters != context.sharedParameters, true);
    expect(context.stepParameters != context.jobParameters, true);
    expect(context.stepParameters.isEmpty, true);
    expect(context.stepParameters.isNotEmpty, false);

    context.stepParameters['test'] = true;

    expect(context.stepParameters.isEmpty, false);
    expect(context.stepParameters.isNotEmpty, true);
    expect(context.stepParameters['test'], true);
  });
}
