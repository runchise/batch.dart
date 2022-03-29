// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/event/task.dart';

abstract class ParallelTask<T extends Task<T>> extends Task<T> {
  @override
  FutureOr<void> execute(ExecutionContext context) async {
    try {
      await invoke();
    } catch (e) {
      rethrow;
    }
  }

  /// Invokes piece of parallel processing.
  FutureOr<void> invoke();
}
