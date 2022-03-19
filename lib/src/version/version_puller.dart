// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:http/http.dart' as http;
import 'package:json_response/json_response.dart';

// Project imports:
import 'package:batch/src/version/version.dart';

abstract class VersionPuller {
  /// Returns the new instance of [VersionPuller].
  factory VersionPuller() => _VersionPuller();

  Future<String> execute();
}

class _VersionPuller implements VersionPuller {
  @override
  Future<String> execute() async {
    try {
      final response = await http.get(
        Uri.parse('https://pub.dev/api/documentation/batch'),
      );

      if (response.statusCode != 200) {
        //! In case of communication failure,
        //! it's considered the version is the latest.
        return Version().current;
      }

      return Json.from(
        response: response,
      ).getString(key: 'latestStableVersion', defaultValue: Version().current);
    } on Exception {
      //! In case of communication failure,
      //! it's considered the version is the latest.
      return Version().current;
    }
  }
}
