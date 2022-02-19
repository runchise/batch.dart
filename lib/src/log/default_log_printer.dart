// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/log/log_input_event.dart';
import 'package:batch/src/log/log_printer.dart';

/// The custom printer.
class DefaultLogPrinter extends LogPrinter {
  @override
  List<String> log(final LogInputEvent event) => [
        '${DateTime.now()} [${event.level.name.padRight(7, ' ')}] :: ${event.message}'
      ];
}
