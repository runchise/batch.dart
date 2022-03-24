// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Project imports:
import 'package:batch/src/log/input_log_event.dart';

abstract class LogPrinter {
  void init() {}

  /// Is called every time a new [LogInputEvent] is sent and handles printing or
  /// storing the message.
  List<String> log(final InputLogEvent event);

  void dispose() {}
}
