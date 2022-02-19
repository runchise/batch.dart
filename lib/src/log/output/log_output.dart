// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/log/output_log_event.dart';

abstract class LogOutput {
  void init() {}

  void output(final OutputLogEvent event);

  void dispose() {}
}
