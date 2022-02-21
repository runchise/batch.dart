// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/entity/task.dart';
import 'package:batch/src/job/execution.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/parameter/shared_parameters.dart';
import 'package:batch/src/job/entity/step.dart';

class ExecutionContext {
  /// The current job execution
  Execution<Job>? jobExecution;

  /// The current step execution
  Execution<Step>? stepExecution;

  /// The current task execution
  Execution<Task>? taskExecution;

  /// The shared parameters
  final Map<String, dynamic> sharedParameters =
      Map.from(SharedParameters.instance.values);

  /// The parameters
  final Map<String, dynamic> parameters = {};

  @override
  String toString() =>
      'ExecutionContext(jobExecution: $jobExecution, stepExecution: $stepExecution)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExecutionContext &&
        other.jobExecution == jobExecution &&
        other.stepExecution == stepExecution;
  }

  @override
  int get hashCode => jobExecution.hashCode ^ stepExecution.hashCode;
}
