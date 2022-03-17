// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

abstract class Version {
  /// Returns the new instance of [Version].
  factory Version() => _Version();

  /// Returns the current version.
  String get current;
}

class _Version implements Version {
  @override
  final String current = '0.5.1';
}
