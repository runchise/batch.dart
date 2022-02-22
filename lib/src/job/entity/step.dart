// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/branch/branch_builder.dart';
import 'package:batch/src/job/entity/entity.dart';
import 'package:batch/src/job/entity/task.dart';
import 'package:batch/src/job/precondition.dart';

/// This class represents the processing of each step that constitutes a job in batch processing.
class Step extends Entity<Step> {
  /// Returns the new instance of [Step].
  Step({
    required String name,
    Precondition? precondition,
  }) : super(name: name, precondition: precondition);

  /// The tasks
  final List<Task> tasks = [];

  /// The branches
  final List<BranchBuilder<Step>> branchBuilders = [];

  /// Adds next [Task].
  ///
  /// Tasks added by this [nextTask] method are executed in the order in which they are stored.
  void nextTask(final Task task) {
    tasks.add(task);
  }

  /// Returns the new branch of this step.
  BranchBuilder<Step> branch() {
    final branch = BranchBuilder<Step>(parentEntity: this);
    branchBuilders.add(branch);
    return branch;
  }

  /// Returns true if this step has branch, otherwise false.
  bool get hasBranch => branchBuilders.isNotEmpty;
}
