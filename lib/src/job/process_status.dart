// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The enum represents status of batch processing.
enum ProcessStatus {
  /// This element indicates that the processing of the job or step is already started.
  started,

  /// This element indicates that the processing of the job or step is completed.
  completed,

  /// This element indicates that the processing of the job or step is failed.
  failed,
}
