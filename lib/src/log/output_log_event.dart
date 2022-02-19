// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:collection/collection.dart';

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

  @override
  String toString() => 'OutputLogEvent(level: $level, lines: $lines)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is OutputLogEvent &&
        other.level == level &&
        listEquals(other.lines, lines);
  }

  @override
  int get hashCode => level.hashCode ^ lines.hashCode;
}
