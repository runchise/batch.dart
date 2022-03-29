// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:async_task/async_task.dart';

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/task/parallel_task.dart';

class ParallelExecutor extends AsyncTask<String, void> {
  /// Returns the new instance of [ParallelExecutor].
  ParallelExecutor({required this.parallelTask});

  /// The parallel task
  final ParallelTask parallelTask;

  @override
  AsyncTask<String, void> instantiate(String parameters,
      [Map<String, SharedData>? sharedData]) {
    return this;
  }

  @override
  String parameters() {
    return '';
  }

  @override
  FutureOr<void> run() async {
    try {
      await parallelTask.execute(ExecutionContext());
    } catch (e) {
      rethrow;
    }
  }
}
