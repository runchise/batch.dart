// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';

abstract class RetryConfiguration {
  /// Returns the new instance of [SkipConfiguration].
  factory RetryConfiguration({
    required List<Exception> retryableExceptions,
    int maxAttempt = 5,
    Duration? backOff,
    Function(ExecutionContext context)? onRecover,
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
        backOff: backOff,
        onRecover: onRecover,
      );

  /// Returns the retryable exceptions.
  List<String> get retryableExceptions;

  /// Returns the max attempt of retry.
  int get maxAttempt;

  /// Returns the back off duration.
  Duration? get backOff;

  /// The callback to be executed when all retries have failed the specified [maxAttempt].
  Function(ExecutionContext context)? get onRecover;
}

class _RetryConfiguration implements RetryConfiguration {
  /// Returns the new instance of [_RetryConfiguration].
  _RetryConfiguration({
    required this.retryableExceptions,
    required this.maxAttempt,
    required this.backOff,
    required this.onRecover,
  });

  @override
  final List<String> retryableExceptions;

  @override
  final int maxAttempt;

  @override
  final Duration? backOff;

  @override
  final Function(ExecutionContext context)? onRecover;
}
