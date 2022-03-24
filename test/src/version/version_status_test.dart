// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Package imports:
import 'package:http/http.dart';
import 'package:json_response/json_response.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/version/version.dart';
import 'package:batch/src/version/version_status.dart';

void main() {
  test('Test json key', () {
    expect(VersionStatus.latestVersionKey, 'latestStableVersion');
  });

  test('Test when version is the latest with fromJson()', () {
    final status = VersionStatus.fromJson(
      json: Json.from(
        response: Response('{"latestStableVersion":"${Version.current}"}', 200),
      ),
    );

    expect(status.isLatest, isTrue);
  });

  test('Test when version is the not latest with fromJson()', () {
    final status = VersionStatus.fromJson(
      json: Json.from(
        response: Response('{"latestStableVersion":"9.9.9.9"}', 200),
      ),
    );

    expect(status.isLatest, isFalse);
  });

  test('Test when version is the latest with asLatest()', () {
    final status = VersionStatus.asLatest();
    expect(status.isLatest, isTrue);
  });
}
