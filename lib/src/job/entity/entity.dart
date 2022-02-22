// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/job/precondition.dart';

/// This is an abstract class that represents an entity in Job execution.
abstract class Entity<T extends Entity<T>> {
  /// Returns the new instance of [Entity].
  Entity({
    required this.name,
    Precondition? precondition,
  }) : _precondition = precondition;

  /// The name
  final String name;

  /// The precondition
  final Precondition? _precondition;

  /// Returns true if this entity can launch, otherwise false.
  bool canLaunch() {
    if (_precondition == null) {
      return true;
    }

    return _precondition!.check();
  }
}
