// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/config/retry_configuration.dart';
import 'package:batch/src/log/logger_provider.dart';

abstract class RetryPolicy {
  /// Returns the new instance of [RetryPolicy].
  factory RetryPolicy({required RetryConfiguration retryConfig}) =>
      _RetryPolicy(retryConfig: retryConfig);

  /// Waits for the specified duration.
  Future<void> wait();

  /// Returns true if [exception] passed as a parameter is a retryable, otherwise false.
  bool shouldRetry(final Exception exception);

  /// Returns true if [retryCount] is exceeded, otherwise false.
  bool isExceeded(final int retryCount);
}

/// The implementation class of [RetryPolicy].
class _RetryPolicy implements RetryPolicy {
  /// Returns the new instance of [_RetryPolicy].
  _RetryPolicy({required this.retryConfig});

  /// The retry configuration
  final RetryConfiguration retryConfig;

  @override
  Future<void> wait() async {
    if (retryConfig.backOff == null) {
      return;
    }

    warn('Wait ${retryConfig.backOff} before execute retry');
    await Future.delayed(retryConfig.backOff!);
  }

  @override
  bool shouldRetry(final Exception exception) => retryConfig.retryableExceptions
      .contains(exception.runtimeType.toString());

  @override
  bool isExceeded(final int retryCount) => retryCount >= retryConfig.maxAttempt;
}
