// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:meta/meta.dart';

// Project imports:
import 'package:batch/src/job/parallel/isolated_log_message.dart';
import 'package:batch/src/log/log_level.dart';

abstract class ParallelTaskSupport {
  /// The isolated messages
  final List<IsolatedLogMessage> _isolatedMessages = [];

  /// Returns the isolated messages.
  @visibleForOverriding
  List<IsolatedLogMessage> get isolatedMessages => List.from(_isolatedMessages);

  /// Sends [message] to main thread as [LogLevel.info].
  void sendMessageAsTrace(String message) =>
      _sendMessage(LogLevel.trace, message);

  /// Sends [message] to main thread as [LogLevel.debug].
  void sendMessageAsDebug(String message) =>
      _sendMessage(LogLevel.debug, message);

  /// Sends [message] to main thread as [LogLevel.info].
  void sendMessageAsInfo(String message) =>
      _sendMessage(LogLevel.info, message);

  /// Sends [message] to main thread as [LogLevel.warn].
  void sendMessageAsWarn(String message,
          [dynamic error, StackTrace? stackTrace]) =>
      _sendMessage(LogLevel.warn, message, error, stackTrace);

  /// Sends [message] to main thread as [LogLevel.error].
  void sendMessageAsError(String message,
          [dynamic error, StackTrace? stackTrace]) =>
      _sendMessage(LogLevel.error, message, error, stackTrace);

  /// Sends [message] to main thread as [LogLevel.fatal].
  void sendMessageAsFatal(String message,
          [dynamic error, StackTrace? stackTrace]) =>
      _sendMessage(LogLevel.fatal, message, error, stackTrace);

  /// Sends [message] to main thread as [level].
  void _sendMessage(LogLevel level, String message,
          [dynamic error, StackTrace? stackTrace]) =>
      _isolatedMessages.add(IsolatedLogMessage(
        level: level,
        value: message,
        error: error,
        stackTrace: stackTrace,
      ));
}
