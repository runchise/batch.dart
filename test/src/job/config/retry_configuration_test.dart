// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/job/config/retry_configuration.dart';

void main() {
  test('Test RetryConfiguration', () {
    final backOff = Duration(minutes: 20);

    final retryConfig = RetryConfiguration(
      retryableExceptions: [FormatException(), Exception()],
      backOff: backOff,
      maxAttempt: 10,
    );

    expect(retryConfig.retryableExceptions, [
      FormatException().runtimeType.toString(),
      Exception().runtimeType.toString()
    ]);
    expect(retryConfig.backOff, backOff);
    expect(retryConfig.maxAttempt, 10);
  });
}
