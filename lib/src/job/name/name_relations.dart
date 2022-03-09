// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/name/name_relation.dart';

abstract class NameRelations {
  /// Returns the new instance of [NameRelations].
  factory NameRelations() => _NameRelations();

  /// Adds [relation].
  void add(final NameRelation relation);

  /// Returns true if it has [relation], otherwise false.
  bool has(final NameRelation relation);
}

class _NameRelations implements NameRelations {
  /// The relations
  final _relations = <NameRelation>[];

  @override
  void add(final NameRelation relation) => _relations.add(relation);

  @override
  bool has(final NameRelation relation) => _relations.contains(relation);
}
