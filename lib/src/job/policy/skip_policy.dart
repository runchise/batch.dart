// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
