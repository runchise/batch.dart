// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/color/log_color.dart';
import 'package:batch/src/log/log_level.dart';
import 'package:batch/src/log/output/console_log_output.dart';
import 'package:batch/src/log/output_log_event.dart';

void main() {
  test('Test ConsoleLogOutput', () {
    final console = ConsoleLogOutput();
    console.logColor = LogColor();

    expect(() => console.init(), returnsNormally);
    expect(
      () => console.output(
        OutputLogEvent(
          level: LogLevel.debug,
          lines: ['test', 'lines'],
        ),
      ),
      returnsNormally,
    );
    expect(() => console.dispose(), returnsNormally);
  });
}
