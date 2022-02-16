// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/step.dart';
import 'package:batch/src/task_launcher.dart';

class StepLauncher {
  /// Returns the new instance of [StepLauncher].
  StepLauncher.from({
    required this.parentJobName,
    required this.steps,
  }) : assert(parentJobName.isNotEmpty);

  /// The parent job name
  final String parentJobName;

  /// The steps
  final List<Step> steps;

  /// Runs all steps.
  Future<void> execute() async {
    if (steps.isEmpty) {
      throw Exception(
        'Register the step to be launched is required.',
      );
    }

    for (final step in steps) {
      Logger.info('STARTED STEP ($parentJobName -> ${step.name})');

      await TaskLauncher.from(tasks: step.tasks).execute();

      Logger.info('FINISHED STEP ($parentJobName -> ${step.name})');
    }
  }
}
