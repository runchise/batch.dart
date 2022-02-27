// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/job/repository/table_name.dart';

class Database {
  /// The internal constructor.
  Database._internal();

  /// Returns the singleton instance of [Database].
  static Database get instance => _singletonInstance;

  /// The singleton instance of this [Database].
  static final _singletonInstance = Database._internal();

  /// The object represents tables
  final tables = <TableName, List<dynamic>>{};

  /// Returns true if this database has an object of [table], otherwise false.
  bool has(final TableName table) => tables.containsKey(table);
}
