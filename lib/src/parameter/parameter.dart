// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/parameter/parameter_scope.dart';
import 'package:batch/src/parameter/job_relationship.dart';

class Parameter {
  /// Returns the new instance of [Parameter].
  Parameter({
    required this.scope,
    required this.value,
    required this.relationship,
  });

  /// The parameter scope
  final ParameterScope scope;

  /// The value
  final dynamic value;

  /// The job relationship
  final JobRelationship relationship;

  @override
  String toString() =>
      'Parameter(scope: $scope, value: $value, relationship: $relationship)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Parameter &&
        other.scope == scope &&
        other.value == value &&
        other.relationship == relationship;
  }

  @override
  int get hashCode => scope.hashCode ^ value.hashCode ^ relationship.hashCode;
}
