// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/batch_status.dart';

void main() {
  test('Test BatchStatus', () {
    final values = BatchStatus.values;
    expect(4, values.length);
    expect('pending', BatchStatus.pending.name);
    expect('running', BatchStatus.running.name);
    expect('shuttingDown', BatchStatus.shuttingDown.name);
    expect('shutdown', BatchStatus.shutdown.name);
  });
}
