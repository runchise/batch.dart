// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/schedule/model/schedule.dart';

abstract class ScheduleParser<R extends Schedule> {
  /// Returns the parsed [Schedule].
  R parse();
}
