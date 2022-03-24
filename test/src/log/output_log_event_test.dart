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
import 'package:batch/src/log/output_log_event.dart';

void main() {
  test('Test OutputLogEvent', () {
    final event =
        OutputLogEvent(level: LogLevel.debug, lines: ['test', 'lines']);
    expect(event.level, LogLevel.debug);
    expect(event.lines, ['test', 'lines']);
  });
}
