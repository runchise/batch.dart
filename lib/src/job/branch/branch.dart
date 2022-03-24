// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:batch/src/job/event/event.dart';

class Branch<T extends Event<T>> {
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
