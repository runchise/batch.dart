// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:meta/meta.dart';

// Project imports:
import 'package:batch/src/version/version.dart';

abstract class VersionStatus {
  /// Returns the new instance of [VersionStatus].
  factory VersionStatus.fromJson(Map<String, dynamic> json) => _VersionStatus(
        version: json[latestVersionKey] ?? Version.current,
      );

  /// Returns the new instance of [VersionStatus] as the latest.
  factory VersionStatus.asLatest() => _VersionStatus(version: Version.current);

  /// The key for version in JSON response
  @visibleForTesting
  static const latestVersionKey = 'latestStableVersion';

  /// Returns true if this library is the latest, otherwise false.
  bool get isLatest;
}

class _VersionStatus implements VersionStatus {
  /// Returns the new instance of [_VersionStatus].
  _VersionStatus({required String version})
      : isLatest = Version.current == version;

  @override
  final bool isLatest;
}
