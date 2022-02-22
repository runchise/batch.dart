// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// This abstract class provides the process of determining the preconditions
/// for executing the Job and Step layers of processing.
abstract class Precondition {
  /// Returns true if this precondition is met, otherwise false.
  bool check();
}
