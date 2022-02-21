// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This is an abstract class that represents an entity in Job execution.
abstract class Entity<T extends Entity<T>> {
  /// Returns the new instance of [Entity].
  Entity({
    required this.name,
  });

  /// The name
  final String name;

  @override
  String toString() => 'Entity(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Entity<T> && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
