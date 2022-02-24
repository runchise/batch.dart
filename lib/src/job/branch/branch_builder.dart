// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/branch/branch.dart';
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:batch/src/job/entity/entity.dart';

class BranchBuilder<T extends Entity<T>> {
  /// Returns the new instance of [BranchBuilder].
  BranchBuilder({
    required T parentEntity,
  }) : _parentEntity = parentEntity;

  /// The parent entity
  final T _parentEntity;

  /// The status as a basis for this branching
  BranchStatus? _on;

  /// The next point for this branching
  T? _to;

  /// Sets the status as [BranchStatus.completed].
  BranchBuilder<T> onCompleted() {
    _on = BranchStatus.completed;
    return this;
  }

  /// Sets the status as [BranchStatus.failed].
  BranchBuilder<T> onFailed() {
    _on = BranchStatus.failed;
    return this;
  }

  /// Sets the next point for this branching.
  T to(final T to) {
    _to = to;
    return _parentEntity;
  }

  Branch<T> build() {
    if (_on == null) {
      throw ArgumentError('Set the branch status for this branch.');
    }

    if (_to == null) {
      throw ArgumentError('Set the next point for this branch.');
    }

    return Branch<T>(on: _on!, to: _to!);
  }
}
