// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';

abstract class Schedule {
  /// Returns the new instance of [Schedule].
  Schedule({
    required this.seconds,
    required this.minutes,
    required this.hours,
    required this.days,
    required this.months,
    required this.weekdays,
  });

  /// The seconds a Task should be started.
  final List<int>? seconds;

  /// The minutes a Task should be started.
  final List<int>? minutes;

  /// The hours a Task should be started.
  final List<int>? hours;

  /// The days a Task should be started.
  final List<int>? days;

  /// The months a Task should be started.
  final List<int>? months;

  /// The weekdays a Task should be started.
  final List<int>? weekdays;

  /// Returns true if this schedule should run at the specified time, otherwise false.
  bool shouldRunAt(final DateTime time);

  /// Returns true if this schedule has seconds field, otherwise false.
  bool get hasSeconds =>
      seconds != null &&
      seconds!.isNotEmpty &&
      (seconds!.length != 1 || !seconds!.contains(0));

  @override
  String toString() {
    return 'Schedule(seconds: $seconds, minutes: $minutes, hours: $hours, days: $days, months: $months, weekdays: $weekdays)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Schedule &&
        listEquals(other.seconds, seconds) &&
        listEquals(other.minutes, minutes) &&
        listEquals(other.hours, hours) &&
        listEquals(other.days, days) &&
        listEquals(other.months, months) &&
        listEquals(other.weekdays, weekdays);
  }

  @override
  int get hashCode {
    return seconds.hashCode ^
        minutes.hashCode ^
        hours.hashCode ^
        days.hashCode ^
        months.hashCode ^
        weekdays.hashCode;
  }
}
