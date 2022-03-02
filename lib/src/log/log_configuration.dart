// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/log/color/log_color.dart';
import 'package:batch/src/log/filter/log_filter.dart';
import 'package:batch/src/log/log_level.dart';
import 'package:batch/src/log/output/log_output.dart';
import 'package:batch/src/log/printer/log_printer.dart';

class LogConfiguration {
  /// Returns the new instance of [LogConfiguration].
  LogConfiguration({
    this.level,
    this.filter,
    this.printer,
    this.output,
    this.color,
    this.printLog = true,
  });

  /// The log level
  final LogLevel? level;

  /// The custom log filter
  final LogFilter? filter;

  /// The custom log printer
  final LogPrinter? printer;

  /// The custom log output
  final LogOutput? output;

  /// The custom log color
  final LogColor? color;

  /// The flag represents this logger should print log or not
  final bool printLog;
}
