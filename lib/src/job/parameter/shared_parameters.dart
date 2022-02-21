// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class SharedParameters {
  /// The internal constructor.
  SharedParameters._internal();

  /// Returns the singleton instance of [SharedParameters].
  static SharedParameters get instance => _singletonInstance;

  /// The singleton instance of this [SharedParameters].
  static final _singletonInstance = SharedParameters._internal();

  /// The shared parameters
  final values = <String, dynamic>{};

  /// Puts [value] in association with [key].
  void put({
    required String key,
    required dynamic value,
  }) =>
      values[key] = value;
}
