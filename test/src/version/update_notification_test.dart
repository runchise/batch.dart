// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:http/http.dart';
import 'package:json_response/json_response.dart';
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
    Logger.loadFrom(config: LogConfiguration());

    final notification = UpdateNotification();
    final notLatestStatus = VersionStatus.fromJson(
      json: Json.from(
        response: Response(
          '{"latestStableVersion":"9.9.9.9"}',
          200,
        ),
      ),
    );

    expect(() async => await notification.printIfNecessary(notLatestStatus),
        returnsNormally);
  });
}
