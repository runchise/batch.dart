// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class NameRelation {
  /// Returns the new instance of [NameRelation].
  NameRelation({
    required this.job,
    required this.step,
  });

  /// The job name
  final String job;

  /// The step name
  final String step;

  @override
  String toString() => '[job=$job, step=$step]';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NameRelation && other.job == job && other.step == step;
  }

  @override
  int get hashCode => job.hashCode ^ step.hashCode;
}
