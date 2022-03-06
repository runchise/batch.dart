// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The enum represents status of batch processing.
enum ProcessStatus {
  /// This element indicates that the processing is already started.
  started,

  /// This element indicates that the processing is skipped for some reason.
  skipped,

  /// This element indicates that the processing is completed.
  completed,

  /// This element indicates that the processing is failed.
  failed,
}
