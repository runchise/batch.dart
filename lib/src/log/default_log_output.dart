// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/log/log_output.dart';
import 'package:batch/src/log/log_output_event.dart';

/// Default implementation of [LogOutput].
///
/// It sends everything to the system console.
class DefaultLogOutput extends LogOutput {
  @override
  void output(final LogOutputEvent event) => event.lines.forEach(print);
}
