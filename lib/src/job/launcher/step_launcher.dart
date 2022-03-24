// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/step.dart';
import 'package:batch/src/job/launcher/launcher.dart';
import 'package:batch/src/job/launcher/task_launcher.dart';

class StepLauncher extends Launcher<Step> {
  /// Returns the new instance of [StepLauncher].
  StepLauncher({
    required ExecutionContext context,
    required List<Step> steps,
    required String parentJobName,
  })  : assert(parentJobName.isNotEmpty),
        _steps = steps,
        super(context: context);

  /// The steps
  final List<Step> _steps;

  @override
  Future<void> run() async {
    for (final step in _steps) {
      await super.executeRecursively(
        entity: step,
        execute: (step) async {
          await TaskLauncher(
            context: context,
            tasks: step.tasks,
          ).run();

          // Removes step scope parameters set within the step executed last time.
          super.context.stepParameters.removeAll();
        },
      );
    }
  }
}
