// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/log_level.dart';
import 'package:batch/src/log/output_log_event.dart';

void main() {
  test('Test OutputLogEvent', () {
    final event =
        OutputLogEvent(level: LogLevel.debug, lines: ['test', 'lines']);
    expect(event.level, LogLevel.debug);
    expect(event.lines, ['test', 'lines']);
  });
}
