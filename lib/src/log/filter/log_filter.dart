// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

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
