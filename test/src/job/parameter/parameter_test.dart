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
import 'package:batch/src/job/parameter/parameter.dart';

void main() {
  test('Test Parameter with String value', () {
    final parameter = Parameter(key: 'test', value: 'testValue');
    expect(parameter.key, 'test');
    expect(parameter.value, 'testValue');
    expect(parameter.toString(), 'test=testValue');
  });

  test('Test Parameter with int value', () {
    final parameter = Parameter(key: 'test', value: 0);
    expect(parameter.key, 'test');
    expect(parameter.value, 0);
    expect(parameter.toString(), 'test=0');
  });

  test('Test Parameter with double value', () {
    final parameter = Parameter(key: 'test', value: 1.0);
    expect(parameter.key, 'test');
    expect(parameter.value, 1.0);
    expect(parameter.toString(), 'test=1.0');
  });

  test('Test Parameter with boolean value', () {
    final parameter = Parameter(key: 'test', value: true);
    expect(parameter.key, 'test');
    expect(parameter.value, true);
    expect(parameter.toString(), 'test=true');
  });

  test('Test Parameter with object', () {
    final parameter = Parameter(key: 'test', value: {'test2': 'value'});
    expect(parameter.key, 'test');
    expect(parameter.value, {'test2': 'value'});
    expect(parameter.toString(), 'test={test2: value}');
  });
}
