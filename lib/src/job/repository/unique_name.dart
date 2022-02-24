// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class UniqueName {
  /// Returns the new instance of [UniqueName].
  UniqueName({
    required this.value,
  });

  /// The unique name value
  final String value;

  @override
  String toString() => 'UniqueName(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UniqueName && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
