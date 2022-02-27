// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class ScheduleParseException implements Exception {
  /// Returns the new instance of [ScheduleParseException].
  ScheduleParseException(this.message);

  /// The message
  final String message;

  @override
  String toString() => 'ScheduleParseException: $message';
}
