// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

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
