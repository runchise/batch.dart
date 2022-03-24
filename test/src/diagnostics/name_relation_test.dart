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
import 'package:batch/src/diagnostics/name_relation.dart';

void main() {
  test('Test Constructor', () {
    final relation = NameRelation(job: 'Job', step: 'Step');
    expect(relation.job, 'Job');
    expect(relation.step, 'Step');
  });

  test('Test == operator', () {
    final relation1 = NameRelation(job: 'Job', step: 'Step');
    final relation2 = NameRelation(job: 'Job', step: 'Step');
    final relation3 = NameRelation(job: 'Job', step: '_Step');

    expect(relation1 == relation1, true);
    expect(relation1 == relation2, true);
    expect(relation1 == relation3, false);
  });

  test('Test toString', () {
    final relation = NameRelation(job: 'Job', step: 'Step');
    expect(relation.toString(), '[job=Job, step=Step]');
  });
}
