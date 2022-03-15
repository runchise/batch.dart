// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/batch.dart';
import 'package:batch/src/log/color/ansi_color.dart';

void main() {
  test('Test with none constructor', () {
    final ansiColor = AnsiColor.none();
    expect(ansiColor.call('test'), 'test');
    expect(ansiColor.toString(), '');
  });

  test('Test with foreground constructor', () {
    final ansiColor = AnsiColor.foreground(ConsoleColor.aqua);
    expect(ansiColor.call('test'), '\x1B[38;5;14mtest\x1B[0m');
    expect(ansiColor.toString(), '\x1B[38;5;14m');
  });
}
