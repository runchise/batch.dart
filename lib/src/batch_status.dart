// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

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
