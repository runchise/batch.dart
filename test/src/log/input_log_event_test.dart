// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/input_log_event.dart';
import 'package:batch/src/log/log_level.dart';

void main() {
  test('Test InputLogEvent', () {
    final error = ArgumentError();
    final stackTrace = StackTrace.current;

    final event = InputLogEvent(
      level: LogLevel.error,
      message: 'test',
      error: error,
      stackTrace: stackTrace,
    );

    expect(event.level, LogLevel.error);
    expect(event.message, 'test');
    expect(event.error, error);
    expect(event.stackTrace, stackTrace);
  });
}
