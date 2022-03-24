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
import 'package:batch/src/banner/banner.dart';

void main() {
  test('Test Banner', () {
    expect(_Banner().build(), 'success');
  });
}

class _Banner implements Banner {
  @override
  String build() {
    return 'success';
  }
}
