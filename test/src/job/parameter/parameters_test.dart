// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/job/parameter/parameters.dart';

void main() {
  test('Test Parameters', () {
    final parameters = Parameters();
    expect(parameters.isEmpty, true);
    expect(parameters.isNotEmpty, false);

    parameters['testKey'] = 0;
    expect(parameters.isEmpty, false);
    expect(parameters.isNotEmpty, true);
    expect(parameters.contains('testKey'), true);
    expect(parameters.contains('test'), false);
    expect(parameters['testKey'], 0);
    expect(
      () => parameters['test'],
      throwsA(
        allOf(
          isA<ArgumentError>(),
          predicate((dynamic e) =>
              e.message == 'There is no parameter associated with test.'),
        ),
      ),
    );

    expect(parameters.toString(), '[testKey=0]');

    parameters.removeAll();
    expect(parameters.isEmpty, true);
    expect(parameters.isNotEmpty, false);
    expect(parameters.contains('testKey'), false);
  });
}
