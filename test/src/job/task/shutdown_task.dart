// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/batch_instance.dart';
import 'package:batch/src/batch_status.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/task/shutdown_task.dart';

void main() {
  test('Test ShutdownTask', () {
    BatchInstance.instance.updateStatus(BatchStatus.running);
    expect(BatchInstance.instance.isRunning, true);
    ShutdownTask().execute(ExecutionContext());
    expect(BatchInstance.instance.isRunning, false);
    expect(BatchInstance.instance.isShuttingDown, true);
  });
}
