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
import 'package:batch/src/log/filter/default_log_filter.dart';
import 'package:batch/src/log/input_log_event.dart';
import 'package:batch/src/log/log_level.dart';

void main() {
  test('Test DefaultLogFilter in trace level', () {
    final filter = DefaultLogFilter();
    filter.level = LogLevel.trace;

    for (final logLevel in LogLevel.values) {
      expect(
        filter.shouldLog(InputLogEvent(
            level: logLevel, message: '', error: null, stackTrace: null)),
        true,
      );
    }
  });

  test('Test DefaultLogFilter in debug level', () {
    final filter = DefaultLogFilter();
    filter.level = LogLevel.debug;

    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.trace, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.debug, message: '', error: null, stackTrace: null)),
      true,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.info, message: '', error: null, stackTrace: null)),
      true,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.warn, message: '', error: null, stackTrace: null)),
      true,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.error, message: '', error: null, stackTrace: null)),
      true,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.fatal, message: '', error: null, stackTrace: null)),
      true,
    );
  });

  test('Test DefaultLogFilter in info level', () {
    final filter = DefaultLogFilter();
    filter.level = LogLevel.info;

    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.trace, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.debug, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.info, message: '', error: null, stackTrace: null)),
      true,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.warn, message: '', error: null, stackTrace: null)),
      true,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.error, message: '', error: null, stackTrace: null)),
      true,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.fatal, message: '', error: null, stackTrace: null)),
      true,
    );
  });

  test('Test DefaultLogFilter in warn level', () {
    final filter = DefaultLogFilter();
    filter.level = LogLevel.warn;

    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.trace, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.debug, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.info, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.warn, message: '', error: null, stackTrace: null)),
      true,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.error, message: '', error: null, stackTrace: null)),
      true,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.fatal, message: '', error: null, stackTrace: null)),
      true,
    );
  });

  test('Test DefaultLogFilter in error level', () {
    final filter = DefaultLogFilter();
    filter.level = LogLevel.error;

    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.trace, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.debug, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.info, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.warn, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.error, message: '', error: null, stackTrace: null)),
      true,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.fatal, message: '', error: null, stackTrace: null)),
      true,
    );
  });

  test('Test DefaultLogFilter in fatal level', () {
    final filter = DefaultLogFilter();
    filter.level = LogLevel.fatal;

    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.trace, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.debug, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.info, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.warn, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.error, message: '', error: null, stackTrace: null)),
      false,
    );
    expect(
      filter.shouldLog(InputLogEvent(
          level: LogLevel.fatal, message: '', error: null, stackTrace: null)),
      true,
    );
  });
}
