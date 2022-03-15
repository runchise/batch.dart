// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/runner.dart';

class TestRunner implements Runner {
  bool result = false;
  @override
  void run() => result = true;
}

void main() {
  test('Test Runner', () {
    final runner = TestRunner();
    runner.run();
    expect(true, runner.result);
  });
}
