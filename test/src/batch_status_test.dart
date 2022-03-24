// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/batch_status.dart';

void main() {
  test('Test BatchStatus', () {
    final values = BatchStatus.values;
    expect(values.length, 4);
    expect(BatchStatus.pending.name, 'pending');
    expect(BatchStatus.running.name, 'running');
    expect(BatchStatus.shuttingDown.name, 'shuttingDown');
    expect(BatchStatus.shutdown.name, 'shutdown');
  });
}
