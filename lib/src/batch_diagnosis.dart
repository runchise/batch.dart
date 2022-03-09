// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/entity/step.dart';
import 'package:batch/src/job/exception/unique_constraint_exception.dart';
import 'package:batch/src/job/name/name_relation.dart';
import 'package:batch/src/job/name/name_relations.dart';
import 'package:batch/src/log/logger_provider.dart';
import 'package:batch/src/runner.dart';

abstract class BatchDiagnosis implements Runner {
  /// Returns the new instance of [BatchDiagnosis].
  factory BatchDiagnosis({required List<Job> jobs}) =>
      _BatchDiagnosis(jobs: jobs);
}

class _BatchDiagnosis implements BatchDiagnosis {
  /// Returns the new instance of [_BatchDiagnosis].
  _BatchDiagnosis({required List<Job> jobs}) : _jobs = jobs;

  /// The jobs
  final List<Job> _jobs;

  /// The name relations
  final _nameRelations = NameRelations();

  @override
  void run() {
    info('Batch application diagnostics have been started');

    if (_jobs.isEmpty) {
      throw ArgumentError();
    }

    for (final job in _jobs) {
      _checkJobRecursively(job: job);
    }

    info('Batch application diagnostics have been completed');
    info('Batch applications can be started securely');
  }

  void _checkJobRecursively({required Job job}) {
    if (job.steps.isEmpty) {
      throw ArgumentError('The step to be launched is required.');
    }

    for (final step in job.steps) {
      _checkStepRecursively(job: job, step: step);
    }

    if (job.hasBranch) {
      for (final branch in job.branches) {
        _checkJobRecursively(job: branch.to);
      }
    }
  }

  void _checkStepRecursively({required Job job, required Step step}) {
    if (step.tasks.isEmpty) {
      throw ArgumentError('The task to be launched is required.');
    }

    final relation = NameRelation(
      job: job.name,
      step: step.name,
    );

    if (_nameRelations.has(relation)) {
      throw UniqueConstraintException(
          'The name relations between Job and Step must be unique: [duplicatedRelation=$relation]');
    }

    _nameRelations.add(relation);

    if (step.hasBranch) {
      for (final branch in step.branches) {
        _checkStepRecursively(job: job, step: branch.to);
      }
    }
  }
}
