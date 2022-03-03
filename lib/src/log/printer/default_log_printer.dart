// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/log/input_log_event.dart';
import 'package:batch/src/log/printer/log_printer.dart';

/// The default printer.
class DefaultLogPrinter extends LogPrinter {
  @override
  List<String> log(final InputLogEvent event) => _buildBuffer(event);

  String _buildHeader(final InputLogEvent event) =>
      '${DateTime.now().toString().padRight(26, '0')} [${event.level.name.padRight(5, ' ')}]';

  String _stringifyMessage(final dynamic message) =>
      message is Function ? message() : message.toString();

  List<String> _buildBuffer(final InputLogEvent event) {
    final buffer = <String>[];
    buffer.add('${_buildHeader(event)} - ${_stringifyMessage(event.message)}');

    if (event.error != null) {
      buffer.add(event.error.toString());
    }

    if (event.stackTrace != null) {
      buffer.add(event.stackTrace.toString());
    }

    return buffer;
  }
}
