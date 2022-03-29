// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:async_task/async_task.dart';

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/event/task.dart';

abstract class ParallelTask<T extends Task<T>> extends Task<T>
    with AsyncTask<void, void> {
  @override
  AsyncTask<void, void> instantiate(void parameters,
      [Map<String, SharedData>? sharedData]) {
    return this;
  }

  @override
  void parameters() {}

  @override
  FutureOr<void> run() async {
    try {
      await invoke(ExecutionContext());
    } catch (e) {
      rethrow;
    }
  }
}
