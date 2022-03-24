// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

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
              e.message == 'There is no parameter associated with [key=test].'),
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
