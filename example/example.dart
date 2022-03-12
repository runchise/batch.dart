// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/batch.dart';

void main(List<String> args) => BatchApplication(
      logConfig: LogConfiguration(
        level: LogLevel.trace,
        output: ConsoleLogOutput(),
        color: LogColor(
          info: ConsoleColor.cyan3,
        ),
        printLog: true,
      ),
    )
      // You can add any parameters that is shared in this batch application.
      ..addSharedParameter(key: 'key1', value: 'value1')
      ..addSharedParameter(key: 'key2', value: {'any': 'object'})
      ..addJob(_buildTestJob1())
      ..addJob(_buildTestJob2())
      ..run();

Job _buildTestJob1() => Job(
      name: 'Job1',
      schedule: CronParser(value: '*/1 * * * *'),
      // You can define callbacks for each processing phase.
      onStarted: (context) =>
          info('\n--------------- Job1 has started! ---------------'),
      onCompleted: (context) =>
          info('\n--------------- Job1 has completed! ---------------'),
      skipConfig: SkipConfiguration(
        skippableExceptions: [Exception()],
      ),
    )
      ..nextStep(
        Step(name: 'Step1')
          ..nextTask(TestTask())
          ..nextTask(SayHelloTask())
          ..nextTask(SayWorldTask()),
      )
      ..nextStep(
        Step(name: 'Step2')
          ..nextTask(TestTask())
          ..nextTask(SayHelloTask())
          ..nextTask(SayWorldTask())
          ..branchOnSucceeded(
            to: Step(name: 'Step3')
              ..nextTask(TestTask())
              ..nextTask(SayHelloTask())
              ..nextTask(SayWorldTask()),
          )
          ..branchOnFailed(
            to: Step(name: 'Step4')
              ..nextTask(TestTask())
              ..nextTask(SayHelloTask())
              ..branchOnCompleted(
                to: Step(
                  name: 'Step6',
                  // You can set any preconditions to run Step.
                  precondition: () => false,
                )
                  ..nextTask(TestTask())
                  ..nextTask(SayHelloTask())
                  ..nextTask(SayWorldTask()),
              ),
          )
          ..branchOnCompleted(
            to: Step(
              name: 'Step5',
              // You can define callbacks for each processing phase.
              onStarted: (context) =>
                  info('\n--------------- Step5 has started! ---------------'),
              onCompleted: (context) => info(
                  '\n--------------- Step5 has completed! ---------------'),
            )
              ..nextTask(TestTask(
                // You can define callbacks for each processing phase.
                onStarted: (context) => info(
                    '\n--------------- TestTask has started! ---------------'),
                onSucceeded: (context) => info(
                    '\n--------------- TestTask has succeeded! ---------------'),
                onError: (context, error, stackTrace) => error(
                  '\n--------------- Error ---------------',
                  error,
                  stackTrace,
                ),
                onCompleted: (context) => info(
                    '\n--------------- TestTask has completed! ---------------'),
              ))
              ..nextTask(SayHelloTask())
              ..nextTask(SayWorldTask()),
          ),
      );

Job _buildTestJob2() => Job(
      name: 'Job2',
      schedule: CronParser(value: '*/2 * * * *'),
      // You can set any preconditions to run Job.
      precondition: () => true,
    )
      ..nextStep(
        Step(name: 'Step1')
          ..nextTask(SayHelloTask())
          ..nextTask(SayWorldTask()),
      )
      ..branchOnSucceeded(
        to: Job(name: 'Job3')
          ..nextStep(
            Step(name: 'Step1')
              ..nextTask(SayHelloTask())
              ..nextTask(SayWorldTask())
              ..shutdown(),
          ),
      );

class TestTask extends Task<TestTask> {
  TestTask({
    Function(ExecutionContext context)? onStarted,
    Function(ExecutionContext context)? onSucceeded,
    Function(ExecutionContext context, dynamic error, StackTrace stackTrace)?
        onError,
    Function(ExecutionContext context)? onCompleted,
  }) : super(
          onStarted: onStarted,
          onSucceeded: onSucceeded,
          onError: onError,
          onCompleted: onCompleted,
        );

  @override
  void execute(ExecutionContext context) {
    // This parameter is shared just in this job.
    context.jobParameters['key'] = 'job_parameter';
    // This parameter is shared just in this step.
    context.stepParameters['key'] = 'step_parameter';

    // You can use shared parameters in any places.
    info(context.sharedParameters['key1']);
    info(context.sharedParameters['key2']);

    trace('Trace');
    info('Info');
    debug('Debug');
    warn('Warn');
    error('Error');
    fatal('Fatal');
  }
}

class SayHelloTask extends Task<SayHelloTask> {
  @override
  void execute(ExecutionContext context) {
    debug('Hello,');
  }
}

class SayWorldTask extends Task<SayWorldTask> {
  @override
  void execute(ExecutionContext context) {
    info('World!');
    context.jobExecution!.branchToSucceeded();
    context.stepExecution!.branchToFailed();
  }
}
