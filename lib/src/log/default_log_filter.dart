// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/log/log_filter.dart';
import 'package:batch/src/log/log_input_event.dart';

class DefaultLogFilter extends LogFilter {
  @override
  bool shouldLog(final LogInputEvent event) {
    bool shouldLog = false;

    assert(() {
      if (event.level.index >= super.level!.index) {
        shouldLog = true;
      }

      return true;
    }());

    return shouldLog;
  }
}
