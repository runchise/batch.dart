// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/banner/banner.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/parameter/shared_parameters.dart';
import 'package:batch/src/job/schedule/job_scheduler.dart';
import 'package:batch/src/log/log_configuration.dart';
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/log/logger_provider.dart';
import 'package:batch/src/runner.dart';

/// This is a batch application that manages the execution of arbitrarily defined jobs
/// with own lifecycle.
///
/// In order to run this batch application, you first need to create at least
/// one [Job] object. After creating the Job object, use the [addJob] method to register
/// the Job to the batch application.
///
/// [Job] represents the maximum unit of a certain processing system
/// that consists of multiple steps. In addition, a Step consists of multiple Tasks. Step
/// is an intermediate concept between Job and Task, and Task is the specific
/// minimum unit of processing in a particular processing system.
///
/// You can use [addSharedParameter] to add a value that will be shared by the
/// entire this batch application. This value can be added by tying it to string key and
/// can be used in the Task class throughout the execution context.
///
/// Also you can get more information about implementation on [example page](https://github.com/myConsciousness/batch.dart/blob/main/example/example.dart).
///
/// These job configuration can be assembled in any way you like. For example,
/// you can configure it as follows.
///
/// ```
/// BatchApplication
/// │
/// │              ┌ Task1
/// │      ┌ Step1 ├ Task2
/// │      │       └ Task3
/// │      │
/// │      │       ┌ Task1
/// ├ Job1 ├ Step2 ├ Task2
/// │      │       └ Task3
/// │      │
/// │      │       ┌ Task1
/// │      └ Step3 ├ Task2
/// │              └ Task3
/// │
/// │              ┌ Task1
/// │      ┌ Step1 ├ Task2
/// │      │       └ ┄
/// │      │
/// │      │       ┌ Task1
/// └ Job2 ├ Step2 ├ ┄
///        │       └ ┄
///        │
///        │
///        └ ┄
/// ```
abstract class BatchApplication implements Runner {
  /// Returns the new instance of [BatchApplication].
  factory BatchApplication({LogConfiguration? logConfig}) =>
      _BatchApplication(logConfig: logConfig);

  /// Adds [Job].
  ///
  /// The name of the Job must be unique, and an exception will be raised
  /// if a Job with a duplicate name has already been registered.
  void addJob(final Job job);

  /// Adds parameter as global scope.
  void addSharedParameter({
    required String key,
    required dynamic value,
  });
}

class _BatchApplication implements BatchApplication {
  /// Returns the new instance of [_BatchApplication].
  _BatchApplication({LogConfiguration? logConfig}) : _logConfig = logConfig;

  /// The configuration for logging
  final LogConfiguration? _logConfig;

  /// The jobs
  final _jobs = <Job>[];

  @override
  void addJob(final Job job) {
    for (final registeredJob in _jobs) {
      if (registeredJob.name == job.name) {
        throw Exception('The job name "${job.name}" is already registered.');
      }
    }

    _jobs.add(job);
  }

  @override
  void addSharedParameter({
    required String key,
    required dynamic value,
  }) {
    SharedParameters.instance.put(
      key: key,
      value: value,
    );
  }

  @override
  void run() {
    try {
      //! The logging functionality provided by the batch library
      //! will be available when this loading process is complete.
      Logger.loadFrom(config: _logConfig ?? LogConfiguration());

      info(
        '🚀🚀🚀🚀🚀🚀🚀 The batch process has started! 🚀🚀🚀🚀🚀🚀🚀\n${Banner.layout}',
      );

      info('The job schedule is being configured...');

      JobScheduler(jobs: _jobs).run();

      info('The job schedule has configured!');
    } catch (e) {
      Logger.instance.dispose();
      throw Exception(e);
    }
  }
}
