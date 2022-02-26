// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/step.dart';
import 'package:batch/src/job/launcher/launcher.dart';

class StepLauncher extends Launcher<Step> {
  /// Returns the new instance of [StepLauncher].
  StepLauncher({
    required ExecutionContext context,
    required this.steps,
    required String parentJobName,
  })  : assert(parentJobName.isNotEmpty),
        super(context: context);

  /// The steps
  final List<Step> steps;

  @override
  Future<void> execute() async {
    if (steps.isEmpty) {
      throw Exception('The step to be launched is required.');
    }

    for (final step in steps) {
      super.executeRecursively(entity: step);
    }
  }
}
