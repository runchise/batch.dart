// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

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
