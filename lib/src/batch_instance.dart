// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/batch_status.dart';

/// The class represents the unique instance of this batch application.
class BatchInstance {
  /// The internal constructor.
  BatchInstance._internal();

  /// Returns the singleton instance of [BatchInstance].
  static BatchInstance get instance => _singletonInstance;

  /// The singleton instance of this [BatchInstance].
  static final _singletonInstance = BatchInstance._internal();

  /// The batch status
  BatchStatus _status = BatchStatus.pending;

  /// Updates batch status to [status].
  void updateStatus(final BatchStatus status) => _status = status;

  /// Returns true if this batch application is running, otherwise false.
  bool get isRunning => _status == BatchStatus.running;

  /// Returns true if this batch application is shutting down, otherwise false.
  bool get isShuttingDown => _status == BatchStatus.shuttingDown;
}
