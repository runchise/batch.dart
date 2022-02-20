// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/context/process_status.dart';

abstract class Execution {
  /// Returns the new instance of [Execution].
  Execution({
    required this.name,
    required this.parentName,
  }) : assert(name.isNotEmpty);

  /// The name
  final String name;

  /// The parent name
  final String parentName;

  /// The process status
  ProcessStatus get status;

  /// The started date time
  DateTime get startedAt;

  /// The updated date time
  DateTime get updatedAt;

  /// The finished date time
  DateTime? get finishedAt;

  @override
  String toString() => 'Execution(name: $name, parentName: $parentName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Execution &&
        other.name == name &&
        other.parentName == parentName;
  }

  @override
  int get hashCode => name.hashCode ^ parentName.hashCode;
}
