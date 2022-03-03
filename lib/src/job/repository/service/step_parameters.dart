// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/repository/service/parameters.dart';
import 'package:batch/src/job/repository/table_name.dart';

class StepParameters extends Parameters {
  /// The internal constructor.
  StepParameters._internal();

  /// Returns the singleton instance of [StepParameters].
  static StepParameters get instance => _singletonInstance;

  /// The singleton instance of this [StepParameters].
  static final _singletonInstance = StepParameters._internal();

  @override
  get table => TableName.stepParameters;
}
