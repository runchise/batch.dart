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
