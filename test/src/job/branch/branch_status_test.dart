// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/job/branch/branch_status.dart';

void main() {
  test('Test BranchStatus', () {
    expect(BranchStatus.values.length, 3);
    expect(BranchStatus.succeeded.name, 'succeeded');
    expect(BranchStatus.failed.name, 'failed');
    expect(BranchStatus.completed.name, 'completed');
  });
}
