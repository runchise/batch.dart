// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/log/filter/log_filter.dart';
import 'package:batch/src/log/input_log_event.dart';

class DefaultLogFilter extends LogFilter {
  @override
  bool shouldLog(final InputLogEvent event) =>
      event.level.index >= level!.index;
}
