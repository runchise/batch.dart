// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

enum ParameterScope {
  /// This element indicates the scope that can be shared among multiple jobs
  /// in the batch process.
  global,

  /// This element indicates the scope that can be shared among multiple steps
  /// in the same job.
  job,

  /// This element indicates the scope that can be shared among multiple tasks
  /// in the same step.
  step,
}
