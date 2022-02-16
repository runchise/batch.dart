// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/log/printer.dart';
import 'package:logger/logger.dart' as logger;

/// The custom logger based on [logger.Logger].
class Logger {
  /// Access to Logger methods is done in static form,
  /// so the constructor is made private to prevent instantiation.
  Logger._();

  /// The logger
  static final _logger = logger.Logger(printer: Printer());

  /// Log a message at level info.
  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);
}
