// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/context/process_status.dart';
import 'package:batch/src/job/context/step_execution.dart';
import 'package:batch/src/job/step.dart';
import 'package:batch/src/job/task_launcher.dart';
import 'package:batch/src/log/logger_provider.dart';

class StepLauncher {
  /// Returns the new instance of [StepLauncher].
  StepLauncher({
    required this.context,
    required this.steps,
    required String parentJobName,
  })  : assert(parentJobName.isNotEmpty),
        _parentJobName = parentJobName;

  /// The execution context
  final ExecutionContext context;

  /// The steps
  final List<Step> steps;

  /// The parent job name
  final String _parentJobName;

  /// Runs all steps.
  Future<void> execute() async {
    if (steps.isEmpty) {
      throw Exception(
        'The step to be launched is required.',
      );
    }

    for (final step in steps) {
      info('STARTED STEP ($_parentJobName -> ${step.name})');

      context.stepExecution = StepExecution(
        parentJobName: _parentJobName,
        name: step.name,
      );

      context.stepExecution!.status = ProcessStatus.started;

      await TaskLauncher(context: context, tasks: step.tasks).execute();

      context.stepExecution!.status = ProcessStatus.completed;

      info('FINISHED STEP ($_parentJobName -> ${step.name})');
    }
  }
}
