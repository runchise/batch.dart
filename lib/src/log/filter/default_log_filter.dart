// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/log/filter/log_filter.dart';
import 'package:batch/src/log/input_log_event.dart';

class DefaultLogFilter extends LogFilter {
  @override
  bool shouldLog(final InputLogEvent event) =>
      event.level.index >= level!.index;
}
