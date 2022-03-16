// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
