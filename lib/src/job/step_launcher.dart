// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/context/context_helper.dart';
import 'package:batch/src/job/entity/step.dart';
import 'package:batch/src/job/task_launcher.dart';
import 'package:batch/src/log/logger_provider.dart';

class StepLauncher extends ContextHelper<Step> {
  /// Returns the new instance of [StepLauncher].
  StepLauncher({
    required ExecutionContext context,
    required this.steps,
    required String parentJobName,
  })  : assert(parentJobName.isNotEmpty),
        super(context: context);

  /// The steps
  final List<Step> steps;

  /// Runs all steps.
  Future<void> execute() async {
    if (steps.isEmpty) {
      throw Exception('The step to be launched is required.');
    }

    for (final step in steps) {
      if (!step.canLaunch()) {
        info('Skipped ${step.name} because the precondition is not met.');
        return;
      }

      await _executeStep(step: step);

      if (step.hasBranch) {
        for (final branchBuilder in step.branchBuilders) {
          final branch = branchBuilder.build();
          if (branch.on == super.context.branchContribution.status) {
            await _executeStep(step: branch.to);
          }
        }
      }

      super.resetBranchStatus();
    }
  }

  Future<void> _executeStep({required Step step}) async {
    super.startNewExecution(name: step.name);

    await TaskLauncher(
      context: super.context,
      tasks: step.tasks,
    ).execute();

    super.finishExecution();
  }
}
