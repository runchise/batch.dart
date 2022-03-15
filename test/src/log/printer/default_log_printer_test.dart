// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/input_log_event.dart';
import 'package:batch/src/log/log_level.dart';
import 'package:batch/src/log/printer/default_log_printer.dart';

void main() {
  test('Test DefaultLogPrinter', () {
    final printer = DefaultLogPrinter();
    final message = printer.log(InputLogEvent(
        level: LogLevel.debug, message: 'test', error: null, stackTrace: null));

    expect(() => printer.init(), returnsNormally);
    expect(message[0].substring(message[0].indexOf('[')),
        '[debug] (test.<anonymous closure>:213:7) - test');
    expect(() => printer.dispose(), returnsNormally);
  });
}
