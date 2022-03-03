// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/repository/database.dart';
import 'package:batch/src/job/repository/table_name.dart';

abstract class Repository<T> {
  /// The singleton instance of [Database]
  final _database = Database.instance;

  /// Returns the table name.
  TableName get table;

  /// Returns the records associated with [table].
  List<T> get records {
    if (_database.has(table)) {
      return _database.tables[table] as List<T>;
    }

    return _initialize();
  }

  /// Removes all elements records associated with [table].
  void removeAll() {
    if (!_database.has(table)) {
      return;
    }

    _initialize();
  }

  /// Initialize table associated with [table] and returns new list.
  List<T> _initialize() {
    final newRecords = <T>[];
    _database.tables[table] = newRecords;
    return newRecords;
  }
}
