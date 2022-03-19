// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/version/version_puller.dart';
import 'package:batch/src/version/version_status.dart';

abstract class Version {
  /// Returns the new instance of [Version].
  factory Version() => _Version();

  /// The url to pull and check version
  static const pullUrl = 'https://pub.dev/api/documentation/batch';

  /// Returns the current version.
  String get current;

  /// Returns the version status.
  Future<VersionStatus> get status;
}

class _Version implements Version {
  @override
  final String current = '0.5.1';

  @override
  Future<VersionStatus> get status async {
    final pulledVersion = await VersionPuller().execute();

    return VersionStatus(
      currentVersion: current,
      latestVersion: pulledVersion,
    );
  }
}
