// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/log/log_level.dart';
import 'package:batch/src/log/logger_provider.dart';

abstract class IsolatedLogMessage {
  /// Returns the new instance of [IsolatedLogMessage].
  factory IsolatedLogMessage({
    required LogLevel level,
    required String value,
    required dynamic error,
    required StackTrace? stackTrace,
  }) =>
      _IsolatedLogMessage(
        level: level,
        value: value,
        error: error,
        stackTrace: stackTrace,
      );

  /// Outputs the message from isolated thread.
  void output();
}

class _IsolatedLogMessage implements IsolatedLogMessage {
  /// Returns the new instance of [_IsolatedLogMessage].
  _IsolatedLogMessage({
    required this.level,
    required this.value,
    required this.error,
    required this.stackTrace,
  });

  /// The log level
  final LogLevel level;

  /// The value
  final String value;

  /// The error
  final dynamic error;

  /// The stack trace
  final StackTrace? stackTrace;

  /// The created datetime
  final DateTime createdAt = DateTime.now();

  @override
  void output() {
    switch (level) {
      case LogLevel.trace:
        log.trace(_prettifiedMessage);
        break;
      case LogLevel.debug:
        log.debug(_prettifiedMessage);
        break;
      case LogLevel.info:
        log.info(_prettifiedMessage);
        break;
      case LogLevel.warn:
        log.warn(_prettifiedMessage, error, stackTrace);
        break;
      case LogLevel.error:
        log.error(_prettifiedMessage, error, stackTrace);
        break;
      case LogLevel.fatal:
        log.fatal(_prettifiedMessage, error, stackTrace);
        break;
    }
  }

  String get _prettifiedMessage =>
      'Received from the isolated thread [message=$value]';
}
