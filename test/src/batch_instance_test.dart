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
    expect(BatchInstance.isPending, true);

    BatchInstance.updateStatus(BatchStatus.starting);
    expect(BatchInstance.isStarting, true);

    BatchInstance.updateStatus(BatchStatus.running);
    expect(BatchInstance.isRunning, true);

    BatchInstance.updateStatus(BatchStatus.shuttingDown);
    expect(BatchInstance.isRunning, false);
    expect(BatchInstance.isShuttingDown, true);

    BatchInstance.updateStatus(BatchStatus.shutdown);
    expect(BatchInstance.isRunning, false);
    expect(BatchInstance.isShuttingDown, false);
  });
}
