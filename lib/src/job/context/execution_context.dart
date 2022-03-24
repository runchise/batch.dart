// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/entity/step.dart';
import 'package:batch/src/job/entity/task.dart';
import 'package:batch/src/job/execution.dart';
import 'package:batch/src/job/parameter/parameters.dart';
import 'package:batch/src/job/parameter/shared_parameters.dart';

/// This class represents a context for managing metadata that is accumulated
/// as a batch application is executed.
class ExecutionContext {
  /// The current job execution
  Execution<Job>? jobExecution;

  /// The current step execution
  Execution<Step>? stepExecution;

  /// The current task execution
  Execution<Task>? taskExecution;

  /// The shared parameters
  final Parameters sharedParameters = SharedParameters.instance;

  /// The job parameters
  final Parameters jobParameters = Parameters();

  /// The step parameters
  final Parameters stepParameters = Parameters();
}
