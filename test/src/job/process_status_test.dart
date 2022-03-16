// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/job/process_status.dart';

void main() {
  test('Test ProcessStatus', () {
    expect(ProcessStatus.values.length, 3);
    expect(ProcessStatus.running.name, 'running');
    expect(ProcessStatus.completed.name, 'completed');
    expect(ProcessStatus.skipped.name, 'skipped');
  });
}
