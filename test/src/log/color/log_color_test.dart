// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:console_color/console_color.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/color/log_color.dart';
import 'package:batch/src/log/log_level.dart';

void main() {
  test('Test default colors', () {
    final logColor = LogColor();
    expect(logColor[LogLevel.trace].toString(),
        '\x1B[38;5;${ConsoleColor.grey.code}m');
    expect(logColor[LogLevel.debug].toString(),
        '\x1B[38;5;${ConsoleColor.paleGreen10.code}m');
    expect(logColor[LogLevel.info].toString(),
        '\x1B[38;5;${ConsoleColor.cyan1.code}m');
    expect(logColor[LogLevel.warn].toString(),
        '\x1B[38;5;${ConsoleColor.orange1.code}m');
    expect(logColor[LogLevel.error].toString(),
        '\x1B[38;5;${ConsoleColor.red.code}m');
    expect(logColor[LogLevel.fatal].toString(),
        '\x1B[38;5;${ConsoleColor.paleVioletRed1.code}m');
  });

  test('Test specified colors', () {
    final logColor = LogColor(
      trace: ConsoleColor.blue,
      debug: ConsoleColor.darkBlue,
      info: ConsoleColor.lightGoldenrod20,
      warn: ConsoleColor.indianRed12,
      error: ConsoleColor.plum1,
      fatal: ConsoleColor.aquamarine10,
    );

    expect(logColor[LogLevel.trace].toString(),
        '\x1B[38;5;${ConsoleColor.blue.code}m');
    expect(logColor[LogLevel.debug].toString(),
        '\x1B[38;5;${ConsoleColor.darkBlue.code}m');
    expect(logColor[LogLevel.info].toString(),
        '\x1B[38;5;${ConsoleColor.lightGoldenrod20.code}m');
    expect(logColor[LogLevel.warn].toString(),
        '\x1B[38;5;${ConsoleColor.indianRed12.code}m');
    expect(logColor[LogLevel.error].toString(),
        '\x1B[38;5;${ConsoleColor.plum1.code}m');
    expect(logColor[LogLevel.fatal].toString(),
        '\x1B[38;5;${ConsoleColor.aquamarine10.code}m');
  });

  test('Test no colors', () {
    final logColor = LogColor.none();
    expect(logColor[LogLevel.trace].toString(), '');
    expect(logColor[LogLevel.debug].toString(), '');
    expect(logColor[LogLevel.info].toString(), '');
    expect(logColor[LogLevel.warn].toString(), '');
    expect(logColor[LogLevel.error].toString(), '');
    expect(logColor[LogLevel.fatal].toString(), '');
  });
}
