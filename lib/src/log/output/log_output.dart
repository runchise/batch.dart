// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Project imports:
import 'package:batch/src/log/color/log_color.dart';
import 'package:batch/src/log/output_log_event.dart';

abstract class LogOutput {
  /// The log color
  LogColor? logColor;

  void init() {}

  void output(final OutputLogEvent event);

  void dispose() {}
}
