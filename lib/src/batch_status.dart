// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The enum represents batch status.
enum BatchStatus {
  /// Pending
  pending,

  /// Running
  running,

  /// Shutting down
  shuttingDown,

  /// Shutdown
  shutdown,
}
