// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:meta/meta.dart';

// Project imports:
import 'package:batch/src/log/logger_provider.dart';
import 'package:batch/src/version/version_status.dart';

abstract class UpdateNotification {
  /// Returns the new instance of [UpdateNotification].
  factory UpdateNotification() => _UpdateNotification();

  /// The message
  @visibleForTesting
  static const message = '''
  ╔════════════════════════════════════════════════════════════════════════════╗
  ║ UPDATE NOTIFICATION                                                        ║
  ╠════════════════════════════════════════════════════════════════════════════╣
  ║ A new version of Batch.dart is available!                                  ║
  ║                                                                            ║
  ║ * See the latest release at https://pub.dev/packages/batch                 ║
  ║ * Or to update to the latest version, run "dart pub upgrade"               ║
  ╚════════════════════════════════════════════════════════════════════════════╝
''';

  /// Print update notification if it's necessary based on [status].
  Future<void> printIfNecessary(final VersionStatus status);
}

class _UpdateNotification implements UpdateNotification {
  @override
  Future<void> printIfNecessary(final VersionStatus status) async {
    if (status.isLatest) {
      return;
    }

    warn('\n\n${UpdateNotification.message}');
  }
}
