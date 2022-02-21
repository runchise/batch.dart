// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/batch_application_impl.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/log/log_configuration.dart';

abstract class BatchApplication {
  /// Returns the new instance of [BatchApplication].
  factory BatchApplication({
    LogConfiguration? logConfig,
  }) =>
      BatchApplicationImpl(logConfig: logConfig);

  /// Adds [Job].
  ///
  /// The name of the Job must be unique, and an exception will be raised
  /// if a Job with a duplicate name has already been registered.
  BatchApplication addJob(final Job job);

  /// Adds parameter as global scope.
  BatchApplication addParameter<T>({
    required String key,
    required T value,
  });

  /// Runs this batch application.
  void run();
}
