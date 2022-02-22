// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/job/branch/branch.dart';
import 'package:batch/src/job/const/branch_status.dart';
import 'package:batch/src/job/entity/entity.dart';

class BranchBuilder<T extends Entity<T>> {
  /// Returns the new instance of [BranchBuilder].
  BranchBuilder({
    required this.parentEntity,
  });

  /// The parent entity
  final T parentEntity;

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
    return parentEntity;
  }

  Branch<T> build() {
    if (_on == null || _to == null) {
      throw ArgumentError();
    }

    return Branch<T>(on: _on!, to: _to!);
  }
}
