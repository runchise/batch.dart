// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/batch.dart';

/// The class that represents log.
///
/// It manages the information for log output.
class InputLogEvent {
  /// Returns the new instance of [LogEvent].
  InputLogEvent.from({
    required this.level,
    required this.message,
    required this.error,
    required this.stackTrace,
  });

  /// The log level
  final LogLevel level;

  /// The message in any format
  final dynamic message;

  /// The error in any format
  final dynamic error;

  /// The stacktrace
  final StackTrace? stackTrace;

  @override
  String toString() {
    return 'InputLogEvent(level: $level, message: $message, error: $error, stackTrace: $stackTrace)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InputLogEvent &&
        other.level == level &&
        other.message == message &&
        other.error == error &&
        other.stackTrace == stackTrace;
  }

  @override
  int get hashCode {
    return level.hashCode ^
        message.hashCode ^
        error.hashCode ^
        stackTrace.hashCode;
  }
}
