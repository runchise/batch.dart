// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/filter/log_filter.dart';
import 'package:batch/src/log/input_log_event.dart';
import 'package:batch/src/log/log_level.dart';

void main() {
  test('Test LogFilter', () {
    final logFilter = _LogFilter();
    expect(() => logFilter.init(), returnsNormally);
    expect(
        () => logFilter.shouldLog(InputLogEvent(
              level: LogLevel.debug,
              message: 'test',
              error: null,
              stackTrace: null,
            )),
        returnsNormally);
    expect(() => logFilter.dispose(), returnsNormally);
  });
}

class _LogFilter implements LogFilter {
  @override
  LogLevel? level;

  @override
  void init() {}

  @override
  bool shouldLog(InputLogEvent event) {
    expect(event.level, LogLevel.debug);
    expect(event.message, 'test');
    expect(event.error, null);
    expect(event.stackTrace, null);
    return true;
  }

  @override
  void dispose() {}
}
