// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class ScheduleParseError implements Error {
  /// Returns the new instance of [ScheduleParseError].
  ScheduleParseError(this.message, {this.stackTrace});

  /// The message
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  String toString() => 'ScheduleParseError: $message';
}
