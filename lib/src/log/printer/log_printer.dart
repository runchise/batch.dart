// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/log/input_log_event.dart';

abstract class LogPrinter {
  void init() {}

  /// Is called every time a new [LogInputEvent] is sent and handles printing or
  /// storing the message.
  List<String> log(final InputLogEvent event);

  void dispose() {}
}
