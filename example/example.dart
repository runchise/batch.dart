// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

import 'dart:async';
import 'dart:io';

import 'package:batch/batch.dart';

void main(List<String> args) => BatchApplication(
      args: _argParser.parse(args),
      onLoadArgs: (args, addSharedParameters) {
        //! This callback is useful when you want to create a singleton instance using command line arguments
        //! and manage it as SharedParameters in batch application. If this callback is not defined,
        //! all command line arguments are added as SharedParameters automatically.
        addSharedParameters(key: 'userName', value: args['userName']);
      },
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
      ..nextSchedule(_TestJob1())
      ..nextSchedule(_TestJob2())
      ..nextSchedule(_TestJob3())
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

class _TestJob1 implements ScheduledJobBuilder {
  @override
  ScheduledJob build() => ScheduledJob(
        name: 'Job1',
        schedule: CronParser('*/1 * * * *'),
        // You can define callbacks for each processing phase.
        onStarted: (context) =>
            log.info('\n--------------- Job1 has started! ---------------'),
        onCompleted: (context) =>
            log.info('\n--------------- Job1 has completed! ---------------'),
      )
        ..nextStep(Step(
          name: 'Step1',
          task: RetryTask(),
          retryConfig: RetryConfiguration(
            maxAttempt: 3,
            retryableExceptions: [Exception()],
            backOff: Duration(seconds: 30),
            onRecover: (context) {
              log.warn('Do something for recovering.');
            },
          ),
        ))
        ..nextStep(
          Step(
            name: 'Step2',
            task: TestTask(),
            branchesOnSucceeded: [Step(name: 'Step3', task: SayHelloTask())],
            branchesOnFailed: [
              Step(
                name: 'Step4',
                task: SayHelloTask(),
                branchesOnCompleted: [
                  Step(
                    name: 'Step6',
                    // You can set any preconditions to run Step.
                    precondition: (context) => false,
                    task: SayWorldTask(),
                  ),
                ],
              )
            ],
            branchesOnCompleted: [
              Step(
                name: 'Step5',
                task: SayHelloTask(),
                onStarted: (context) =>
                    log.info('\n--------- Step5 has started! ---------'),
                onCompleted: (context) =>
                    log.info('\n--------- Step5 has completed! ---------'),
              )
            ],
          ),
        );
}

class _TestJob2 implements ScheduledJobBuilder {
  @override
  ScheduledJob build() => ScheduledJob(
        name: 'Job2',
        schedule: CronParser('*/5 * * * *'),
        // You can set any preconditions to run Job.
        precondition: (context) async => true,
        branchesOnCompleted: [
          Job(name: 'Job3')..nextStep(Step.ofShutdown()),
        ],
      )..nextStep(
          Step(
            name: 'Step1',
            precondition: (context) => true,
            task: SayWorldTask(),
            skipConfig: SkipConfiguration(
              skippableExceptions: [Exception()],
            ),
          ),
        );
}

class _TestJob3 implements ScheduledJobBuilder {
  @override
  ScheduledJob build() => ScheduledJob(
      name: 'Job4',
      schedule: CronParser('*/1 * * * *'),
      // You can set any preconditions to run Job.
      precondition: (context) async => true,
      onError: (context, error, stackTrace) => log.error('', error, stackTrace))
    ..nextStep(
      ParallelStep(
        name: 'Parallel Step',
        precondition: (context) => true,
        tasks: [
          TestParallelTask(),
          TestParallelTask(),
          TestParallelTask(),
          TestParallelTask(),
        ],
      ),
    );
}

class TestTask extends Task<TestTask> {
  @override
  void execute(ExecutionContext context) {
    // This parameter is shared just in this job.
    context.jobParameters['key'] = 'job_parameter';

    // You can use shared parameters in any places.
    log.info(context.sharedParameters['key1']);
    log.info(context.sharedParameters['key2']);

    log.trace('Trace');
    log.info('Info');
    log.debug('Debug');
    log.warn('Warn');
    log.error('Error');
    log.fatal('Fatal');
  }
}

class SayHelloTask extends Task<SayHelloTask> {
  @override
  void execute(ExecutionContext context) {
    log.debug('Hello,');
  }
}

class SayWorldTask extends Task<SayWorldTask> {
  @override
  void execute(ExecutionContext context) {
    log.info('World!');
    context.jobExecution!.switchBranchToSucceeded();
    context.stepExecution!.switchBranchToFailed();
  }
}

class RetryTask extends Task<RetryTask> {
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
  FutureOr<void> execute(ExecutionContext context) {
    int i = 0;
    while (i < 10000000000) {
      i++;
    }

    //! The logging functions provided by frameworks such as "log.info" and "info" cannot be
    //! used in parallel processing. Instead, use the "sendMessage" method corresponding
    //! to the log level as below.
    //!
    //! Messages sent by the following "sendMessage" method are logged out at once after
    //! parallel processing is completed.
    super.sendMessageAsTrace('Trace');
    super.sendMessageAsDebug('Debug');
    super.sendMessageAsInfo('Info');

    try {
      throw Exception('Error output is also possible.');
    } catch (error, stackTrace) {
      // The error and stackTrace are optional.
      super.sendMessageAsWarn('Warn');
      super.sendMessageAsError('Error', error, stackTrace);
      super.sendMessageAsFatal('Fatal', error, stackTrace);
    }
  }
}
