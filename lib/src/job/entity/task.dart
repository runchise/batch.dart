// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/entity.dart';

/// This abstract class represents the smallest unit of processing that is
/// included in the steps when a job is executed.
///
/// The processing of each step of the job should be defined by overriding
/// [execute] in a class that inherits from this [Task].
abstract class Task<T extends Task<T>> extends Entity<Task> {
  /// Returns the new instance of [Task].
  Task() : super(name: T.toString());

  /// Runs this [Task] and returns the [RepeatStatus].
  ///
  /// Be sure to return [RepeatStatus.finished] to complete the process.
  /// This Task process will be repeated if [RepeatStatus.continuable] is returned,
  /// until [RepeatStatus.finished] is returned. This will result in an infinite loop,
  /// so be sure to consider the case where RepeatStatus.finished is returned
  /// when using RepeatStatus.continue.
  void execute(final ExecutionContext context);
}
