// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/repository/model/parameter.dart';
import 'package:batch/src/job/repository/repository.dart';

abstract class Parameters extends Repository<Parameter> {
  /// Returns the parameter value associated with [key].
  dynamic operator [](final String key) {
    for (final record in records) {
      if (record.key == key) {
        return record.value;
      }
    }

    throw ArgumentError('There is no parameter associated with $key.');
  }

  /// Adds [value] as a parameter associated with [value].
  void operator []=(final String key, final dynamic value) =>
      records.add(Parameter(key: key, value: value));
}
