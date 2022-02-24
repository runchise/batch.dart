// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class NameRelation {
  /// Returns the new instance of [NameRelation].
  NameRelation({
    required this.jobName,
    this.stepName = '',
    this.taskName = '',
  });

  /// The job name
  final String jobName;

  /// The step name
  final String stepName;

  /// The task name
  final String taskName;

  @override
  String toString() =>
      'NameRelation(jobName: $jobName, stepName: $stepName, taskName: $taskName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NameRelation &&
        other.jobName == jobName &&
        other.stepName == stepName &&
        other.taskName == taskName;
  }

  @override
  int get hashCode => jobName.hashCode ^ stepName.hashCode ^ taskName.hashCode;
}
