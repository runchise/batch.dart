// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/log_configuration.dart';
import 'package:batch/src/log/log_level.dart';

void main() {
  test('Test LogConfiguration without parameters', () {
    final logConfig = LogConfiguration();
    expect(logConfig.level, null);
    expect(logConfig.filter, null);
    expect(logConfig.printer, null);
    expect(logConfig.color, null);
    expect(logConfig.printLog, true);
  });

  test('Test LogConfiguration with parameters', () {
    final logConfig = LogConfiguration(
      level: LogLevel.info,
      printLog: false,
    );

    expect(logConfig.level, LogLevel.info);
    expect(logConfig.printLog, false);
  });
}
