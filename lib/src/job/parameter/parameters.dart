// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/parameter/parameter.dart';

class Parameters {
  /// The objects
  final objects = <Parameter>[];

  /// Returns the parameter value associated with [key].
  dynamic operator [](final String key) {
    for (final parameter in objects) {
      if (parameter.key == key) {
        return parameter.value;
      }
    }

    throw ArgumentError('There is no parameter associated with $key.');
  }

  /// Adds [value] as a parameter associated with [key].
  void operator []=(final String key, final dynamic value) =>
      objects.add(Parameter(key: key, value: value));

  /// Removes all parameters.
  void removeAll() => objects.removeRange(0, objects.length);

  @override
  String toString() => objects.toString();
}
