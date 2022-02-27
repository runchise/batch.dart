// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/job.dart';
import 'package:batch/src/job/launcher/launcher.dart';

/// This class provides the feature to securely execute registered jobs.
class JobLauncher extends Launcher<Job> {
  /// Returns the new instance of [JobLauncher].
  JobLauncher({
    required Job job,
  })  : _job = job,
        super(context: ExecutionContext());

  /// The job
  final Job _job;

  @override
  Future<void> run() async => await super.executeRecursively(entity: _job);
}
