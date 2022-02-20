// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/context/execution.dart';
import 'package:batch/src/job/context/process_status.dart';

class StepExecution extends Execution {
  /// Returns the new instance of [StepExecution].
  StepExecution({
    required String name,
    required String parentJobName,
  }) : super(name: name, parentName: parentJobName);

  @override
  ProcessStatus status = ProcessStatus.ready;

  @override
  final startedAt = DateTime.now();

  @override
  DateTime updatedAt = DateTime.now();

  @override
  DateTime? finishedAt;
}
