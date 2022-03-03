// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/repository/service/parameters.dart';
import 'package:batch/src/job/repository/table_name.dart';

class JobParameters extends Parameters {
  /// The internal constructor.
  JobParameters._internal();

  /// Returns the singleton instance of [JobParameters].
  static JobParameters get instance => _singletonInstance;

  /// The singleton instance of this [JobParameters].
  static final _singletonInstance = JobParameters._internal();

  @override
  get table => TableName.jobParameters;
}
