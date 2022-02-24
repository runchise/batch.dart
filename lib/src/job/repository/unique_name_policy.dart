// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/name/unique_name.dart';
import 'package:batch/src/job/repository/name_relation.dart';
import 'package:batch/src/job/repository/unique_constraint_exception.dart';

class UniqueNamePolicy {
  /// The internal constructor.
  UniqueNamePolicy._internal();

  /// Returns the singleton instance of [UniqueNamePolicy].
  static UniqueNamePolicy get instance => _singletonInstance;

  /// The singleton instance of this [UniqueNamePolicy].
  static final _singletonInstance = UniqueNamePolicy._internal();

  /// The name relations
  final _nameRelations = <NameRelation>[];

  UniqueName check({
    required String jobName,
    String stepName = '',
    String taskName = '',
  }) {
    final newNameRelation = NameRelation(
      jobName: jobName,
      stepName: stepName,
      taskName: taskName,
    );

    for (final nameRelation in _nameRelations) {
      if (nameRelation == newNameRelation) {
        throw UniqueConstraintException('');
      }
    }

    return UniqueName(value: '');
  }
}
