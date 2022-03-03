// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/repository/service/parameters.dart';
import 'package:batch/src/job/repository/table_name.dart';

class SharedParameters extends Parameters {
  /// The internal constructor.
  SharedParameters._internal();

  /// Returns the singleton instance of [SharedParameters].
  static SharedParameters get instance => _singletonInstance;

  /// The singleton instance of this [SharedParameters].
  static final _singletonInstance = SharedParameters._internal();

  @override
  get table => TableName.sharedParameters;
}
