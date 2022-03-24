// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/batch_instance.dart';
import 'package:batch/src/batch_status.dart';

void main() {
  test('Test singleton instance', () {
    final batchInstance = BatchInstance.instance;
    expect(batchInstance == BatchInstance.instance, true);
  });

  test('Test updateStatus', () {
    final batchInstance = BatchInstance.instance;
    expect(batchInstance.isRunning, false);

    batchInstance.updateStatus(BatchStatus.running);
    expect(batchInstance.isRunning, true);

    batchInstance.updateStatus(BatchStatus.shuttingDown);
    expect(batchInstance.isRunning, false);
    expect(batchInstance.isShuttingDown, true);

    batchInstance.updateStatus(BatchStatus.shutdown);
    expect(batchInstance.isRunning, false);
    expect(batchInstance.isShuttingDown, false);
  });
}
