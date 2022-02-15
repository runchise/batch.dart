// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/task.dart';

/// This class represents the processing of each step that constitutes a job in batch processing.
class Step {
  /// Returns the new instance of [Step].
  Step.from({
    required this.name,
  });

  /// The name
  final String name;

  /// The tasks
  final List<Task> tasks = [];

  /// Adds next [Task].
  ///
  /// Tasks added by this [nextTask] method are executed in the order in which they are stored.
  Step nextTask(final Task task) {
    tasks.add(task);
    return this;
  }

  @override
  String toString() => 'Step(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Step && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
