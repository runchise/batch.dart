// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/schedule/cron.dart';

abstract class Schedule {
  factory Schedule.cron({required String value}) => Cron(value: value);

  String build();
}
