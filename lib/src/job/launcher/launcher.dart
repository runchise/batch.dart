// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/context/context_helper.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/entity.dart';

abstract class Launcher<T extends Entity<T>> extends ContextHelper<T> {
  /// Returns the new instance of [Launcher].
  Launcher({
    required ExecutionContext context,
  }) : super(context: context);

  void execute();
}
