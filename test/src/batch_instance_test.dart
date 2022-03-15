// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/batch_instance.dart';
import 'package:batch/src/batch_status.dart';

void main() {
  test('Test singleton instance', () {
    final batchInstance = BatchInstance.instance;
    expect(true, batchInstance == BatchInstance.instance);
  });

  test('Test updateStatus', () {
    final batchInstance = BatchInstance.instance;
    expect(false, batchInstance.isRunning);

    batchInstance.updateStatus(BatchStatus.running);
    expect(true, batchInstance.isRunning);

    batchInstance.updateStatus(BatchStatus.shuttingDown);
    expect(false, batchInstance.isRunning);
    expect(true, batchInstance.isShuttingDown);

    batchInstance.updateStatus(BatchStatus.shutdown);
    expect(false, batchInstance.isRunning);
    expect(false, batchInstance.isShuttingDown);
  });
}
