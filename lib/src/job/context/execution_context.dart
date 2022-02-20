// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/context/job_execution.dart';
import 'package:batch/src/job/context/step_execution.dart';
import 'package:batch/src/job/parameter/shared_parameters.dart';

class ExecutionContext {
  /// The current job execution
  JobExecution? jobExecution;

  /// The current step execution
  StepExecution? stepExecution;

  /// The shared parameters
  final Map<String, dynamic> sharedParameters =
      Map.from(SharedParameters.instance.values);

  /// The parameters
  Map<String, dynamic> parameters = {};

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
