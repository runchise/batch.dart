// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

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
