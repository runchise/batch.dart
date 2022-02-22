// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/job/const/branch_status.dart';
import 'package:batch/src/job/entity/entity.dart';

class Branch<T extends Entity<T>> {
  /// Returns the new instance of [Branch].
  Branch({
    required this.on,
    required this.to,
  });

  /// The status as a basis for this branching
  final BranchStatus on;

  /// The next point for this branching
  final T to;
}
