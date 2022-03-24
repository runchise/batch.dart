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
import 'package:batch/src/job/error/unique_constraint_error.dart';

void main() {
  test('Test UniqueConstraintError', () {
    final stackTrace = StackTrace.current;
    final error = UniqueConstraintError('error test', stackTrace: stackTrace);
    // ignore: unnecessary_type_check
    expect(error is Error, true);
    expect(error.message, 'error test');
    expect(error.stackTrace, stackTrace);
    expect(error.toString(), 'UniqueConstraintError: error test');
  });
}
