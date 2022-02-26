// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/branch/branch_status.dart';

class BranchContribution {
  /// The branch status for Job
  BranchStatus jobStatus = BranchStatus.succeeded;

  /// The branch status for Step
  BranchStatus stepStatus = BranchStatus.succeeded;

  /// The branch status for Task
  BranchStatus taskStatus = BranchStatus.succeeded;
}
