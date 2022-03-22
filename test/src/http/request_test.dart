// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:http/src/response.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/http/request.dart';

void main() {
  test('Test Request', () async {
    final request = _Request();
    expect(request.baseUrl, 'testBaseUrl');

    final response = await request.send();
    expect(response.body, 'test');
    expect(response.statusCode, 200);
  });
}

class _Request implements Request {
  @override
  Future<Response> send() async => Response('test', 200);

  @override
  String get baseUrl => 'testBaseUrl';
}
