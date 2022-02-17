// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:logger/logger.dart' as logger;

/// The custom printer.
class Printer extends logger.LogPrinter {
  @override
  List<String> log(logger.LogEvent event) => [
        '${DateTime.now()} [${event.level.name.padRight(7, ' ')}] :: ${event.message}'
      ];
}
