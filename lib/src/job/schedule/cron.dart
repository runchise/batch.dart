// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/schedule/schedule.dart';

class Cron implements Schedule {
  /// Returns the new instance of [Cron].
  Cron({
    required this.value,
  });

  /// The schedule value in cron format
  final String value;

  @override
  String build() => value;
}
