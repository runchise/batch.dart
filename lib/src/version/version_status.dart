// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

abstract class VersionStatus {
  /// Returns the new instance of [VersionStatus].
  factory VersionStatus({
    required String currentVersion,
    required String latestVersion,
  }) =>
      _VersionStatus(
        currentVersion: currentVersion,
        latestVersion: latestVersion,
      );

  /// Returns the current version.
  String get currentVersion;

  /// Returns the latest version.
  String get latestVersion;

  /// Returns true if this library is the latest, otherwise false.
  bool get isLatest;
}

class _VersionStatus implements VersionStatus {
  /// Returns the new instance of [_VersionStatus].
  _VersionStatus({
    required this.currentVersion,
    required this.latestVersion,
  }) : isLatest = currentVersion == latestVersion;

  @override
  final String currentVersion;

  @override
  final String latestVersion;

  @override
  final bool isLatest;
}
