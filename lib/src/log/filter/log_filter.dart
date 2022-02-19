// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/log/input_log_event.dart';
import 'package:batch/src/log/log_level.dart';

abstract class LogFilter {
  /// The log level
  LogLevel? level;

  void init() {}

  bool shouldLog(final InputLogEvent event);

  void dispose() {}
}
