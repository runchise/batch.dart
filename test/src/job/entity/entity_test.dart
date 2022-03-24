// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/job/branch/branch_status.dart';
import 'package:batch/src/job/config/retry_configuration.dart';
import 'package:batch/src/job/config/skip_configuration.dart';
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/entity.dart';

void main() {
  test('Test Entity with required parameter', () async {
    final entity = _Entity(name: 'entityName');
    expect(entity.name, 'entityName');
    expect(entity.precondition, null);
    expect(entity.onStarted, null);
    expect(entity.onSucceeded, null);
    expect(entity.onError, null);
    expect(entity.onCompleted, null);
    expect(entity.skipPolicy, null);
    expect(entity.retryPolicy, null);
    expect(entity.hasSkipPolicy, false);
    expect(entity.hasRetryPolicy, false);
    expect(await entity.shouldLaunch(), true);
    expect(entity.hasBranch, false);
  });

  test('Test Entity with precondition', () async {
    final entity = _Entity(name: 'name', precondition: () => false);
    expect(entity.name, 'name');
    expect(await entity.shouldLaunch(), false);
  });

  test('Test Entity with callbacks', () {
    final entity = _Entity(
      name: 'name',
      onStarted: (context) => true,
      onSucceeded: (context) => true,
      onError: (context, error, stackTrace) => true,
      onCompleted: (context) => true,
    );

    expect(entity.name, 'name');
    expect(entity.onStarted != null, true);
    expect(entity.onSucceeded != null, true);
    expect(entity.onError != null, true);
    expect(entity.onCompleted != null, true);
  });

  test('Test Entity with policies', () {
    final entity = _Entity(
      name: 'name',
      skipConfig: SkipConfiguration(skippableExceptions: []),
      retryConfig: RetryConfiguration(retryableExceptions: []),
    );

    expect(entity.name, 'name');
    expect(entity.skipPolicy != null, true);
    expect(entity.retryPolicy != null, true);
  });

  test('Test Entity with branches', () {
    final entity = _Entity(name: 'name');
    expect(entity.name, 'name');
    expect(entity.hasBranch, false);

    entity.branchOnSucceeded(to: _Entity(name: 'succeeded'));
    entity.branchOnCompleted(to: _Entity(name: 'completed'));
    entity.branchOnFailed(to: _Entity(name: 'failed'));

    expect(entity.hasBranch, true);
    expect(entity.branches.length, 3);
    expect(entity.branches[0].on, BranchStatus.succeeded);
    expect(entity.branches[0].to.name, 'succeeded');
    expect(entity.branches[1].on, BranchStatus.completed);
    expect(entity.branches[1].to.name, 'completed');
    expect(entity.branches[2].on, BranchStatus.failed);
    expect(entity.branches[2].to.name, 'failed');
  });
}

class _Entity extends Entity<_Entity> {
  _Entity({
    required String name,
    FutureOr<bool> Function()? precondition,
    Function(ExecutionContext context)? onStarted,
    Function(ExecutionContext context)? onSucceeded,
    Function(ExecutionContext context, dynamic error, StackTrace stackTrace)?
        onError,
    Function(ExecutionContext context)? onCompleted,
    SkipConfiguration? skipConfig,
    RetryConfiguration? retryConfig,
  }) : super(
          name: name,
          precondition: precondition,
          onStarted: onStarted,
          onError: onError,
          onSucceeded: onSucceeded,
          onCompleted: onCompleted,
          skipConfig: skipConfig,
          retryConfig: retryConfig,
        );
}
