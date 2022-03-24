// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Project imports:
import 'package:batch/src/job/context/execution_context.dart';
import 'package:batch/src/job/entity/task.dart';

/// This is a convenience class that only notifies about application shutdown.
class ShutdownTask extends Task<ShutdownTask> {
  @override
  void execute(ExecutionContext context) => super.shutdown();
}
