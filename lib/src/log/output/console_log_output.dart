// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/log/output/log_output.dart';
import 'package:batch/src/log/output_log_event.dart';

/// Default implementation of [LogOutput].
///
/// It sends everything to the system console.
class ConsoleLogOutput extends LogOutput {
  @override
  void output(final OutputLogEvent event) => event.lines.forEach(print);
}
