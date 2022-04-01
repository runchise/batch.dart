// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/log/log_level.dart';
import 'package:batch/src/log/logger_provider.dart';

abstract class IsolatedLogMessage {
  /// Returns the new instance of [IsolatedLogMessage].
  factory IsolatedLogMessage(
          {required LogLevel level, required String value}) =>
      _IsolatedLogMessage(level: level, value: value);

  /// Outputs the message from isolated thread.
  void output();
}

class _IsolatedLogMessage implements IsolatedLogMessage {
  /// Returns the new instance of [_IsolatedLogMessage].
  _IsolatedLogMessage({required this.level, required this.value});

  /// The log level
  final LogLevel level;

  /// The value
  final String value;

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
        log.warn(_prettifiedMessage);
        break;
      case LogLevel.error:
        log.error(_prettifiedMessage);
        break;
      case LogLevel.fatal:
        log.fatal(_prettifiedMessage);
        break;
    }
  }

  String get _prettifiedMessage =>
      'Received from the isolated thread [message=$value]';
}
