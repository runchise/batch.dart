// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/job/config/skip_configuration.dart';
import 'package:batch/src/job/policy/skip_policy.dart';

void main() {
  test('Test SkipPolicy', () {
    final skipPolicy = SkipPolicy(
      skipConfig: SkipConfiguration(
        skippableExceptions: [FormatException()],
      ),
    );

    expect(skipPolicy.shouldSkip(FormatException()), true);
    expect(skipPolicy.shouldSkip(_TestException()), false);
  });
}

class _TestException implements Exception {}
