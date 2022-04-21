// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/batch.dart';
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/version/update_notification.dart';
import 'package:batch/src/version/version_status.dart';

void main() {
  test('Test when version status is the latest', () {
    final notification = UpdateNotification();
    final latestStatus = VersionStatus.asLatest();

    expect(() async => await notification.printIfNecessary(latestStatus),
        returnsNormally);
  });

  test('Test when version status is not the latest', () {
    //! Required to load logger to run printIfNecessary when status is not the latest.
    Logger.loadFromConfig(LogConfiguration());

    final notification = UpdateNotification();
    final notLatestStatus =
        VersionStatus.fromJson(jsonDecode('{"latestStableVersion":"9.9.9.9"}'));

    expect(() async => await notification.printIfNecessary(notLatestStatus),
        returnsNormally);
  });
}
