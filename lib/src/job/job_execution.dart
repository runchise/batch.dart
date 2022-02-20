// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/job/execution.dart';
import 'package:batch/src/job/process_status.dart';

class JobExecution extends Execution {
  /// Returns the new instance of [JobExecution].
  JobExecution({
    required String name,
  }) : super(name: name, parentName: '');

  @override
  ProcessStatus status = ProcessStatus.ready;

  @override
  final startedAt = DateTime.now();

  @override
  DateTime updatedAt = DateTime.now();

  @override
  DateTime? finishedAt;
}
