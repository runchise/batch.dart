// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

abstract class RetryConfiguration {
  /// Returns the new instance of [SkipConfiguration].
  factory RetryConfiguration({
    required List<Exception> retryableExceptions,
    int maxAttempt = 5,
  }) =>
      _RetryConfiguration(
        //! The "is" modifier, which allows reference up to the parent of the target object,
        //! is preferred for type determination, but the right side of the "is" modifier cannot be
        //! a variable due to the Dart language specification. Therefore, type determination is currently
        //! performed by comparing strings.
        retryableExceptions: retryableExceptions
            .map((exception) => exception.runtimeType.toString())
            .toList(),
        maxAttempt: maxAttempt,
      );

  /// Returns the retryable exceptions.
  List<String> get retryableExceptions;

  /// Returns the max attempt of retry.
  int get maxAttempt;
}

class _RetryConfiguration implements RetryConfiguration {
  /// Returns the new instance of [_RetryConfiguration].
  _RetryConfiguration({
    required this.retryableExceptions,
    required this.maxAttempt,
  });

  @override
  final List<String> retryableExceptions;

  @override
  int maxAttempt;
}
