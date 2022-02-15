// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/step.dart';

/// This class represents a job which is the largest unit in batch execution processing.
///
/// Pass a unique [name] and a [cron] that represents the execution schedule
/// to the [Job.from] constructor when initializing [Job]. And then use
/// the [nextStep] method to register the [Step] to be executed.
class Job {
  /// Returns the new instance of [Job].
  Job.from({
    required this.name,
    required this.cron,
  });

  /// The name
  final String name;

  /// The cron
  final String cron;

  /// The steps
  final List<Step> steps = [];

  /// Adds [Step].
  ///
  /// Steps added by this [nextStep] method are executed in the order in which they are stored.
  ///
  /// Also the name of the Step must be unique, and an exception will be raised
  /// if a Step with a duplicate name has already been registered in this Job.
  Job nextStep(final Step step) {
    for (final registredStep in steps) {
      if (registredStep.name == step.name) {
        throw Exception('The step name "${step.name}" is already registred.');
      }
    }

    steps.add(step);

    return this;
  }

  @override
  String toString() => 'Job(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Job && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
