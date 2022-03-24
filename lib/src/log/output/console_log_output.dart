// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Project imports:
import 'package:batch/src/log/output/log_output.dart';
import 'package:batch/src/log/output_log_event.dart';

/// Default implementation of [LogOutput].
///
/// It sends everything to the system console.
class ConsoleLogOutput extends LogOutput {
  @override
  void output(final OutputLogEvent event) => event.lines
      .map((message) => logColor![event.level](message))
      .toList()
      .forEach(print);
}
