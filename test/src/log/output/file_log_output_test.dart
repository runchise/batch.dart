// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/log_level.dart';
import 'package:batch/src/log/output/file_log_output.dart';
import 'package:batch/src/log/output_log_event.dart';

void main() {
  test('Test FileLogOutput', () {
    final logFile = File('./test.txt');
    final fileOutput = FileLogOutput(file: logFile);

    expect(
      () {
        fileOutput.init();
        fileOutput.output(
          OutputLogEvent(
            level: LogLevel.trace,
            lines: ['test', 'lines'],
          ),
        );
        fileOutput.dispose();
      },
      returnsNormally,
    );

    logFile.delete();
  });
}
