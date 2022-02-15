// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/step.dart';
import 'package:batch/src/task_launcher.dart';

class StepLauncher {
  /// Returns the new instance of [StepLauncher].
  StepLauncher.from({
    required this.steps,
  });

  /// The steps
  final List<Step> steps;

  /// Runs all steps.
  void execute() {
    if (steps.isEmpty) {
      throw Exception(
        'Register the step to be launched is required.',
      );
    }

    for (final step in steps) {
      TaskLauncher.from(tasks: step.tasks).execute();
    }
  }
}
