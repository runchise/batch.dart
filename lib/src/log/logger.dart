// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:logger/logger.dart' as logger;

// Project imports:
import 'package:batch/src/log/printer.dart';

/// The custom logger based on [logger.Logger].
class Logger {
  /// Access to Logger methods is done in static form,
  /// so the constructor is made private to prevent instantiation.
  Logger._();

  /// The logger
  static final _logger = logger.Logger(printer: Printer());

  /// Log a message at trace level.
  static void trace(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.v(message, error, stackTrace);

  /// Log a message at debug level.
  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.d(message, error, stackTrace);

  /// Log a message at info level.
  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.i(message, error, stackTrace);

  /// Log a message at warning level.
  static void warning(dynamic message,
          [dynamic error, StackTrace? stackTrace]) =>
      _logger.w(message, error, stackTrace);

  /// Log a message at error level.
  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error, stackTrace);

  /// Log a message at fatal level.
  static void fatal(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.wtf(message, error, stackTrace);
}
