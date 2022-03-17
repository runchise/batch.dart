// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/builder.dart';

void main() {
  test('Test Builder', () {
    expect(_Builder().build(), 'success');
  });
}

class _Builder implements Builder<String> {
  @override
  String build() => 'success';
}
