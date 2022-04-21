// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/event/base_step.dart';
import 'package:batch/src/job/event/job.dart';
import 'package:batch/src/job/schedule/parser/schedule_parser.dart';

class ScheduledJob extends Job {
  /// Returns the new instance of [ScheduledWorkflow].
  ScheduledJob({
    required String name,
    required this.schedule,
    required List<BaseStep> steps,
    FutureOr<bool> Function(ExecutionContext context)? precondition,
    Function(ExecutionContext context)? onStarted,
    Function(ExecutionContext context)? onSucceeded,
    Function(ExecutionContext context, dynamic error, StackTrace stackTrace)?
        onError,
    Function(ExecutionContext context)? onCompleted,
    List<Job> branchesOnSucceeded = const [],
    List<Job> branchesOnFailed = const [],
    List<Job> branchesOnCompleted = const [],
  }) : super(
          name: name,
          steps: steps,
          precondition: precondition,
          onStarted: onStarted,
          onError: onError,
          onSucceeded: onSucceeded,
          onCompleted: onCompleted,
          branchesOnSucceeded: branchesOnSucceeded,
          branchesOnFailed: branchesOnFailed,
          branchesOnCompleted: branchesOnCompleted,
        );

  /// The schedule
  final ScheduleParser schedule;
}
