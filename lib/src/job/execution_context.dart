// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/job/job_execution.dart';
import 'package:batch/src/job/step_execution.dart';

class ExecutionContext {
  ExecutionContext({
    required this.jobExecution,
    required this.stepExecution,
  });

  final JobExecution jobExecution;

  final StepExecution stepExecution;
}
