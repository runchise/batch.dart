// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:io';

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/version/version.dart';

void main() {
  test('Matches with the current package version in pubspec.yaml', () {
    final versionRegex = RegExp(
        r"version\:.(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?");

    final path = '${Directory.current.path}/pubspec.yaml';
    String data = File(path).readAsStringSync();
    String? version =
        versionRegex.stringMatch(data)?.replaceFirst('version: ', '');

    expect(version != null, true);
    expect(Version.current, version);
  });

  test('Test get status when network is connected', () async {
    final status = await Version().status;
    expect(status, isNotNull);
  });
}
