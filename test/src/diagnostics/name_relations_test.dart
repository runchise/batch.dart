// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/diagnostics/name_relation.dart';
import 'package:batch/src/diagnostics/name_relations.dart';

void main() {
  test('Test NameRelations', () {
    final relation1 = NameRelation(job: 'Job1', step: 'Step1');
    final relation2 = NameRelation(job: 'Job2', step: 'Step3');
    final relation3 = NameRelation(job: 'Job1', step: 'Step1');

    final relations = NameRelations();
    relations.add(relation1);

    expect(relations.has(relation1), true);
    expect(relations.has(relation3), true);
    expect(relations.has(relation2), false);
  });
}
