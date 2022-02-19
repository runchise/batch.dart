// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/log/log_input_event.dart';
import 'package:batch/src/log/log_level.dart';

abstract class LogFilter {
  /// The log level
  LogLevel? level;

  bool shouldLog(final LogInputEvent event);
}
