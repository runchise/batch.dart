// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/batch.dart';

void main(List<String> args) => BatchApplication(
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
      ..addJob(_buildTestJob1())
      ..addJob(_buildTestJob2())
      ..run();

Job _buildTestJob1() => Job(
      name: 'Job1',
      schedule: CronParser(value: '*/1 * * * *'),
      // You can define callbacks for each processing phase.
      onStarted: (context) => info('Job1 has started.'),
      onSucceeded: (context) => info('Job1 has succeeded.'),
      onFailed: (context, error, stackTrace) =>
          info('Job1 has failed due to $error from $stackTrace'),
      onCompleted: (context) => info('Job1 has completed.'),
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
                to: Step(name: 'Step6')
                  ..nextTask(TestTask())
                  ..nextTask(SayHelloTask())
                  ..nextTask(SayWorldTask()),
              ),
          )
          ..branchOnCompleted(
            to: Step(
              name: 'Step5',
              // You can define callbacks for each processing phase.
              onStarted: (context) => info('Step5 has started.'),
              onSucceeded: (context) => info('Step5 has succeeded.'),
              onFailed: (context, error, stackTrace) =>
                  info('Step5 has failed due to $error from $stackTrace'),
              onCompleted: (context) => info('Step5 has completed.'),
            )
              ..nextTask(TestTask())
              ..nextTask(SayHelloTask())
              ..nextTask(SayWorldTask()),
          ),
      );

Job _buildTestJob2() => Job(
      name: 'Job2',
      schedule: CronParser(value: '*/2 * * * *'),
      // You can set precondition to run this job.
      precondition: JobPrecondition(),
    )
      ..nextStep(
        Step(
          name: 'Step1',
          // You can set precondition to run this step.
          precondition: StepPrecondition(),
        )
          ..nextTask(SayHelloTask())
          ..nextTask(SayWorldTask()),
      )
      ..branchOnSucceeded(
        to: Job(
          name: 'Job3',
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
          ),
      );

class TestTask extends Task<TestTask> {
  @override
  void execute(ExecutionContext context) {
    // This parameter is shared just in this step.
    context.parameters['key'] = 'value';
    // You can use shared parameters in any places.
    info(context.findSharedParameter('key1'));
    info(context.findSharedParameter('key2'));
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
    context.branchContribution.stepStatus = BranchStatus.failed;
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
