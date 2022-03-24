// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/log_level.dart';
import 'package:batch/src/log/output/log_output.dart';
import 'package:batch/src/log/output_log_event.dart';

void main() {
  test('Test LogOutput', () {
    final logOutput = _LogOutput();
    expect(() => logOutput.init(), returnsNormally);
    expect(
      () => logOutput.output(
        OutputLogEvent(
          level: LogLevel.fatal,
          lines: ['test', 'lines'],
        ),
      ),
      returnsNormally,
    );
    expect(() => logOutput.dispose(), returnsNormally);
  });
}

class _LogOutput extends LogOutput {
  @override
  void init() {}

  @override
  void output(OutputLogEvent event) {
    expect(event.level, LogLevel.fatal);
    expect(event.lines, ['test', 'lines']);
  }

  @override
  void dispose() {}
}
