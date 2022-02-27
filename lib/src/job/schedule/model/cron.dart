// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/schedule/model/schedule.dart';

class Cron extends Schedule {
  /// Returns the new instance of [Cron].
  Cron({
    required List<int>? seconds,
    required List<int>? minutes,
    required List<int>? hours,
    required List<int>? days,
    required List<int>? months,
    required List<int>? weekdays,
  }) : super(
          seconds: seconds,
          minutes: minutes,
          hours: hours,
          days: days,
          months: months,
          weekdays: weekdays,
        );

  @override
  bool shouldRunAt(final DateTime time) {
    if (seconds?.contains(time.second) == false) return false;
    if (minutes?.contains(time.minute) == false) return false;
    if (hours?.contains(time.hour) == false) return false;
    if (days?.contains(time.day) == false) return false;
    if (months?.contains(time.month) == false) return false;
    return true;
  }
}
