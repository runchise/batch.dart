// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

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
