// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Project imports:
import 'package:batch/src/job/config/skip_configuration.dart';

abstract class SkipPolicy {
  /// Returns the new instance of [SkipPolicy].
  factory SkipPolicy({required SkipConfiguration skipConfig}) =>
      _SkipPolicy(skipConfig: skipConfig);

  /// Returns true if [exception] passed as a parameter can be skipped, otherwise false.
  bool shouldSkip(final Exception exception);
}

/// The implementation class of [SkipPolicy].
class _SkipPolicy implements SkipPolicy {
  /// Returns the new instance of [_SkipPolicy].
  _SkipPolicy({required this.skipConfig});

  /// The skip configuration
  final SkipConfiguration skipConfig;

  @override
  bool shouldSkip(final Exception exception) =>
      skipConfig.skippableExceptions.contains(exception.runtimeType.toString());
}
