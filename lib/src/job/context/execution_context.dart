// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/branch/branch_contribution.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/entity/step.dart';
import 'package:batch/src/job/entity/task.dart';
import 'package:batch/src/job/execution.dart';
import 'package:batch/src/job/repository/model/shared_parameter.dart';
import 'package:batch/src/job/repository/shared_parameters.dart';

/// This class represents a context for managing metadata that is accumulated
/// as a batch application is executed.
///
/// The [jobExecution] and [stepExecution] indicate the execution status of
/// the currently running job and step.
///
/// And the [sharedParameters] are arbitrary shared parameters that were set
/// before this batch application was started, and the values associated with
/// the keys can be accessed from any scope.
///
/// It also provides [parameters] that are valid only within the scope of the step
/// currently being executed. Through this [parameters], you can perform simple
/// value passing in the tasks defined within this step. The usage is the same as
/// that of the Map provided by Dart, where values are associated with keys and stored.
class ExecutionContext {
  /// The current job execution
  Execution<Job>? jobExecution;

  /// The current step execution
  Execution<Step>? stepExecution;

  /// The current task execution
  Execution<Task>? taskExecution;

  /// The branch contribution
  final BranchContribution branchContribution = BranchContribution();

  /// Returns the [SharedParameter] associated with [key].
  dynamic findSharedParameter(final String key) =>
      SharedParameters.instance.findByKey(key).value;

  /// The parameters
  final Map<String, dynamic> parameters = {};
}
