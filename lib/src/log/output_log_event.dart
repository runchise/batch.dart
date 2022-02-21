// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/batch.dart';

class OutputLogEvent {
  /// Returns the new instance of [OutputLogEvent].
  OutputLogEvent({
    required this.level,
    required this.lines,
  });

  /// The log level
  final LogLevel level;

  /// The lines
  final List<String> lines;
}
