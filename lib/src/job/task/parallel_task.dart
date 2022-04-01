// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/event/task.dart';
import 'package:batch/src/job/parallel/isolated_log_message.dart';
import 'package:batch/src/log/log_level.dart';

abstract class ParallelTask<T extends Task<T>> extends Task<T> {
  /// The isolated messages
  late List<IsolatedLogMessage> _isolatedMessages;

  @override
  FutureOr<void> execute(ExecutionContext context) async {
    _isolatedMessages = context.stepParameters['isolatedLogMessages'];

    try {
      await invoke();
    } catch (e) {
      rethrow;
    }
  }

  /// Sends [message] to main thread as [LogLevel.info].
  void sendMessageAsTrace(String message) =>
      _sendMessage(LogLevel.info, message);

  /// Sends [message] to main thread as [LogLevel.debug].
  void sendMessageAsDebug(String message) =>
      _sendMessage(LogLevel.debug, message);

  /// Sends [message] to main thread as [LogLevel.info].
  void sendMessageAsInfo(String message) =>
      _sendMessage(LogLevel.info, message);

  /// Sends [message] to main thread as [LogLevel.warn].
  void sendMessageAsWarn(String message) =>
      _sendMessage(LogLevel.warn, message);

  /// Sends [message] to main thread as [LogLevel.error].
  void sendMessageAsError(String message) =>
      _sendMessage(LogLevel.error, message);

  /// Sends [message] to main thread as [LogLevel.fatal].
  void sendMessageAsFatal(String message) =>
      _sendMessage(LogLevel.fatal, message);

  /// Sends [message] to main thread as [level].
  void _sendMessage(LogLevel level, String message) =>
      _isolatedMessages.add(IsolatedLogMessage(level: level, value: message));

  /// Invokes piece of parallel processing.
  FutureOr<void> invoke();
}
