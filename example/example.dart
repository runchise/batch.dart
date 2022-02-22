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

  final job2 = Job(
    name: 'Job2',
    cron: '*/3 * * * *',
    // You can set precondition to run this job.
    precondition: JobPrecondition(),
  )..nextStep(
      Step(
        name: 'Step1',
        // You can set precondition to run this step.
        precondition: StepPrecondition(),
      )
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    );

  BatchApplication(
    logConfig: LogConfiguration(
      level: LogLevel.trace,
      filter: DefaultLogFilter(),
      output: ConsoleLogOutput(),
      printLog: true,
    ),
  )
    // You can add any parameters that is shared in this batch application.
    ..addSharedParameter(key: 'key1', value: 'value1')
    ..addSharedParameter(key: 'key2', value: {'any': 'object'})
    ..addJob(job1)
    ..addJob(job2)
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

    // This parameter is shared just in tasks in this step.
    context.parameters['key_$count'] = 'value$count';
    // You can use shared parameters in any places.
    info(context.sharedParameters['key1']);

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

class JobPrecondition extends Precondition {
  @override
  bool check() {
    return true;
  }
}

class StepPrecondition extends Precondition {
  @override
  bool check() {
    return true;
  }
}
