// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'dart:async';
import 'dart:io';

import 'package:batch/batch.dart';

void main(List<String> args) => BatchApplication(
      args: _argParser.parse(args),
      logConfig: LogConfiguration(
        level: LogLevel.trace,
        output: MultiLogOutput([
          ConsoleLogOutput(),
          FileLogOutput(file: File('./test.txt')),
        ]),
        color: LogColor(
          info: ConsoleColor.cyan3,
        ),
        printLog: true,
      ),
    )
      // You can add any parameters that is shared in this batch application.
      ..addSharedParameter(key: 'key1', value: 'value1')
      ..addSharedParameter(key: 'key2', value: {'any': 'object'})
      ..addJob(_testJob1)
      ..addJob(_testJob2)
      ..addJob(_testJob4)
      ..run();

ArgParser get _argParser {
  // The well-known "args" library can be used as standard.
  // See more information about "args" at https://pub.dev/packages/args.
  final parser = ArgParser();
  parser.addOption('userName', abbr: 'u');
  parser.addOption('appName', abbr: 'a');
  parser.addFlag('release', abbr: 'r', defaultsTo: false);

  return parser;
}

Job get _testJob1 => Job(
      name: 'Job1',
      schedule: CronParser(value: '*/1 * * * *'),
      // You can define callbacks for each processing phase.
      onStarted: (context) =>
          info('\n--------------- Job1 has started! ---------------'),
      onCompleted: (context) =>
          info('\n--------------- Job1 has completed! ---------------'),
    )
      ..nextStep(
        Step(
          name: 'Step1',
          skipConfig: SkipConfiguration(
            skippableExceptions: [Exception()],
          ),
        )
          ..nextTask(
            RetryTask(
              // You can define callbacks for each processing phase.
              onStarted: (context) => info(
                  '\n--------------- RetryTask has started! ---------------'),
              onSucceeded: (context) => info(
                  '\n--------------- RetryTask has succeeded! ---------------'),
              onError: (context, error, stackTrace) => log.error(
                '\n--------------- Error RetryTask ---------------',
                error,
                stackTrace,
              ),
              onCompleted: (context) => info(
                  '\n--------------- RetryTask has completed! ---------------'),
              retryConfig: RetryConfiguration(
                retryableExceptions: [Exception()],
                backOff: Duration(seconds: 30),
              ),
            ),
          )
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
              ..nextTask(TestTask())
              ..nextTask(SayHelloTask())
              ..nextTask(SayWorldTask()),
          ),
      );

Job get _testJob2 => Job(
      name: 'Job2',
      schedule: CronParser(value: '*/5 * * * *'),
      // You can set any preconditions to run Job.
      precondition: () async => true,
    )
      ..nextStep(
        Step(
          name: 'Step1',
          precondition: () => true,
        )
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

Job get _testJob4 => Job(
      name: 'Job4',
      schedule: CronParser(value: '*/1 * * * *'),
      // You can set any preconditions to run Job.
      precondition: () async => true,
    )..nextStep(
        Step(
          name: 'Parallel Step',
          precondition: () => true,
        )..nextParallel(
            Parallel(
              name: 'Parallel Tasks',
              tasks: [
                TestParallelTask(),
                TestParallelTask(),
                TestParallelTask(),
                TestParallelTask(),
              ],
            ),
          ),
      );

class TestTask extends Task<TestTask> {
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

class RetryTask extends Task<RetryTask> {
  RetryTask({
    Function(ExecutionContext context)? onStarted,
    Function(ExecutionContext context)? onSucceeded,
    Function(ExecutionContext context, dynamic error, StackTrace stackTrace)?
        onError,
    Function(ExecutionContext context)? onCompleted,
    RetryConfiguration? retryConfig,
  }) : super(
          onStarted: onStarted,
          onSucceeded: onSucceeded,
          onError: onError,
          onCompleted: onCompleted,
          retryConfig: retryConfig,
        );

  /// The count for retry test
  static int count = 0;

  @override
  void execute(ExecutionContext context) {
    if (count < 3) {
      count++;
      throw Exception();
    } else {
      count = 0;
    }
  }
}

class TestParallelTask extends ParallelTask<TestParallelTask> {
  @override
  FutureOr<void> invoke() {
    int i = 0;
    while (i < 10000000000) {
      i++;
    }
  }
}
