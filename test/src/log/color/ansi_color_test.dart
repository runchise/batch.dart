// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

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
