// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class JobRelationship {
  /// Returns the new instance of [JobRelationship].
  JobRelationship({
    this.parentJobName = '',
    this.parentStepName = '',
  });

  /// The parent job name
  final String parentJobName;

  /// The parent step name
  final String parentStepName;

  @override
  String toString() =>
      'JobRelationship(parentJobName: $parentJobName, parentStepName: $parentStepName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is JobRelationship &&
        other.parentJobName == parentJobName &&
        other.parentStepName == parentStepName;
  }

  @override
  int get hashCode => parentJobName.hashCode ^ parentStepName.hashCode;
}
