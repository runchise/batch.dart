// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:async_task/async_task.dart';

// Project imports:
import 'package:batch/batch.dart';
import 'package:batch/src/job/launcher/launcher.dart';

class ParallelLauncher extends Launcher<Parallel> {
  /// Returns the new instance of [ParallelLauncher].
  ParallelLauncher({
    required ExecutionContext context,
    required Parallel parallel,
  })  : _parallel = parallel,
        super(context: context);

  /// The parallel
  final Parallel _parallel;

  @override
  Future<void> run() async => await super.executeRecursively(
        event: _parallel,
        execute: (parallel) async {
          final asyncExecutor = AsyncExecutor(
            parallelism: parallel.executors.length,
            taskTypeRegister: () => parallel.executors,
            logger: (String type, dynamic message,
                    [dynamic error, dynamic stackTrace]) =>
                info(message),
          );

          asyncExecutor.logger.enabled = true;

          try {
            final executions = asyncExecutor.executeAll(parallel.executors);
            await Future.wait(executions);

            for (final executor in parallel.executors) {
              for (final isolatedMessage in executor.result!) {
                isolatedMessage.output();
              }
            }
          } finally {
            await asyncExecutor.close();
          }
        },
      );
}
