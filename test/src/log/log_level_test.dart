// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/log_level.dart';

void main() {
  test('Test LogLevel', () {
    expect(LogLevel.values.length, 6);
    expect(LogLevel.trace.name, 'trace');
    expect(LogLevel.debug.name, 'debug');
    expect(LogLevel.info.name, 'info');
    expect(LogLevel.warn.name, 'warn');
    expect(LogLevel.error.name, 'error');
    expect(LogLevel.fatal.name, 'fatal');
  });
}
