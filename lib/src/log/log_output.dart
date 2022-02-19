// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/log/log_output_event.dart';

abstract class LogOutput {
  void output(final LogOutputEvent event);
}
