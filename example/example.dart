// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/batch.dart';

void main() {
  final job1 = Job.from(name: 'Job1', cron: '*/1 * * * *')
    ..nextStep(
      Step.from(name: 'Step1')
        ..nextTask(TestTask())
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    )
    ..nextStep(
      Step.from(name: 'Step2')
        ..nextTask(TestTask())
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    );

  final job2 = Job.from(name: 'Job2', cron: '*/3 * * * *')
    ..nextStep(
      Step.from(name: 'Step1')
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    );

  JobLauncher()
    ..addJob(job1)
    ..addJob(job2)
    ..execute();
}

class TestTask extends Task {
  static int count = 0;

  @override
  Future<RepeatStatus> execute() async {
    if (count == 5) {
      trace('Finish.');
      return RepeatStatus.finished;
    }

    count++;

    info('Continue.');
    return RepeatStatus.continuable;
  }
}

class SayHelloTask extends Task {
  @override
  Future<RepeatStatus> execute() async {
    debug('Hello,');
    return RepeatStatus.finished;
  }
}

class SayWorldTask extends Task {
  @override
  Future<RepeatStatus> execute() async {
    info('World!');
    return RepeatStatus.finished;
  }
}
