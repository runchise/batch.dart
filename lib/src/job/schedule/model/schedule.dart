// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

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
}
