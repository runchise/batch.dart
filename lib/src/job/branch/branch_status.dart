// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

enum BranchStatus {
  /// This element indicates that a particular task process has finished successfully.
  succeeded,

  /// This element indicates that a particular task process has failed.
  failed,

  /// This element indicates that a particular task process will always be executed
  /// regardless of whether it succeeds or fails.
  completed,
}
