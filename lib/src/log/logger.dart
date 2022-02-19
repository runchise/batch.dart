// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:batch/src/log/default_log_filter.dart';
import 'package:batch/src/log/default_log_output.dart';
import 'package:batch/src/log/default_log_printer.dart';
import 'package:batch/src/log/log_filter.dart';
import 'package:batch/src/log/log_input_event.dart';
import 'package:batch/src/log/log_level.dart';
import 'package:batch/src/log/log_output.dart';
import 'package:batch/src/log/log_output_event.dart';
import 'package:batch/src/log/log_printer.dart';

// Project imports:
import 'package:batch/src/log/logger_instance.dart';
import 'package:batch/src/log_configuration.dart';

class Logger {
  /// Returns the new instance of [Logger].
  Logger.loadFrom({
    LogConfiguration? config,
  })  : _filter = config?.filter ?? DefaultLogFilter(),
        _printer = config?.printer ?? DefaultLogPrinter(),
        _output = config?.output ?? DefaultLogOutput() {
    _filter.level = config?.level ?? LogLevel.trace;
    LoggerInstance.instance = this;
  }

  /// The filter
  final LogFilter _filter;

  /// The printer
  final LogPrinter _printer;

  /// The output
  final LogOutput _output;

  /// Log a message at trace level.
  void trace(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _log(LogLevel.trace, message, error, stackTrace);

  /// Log a message at debug level.
  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _log(LogLevel.debug, message, error, stackTrace);

  /// Log a message at info level.
  void info(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _log(LogLevel.info, message, error, stackTrace);

  /// Log a message at warning level.
  void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _log(LogLevel.warning, message, error, stackTrace);

  /// Log a message at error level.
  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _log(LogLevel.error, message, error, stackTrace);

  /// Log a message at fatal level.
  void fatal(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _log(LogLevel.fatal, message, error, stackTrace);

  /// Log a message with [level].
  void _log(
    LogLevel level,
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (error != null && error is StackTrace) {
      throw ArgumentError('Error parameter cannot take a StackTrace!');
    }

    final inputEvent = LogInputEvent.from(
      level: level,
      message: message,
      error: error,
      stackTrace: stackTrace,
    );

    if (_filter.shouldLog(inputEvent)) {
      final output = _printer.log(inputEvent);

      if (output.isNotEmpty) {
        final outputEvent = LogOutputEvent.from(
          level: level,
          lines: output,
        );

        try {
          _output.output(outputEvent);
        } catch (error, stackTrace) {
          print(error);
          print(stackTrace);
        }
      }
    }
  }
}
