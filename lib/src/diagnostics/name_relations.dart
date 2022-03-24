// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Project imports:
import 'package:batch/src/diagnostics/name_relation.dart';

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
