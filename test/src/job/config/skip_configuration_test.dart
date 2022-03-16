// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/job/config/skip_configuration.dart';

void main() {
  test('Test SkipConfiguration', () {
    final skipConfig = SkipConfiguration(
      skippableExceptions: [FormatException(), Exception()],
    );

    expect(skipConfig.skippableExceptions, [
      FormatException().runtimeType.toString(),
      Exception().runtimeType.toString()
    ]);
  });
}
