// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:convert';

// Package imports:
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
        jsonDecode('{"latestStableVersion":"${Version.current}"}'));
    expect(status.isLatest, isTrue);
  });

  test('Test when version is the not latest with fromJson()', () {
    final status =
        VersionStatus.fromJson(jsonDecode('{"latestStableVersion":"9.9.9.9"}'));
    expect(status.isLatest, isFalse);
  });

  test('Test when version is the latest with asLatest()', () {
    final status = VersionStatus.asLatest();
    expect(status.isLatest, isTrue);
  });
}
