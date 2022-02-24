// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/process_status.dart';
import 'package:batch/src/job/entity/entity.dart';

class Execution<T extends Entity<T>> {
  /// Returns the new instance of [Execution].
  Execution({
    required this.name,
    this.status = ProcessStatus.started,
    required this.startedAt,
    this.finishedAt,
  }) : assert(name.isNotEmpty);

  /// The name
  final String name;

  /// The process status
  final ProcessStatus status;

  /// The started date time
  final DateTime startedAt;

  /// The finished date time
  final DateTime? finishedAt;
}
