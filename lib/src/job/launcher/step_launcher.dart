// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/batch.dart';
import 'package:batch/src/job/launcher/launcher.dart';

class StepLauncher extends Launcher<Step> {
  /// Returns the new instance of [StepLauncher].
  StepLauncher({
    required ExecutionContext context,
    required Step step,
    required String parentJobName,
  })  : assert(parentJobName.isNotEmpty),
        _step = step,
        super(context: context);

  /// The step
  final Step _step;

  @override
  Future<void> run() async => await super.executeRecursively(
        event: _step,
        execute: (step) async => await step.task.execute(context),
      );
}
