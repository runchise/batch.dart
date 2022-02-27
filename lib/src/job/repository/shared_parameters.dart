// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/job/repository/model/shared_parameter.dart';
import 'package:batch/src/job/repository/repository.dart';
import 'package:batch/src/job/repository/table_name.dart';

abstract class SharedParameters extends Repository {
  static SharedParameters get instance => _SharedParameters.instance;

  @override
  get table => TableName.sharedParameters;

  /// Returns [SharedParameter] associated with [key].
  SharedParameter findByKey(final String key);

  /// Adds [value] as a shared parameter associated with [key].
  void add({required String key, required dynamic value});
}

class _SharedParameters extends SharedParameters {
  /// The internal constructor.
  _SharedParameters._internal();

  /// Returns the singleton instance of [_SharedParameters].
  static _SharedParameters get instance => _singletonInstance;

  /// The singleton instance of this [_SharedParameters].
  static final _singletonInstance = _SharedParameters._internal();

  @override
  SharedParameter findByKey(final String key) {
    for (final record in records) {
      if (record.key == key) {
        return record;
      }
    }

    throw ArgumentError('There is no shared parameter associated with $key.');
  }

  @override
  void add({required String key, required dynamic value}) =>
      records.add(SharedParameter(key: key, value: value));
}
