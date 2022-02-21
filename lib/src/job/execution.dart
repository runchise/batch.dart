// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/const/process_status.dart';
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

  @override
  String toString() =>
      'Execution(name: $name, status: $status, finishedAt: $finishedAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Execution<T> &&
        other.name == name &&
        other.status == status &&
        other.finishedAt == finishedAt;
  }

  @override
  int get hashCode => name.hashCode ^ status.hashCode ^ finishedAt.hashCode;
}
