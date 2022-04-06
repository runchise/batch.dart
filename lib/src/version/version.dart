// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/http/version_pull_request.dart';
import 'package:batch/src/version/version_status.dart';

abstract class Version {
  /// Returns the new instance of [Version].
  factory Version() => _Version();

  /// The current version
  static const current = '0.8.0';

  /// Returns the version status.
  Future<VersionStatus> get status;
}

class _Version implements Version {
  @override
  Future<VersionStatus> get status async => await VersionPullRequest().send();
}
