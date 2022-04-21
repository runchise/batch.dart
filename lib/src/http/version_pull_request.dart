// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

// Project imports:
import 'package:batch/src/http/request.dart';
import 'package:batch/src/version/version_status.dart';

class VersionPullRequest implements Request<VersionStatus> {
  /// Returns the new instance of [VersionPullRequest].
  VersionPullRequest({this.baseUrl = 'https://pub.dev'});

  /// The resource path
  @visibleForTesting
  static const resourcePath = '/api/documentation/batch';

  @override
  final String baseUrl;

  @override
  Future<VersionStatus> send() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$resourcePath'));
      if (response.statusCode != 200) {
        //! In case of communication failure,
        //! it's considered the version is the latest.
        return VersionStatus.asLatest();
      }

      return VersionStatus.fromJson(jsonDecode(response.body));
    } catch (e) {
      //! In case of communication failure,
      //! it's considered the version is the latest.
      return VersionStatus.asLatest();
    }
  }
}
