// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/batch.dart';

void main() {
  final job1 = Job(name: 'Job1', cron: '*/1 * * * *')
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
        ..nextTask(SayWorldTask()),
    );

  final job2 = Job(name: 'Job2', cron: '*/3 * * * *')
    ..nextStep(
      Step(name: 'Step1')
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    );

  BatchApplication(
    logConfig: LogConfiguration(
      level: LogLevel.trace,
      filter: DevelopmentLogFilter(),
      output: ConsoleLogOutput(),
    ),
  )
    ..addJob(job1)
    ..addJob(job2)
    ..addParameter(key: 'key', value: 'value')
    ..run();
}

class TestTask extends Task<TestTask> {
  static int count = 0;

  @override
  Future<RepeatStatus> execute(ExecutionContext context) async {
    if (count == 5) {
      trace('Finish.');
      return RepeatStatus.finished;
    }

    count++;

    info('Continue.');
    return RepeatStatus.continuable;
  }
}

class SayHelloTask extends Task<SayHelloTask> {
  @override
  Future<RepeatStatus> execute(ExecutionContext context) async {
    debug('Hello,');
    return RepeatStatus.finished;
  }
}

class SayWorldTask extends Task<SayWorldTask> {
  @override
  Future<RepeatStatus> execute(ExecutionContext context) async {
    info('World!');
    return RepeatStatus.finished;
  }
}
