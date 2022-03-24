// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Project imports:
import 'package:batch/src/log/input_log_event.dart';
import 'package:batch/src/log/log_level.dart';

abstract class LogFilter {
  /// The log level
  LogLevel? level;

  void init() {}

  bool shouldLog(final InputLogEvent event);

  void dispose() {}
}
