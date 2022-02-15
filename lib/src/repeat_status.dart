// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// The enum that represents repeat status.
///
/// This [RepeatStatus] is used to define the continuity of the processing
/// of the tasks that make up the step. Use [finished] to finish processing a Task,
/// and use [continuable] to continue processing the same Task once it has been completed.
enum RepeatStatus {
  /// Continuable
  continuable,

  /// Finished
  finished,
}

/// The feature extension for [RepeatStatus].
extension RepeatStatusFeature on RepeatStatus {
  /// Returns if this enum element is [RepeatStatus.continuable], otherwise false.
  bool get isContinuable => this == RepeatStatus.continuable;
}
