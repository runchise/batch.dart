// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:mock_web_server/mock_web_server.dart';
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/http/version_pull_request.dart';

void main() {
  /// The web server for testing
  final _mockServer = MockWebServer(port: 8081);

  setUp(() async => await _mockServer.start());
  tearDown(() => _mockServer.shutdown());

  test('Test fields', () {
    expect(VersionPullRequest().baseUrl, 'https://pub.dev');
    expect(VersionPullRequest.resourcePath, '/api/documentation/batch');
  });

  test('Test when status code is 200', () async {
    _mockServer.enqueueResponse(MockResponse()..httpCode = 200);

    final response =
        await VersionPullRequest(baseUrl: 'http://127.0.0.1:8081').send();
    expect(response, isNotNull);
    expect(response.isLatest, isTrue);

    final request = _mockServer.takeRequest();
    expect(request.uri.path, '/api/documentation/batch');
  });

  test('Test when status code is 200 and not the latest', () async {
    _mockServer.enqueueResponse(
      MockResponse()
        ..body = '{"latestStableVersion": "9.9.9.9"}'
        ..httpCode = 200,
    );

    final response =
        await VersionPullRequest(baseUrl: 'http://127.0.0.1:8081').send();
    expect(response, isNotNull);
    expect(response.isLatest, isFalse);

    final request = _mockServer.takeRequest();
    expect(request.uri.path, '/api/documentation/batch');
  });

  test('Test when status code is not 200', () async {
    _mockServer.enqueueResponse(MockResponse()..httpCode = 201);

    final response =
        await VersionPullRequest(baseUrl: 'http://127.0.0.1:8081').send();
    expect(response, isNotNull);
    expect(response.isLatest, isTrue);

    final request = _mockServer.takeRequest();
    expect(request.uri.path, '/api/documentation/batch');
  });

  test('Test when status code is not 200 and not the latest', () async {
    _mockServer.enqueueResponse(
      MockResponse()
        ..body = '{"latestStableVersion": "9.9.9.9"}'
        ..httpCode = 201,
    );

    final response =
        await VersionPullRequest(baseUrl: 'http://127.0.0.1:8081').send();
    expect(response, isNotNull);
    expect(response.isLatest, isTrue);

    final request = _mockServer.takeRequest();
    expect(request.uri.path, '/api/documentation/batch');
  });

  test('Test when exception throws', () async {
    _mockServer.enqueueResponse(
      MockResponse()..httpCode = 404,
    );

    final response = await VersionPullRequest(baseUrl: '').send();
    expect(response, isNotNull);
    expect(response.isLatest, isTrue);
  });
}
