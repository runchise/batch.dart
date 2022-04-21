// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Package imports:
import 'package:args/args.dart';

// Project imports:
import 'package:batch/src/banner/banner_printer.dart';
import 'package:batch/src/banner/default_banner.dart';
import 'package:batch/src/batch_instance.dart';
import 'package:batch/src/batch_status.dart';
import 'package:batch/src/diagnostics/boot_diagnostics.dart';
import 'package:batch/src/job/builder/scheduled_job_builder.dart';
import 'package:batch/src/job/event/job.dart';
import 'package:batch/src/job/parameter/shared_parameters.dart';
import 'package:batch/src/job/schedule/job_scheduler.dart';
import 'package:batch/src/log/log_configuration.dart';
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/log/logger_provider.dart';
import 'package:batch/src/runner.dart';
import 'package:batch/src/version/update_notification.dart';
import 'package:batch/src/version/version.dart';

/// This is a batch application that manages the execution of arbitrarily defined jobs
/// with own lifecycle.
///
/// In order to run this batch application, you first need to create at least
/// one [Job] object. After creating the Job object, use the [addJob] method to register
/// the Job to the batch application.
///
/// [Job] represents the maximum unit of a certain processing system
/// that consists of multiple steps. In addition, a Step consists of multiple Tasks. Step
/// is an intermediate concept between Job and Task, and Task is the specific
/// minimum unit of processing in a particular processing system.
///
/// You can use [addSharedParameter] to add a value that will be shared by the
/// entire this batch application. This value can be added by tying it to string key and
/// can be used in the Task class throughout the execution context.
///
/// Also you can get more information about implementation on
/// [example page](https://github.com/batch-dart/batch.dart/blob/main/example/example.dart).
///
/// These job configuration can be assembled in any way you like. For example,
/// you can configure it as follows.
///
/// ```
/// BatchApplication
/// │
/// │              ┌ Task1
/// │      ┌ Step1 ├ Task2
/// │      │       └ Task3
/// │      │
/// │      │       ┌ Task1
/// ├ Job1 ├ Step2 ├ Task2
/// │      │       └ Task3
/// │      │
/// │      │       ┌ Task1
/// │      └ Step3 ├ Task2
/// │              └ Task3
/// │
/// │              ┌ Task1
/// │      ┌ Step1 ├ Task2
/// │      │       └ ┄
/// │      │
/// │      │       ┌ Task1
/// └ Job2 ├ Step2 ├ ┄
///        │       └ ┄
///        │
///        │
///        └ ┄
/// ```
abstract class BatchApplication implements Runner {
  /// Returns the new instance of [BatchApplication].
  factory BatchApplication({
    List<String> args = const [],
    FutureOr<void> Function(ArgParser parser)? argsConfigBuilder,
    FutureOr<Map<String, dynamic>> Function(ArgResults args)? onLoadArgs,
    required List<ScheduledJobBuilder> jobs,
    LogConfiguration? logConfig,
  }) =>
      _BatchApplication(
        args: args,
        argsConfigBuilder: argsConfigBuilder,
        onLoadArgs: onLoadArgs,
        jobs: jobs,
        logConfig: logConfig,
      );

  /// Adds parameter as global scope.
  void addSharedParameter({required String key, required dynamic value});
}

class _BatchApplication implements BatchApplication {
  /// Returns the new instance of [_BatchApplication].
  _BatchApplication({
    List<String> args = const [],
    FutureOr<void> Function(ArgParser parser)? argsConfigBuilder,
    FutureOr<Map<String, dynamic>> Function(ArgResults args)? onLoadArgs,
    required List<ScheduledJobBuilder> jobs,
    LogConfiguration? logConfig,
  })  : _args = args,
        _argsConfigBuilder = argsConfigBuilder,
        _onLoadArgs = onLoadArgs,
        _scheduledJobBuilders = jobs,
        _logConfig = logConfig;

  /// The args
  final List<String> _args;

  /// The builder for argument configuration.
  final FutureOr<void> Function(ArgParser parser)? _argsConfigBuilder;

  /// The callback to be called when the commend line arguments are loaded.
  final FutureOr<Map<String, dynamic>> Function(ArgResults args)? _onLoadArgs;

  /// The configuration for logging
  final LogConfiguration? _logConfig;

  /// The job builders
  final List<ScheduledJobBuilder> _scheduledJobBuilders;

  @override
  void addSharedParameter({
    required String key,
    required dynamic value,
  }) =>
      SharedParameters.instance[key] = value;

  @override
  void run() async {
    if (!BatchInstance.isPending) {
      throw StateError('The batch application is already running.');
    }

    if (_args.isNotEmpty && _argsConfigBuilder == null) {
      throw StateError('''\n
        The command line arguments are specified, but the builder for argument configuration is not specified.
        Please specify the builder for argument configuration by using "argsConfigBuilder".
      ''');
    }

    BatchInstance.updateStatus(BatchStatus.starting);

    try {
      //! The logging functionality provided by the batch library
      //! will be available when this loading process is complete.
      Logger.loadFromConfig(_logConfig ?? LogConfiguration());

      await BannerPrinter(DefaultBanner()).execute();
      await UpdateNotification().printIfNecessary(await Version().status);

      log.info('🚀🚀🚀🚀🚀🚀🚀 The batch process has started! 🚀🚀🚀🚀🚀🚀🚀');
      log.info('Logger instance has completed loading');

      await _loadSharedParameters();

      JobScheduler(BootDiagnostics(_scheduledJobBuilders).execute()).run();
    } catch (e, s) {
      Logger.instance.dispose();
      print(s);
      throw Exception(e);
    }
  }

  Future<void> _loadSharedParameters() async {
    if (_args.isNotEmpty) {
      final parsedArgs = await _buildArgParser();

      if (_onLoadArgs != null) {
        final parameters = await _onLoadArgs!.call(parsedArgs);
        for (final key in parameters.keys) {
          addSharedParameter(key: key, value: parameters[key]);
        }
      } else {
        log.info('Add all command line arguments as SharedParameters');

        for (final option in parsedArgs.options) {
          addSharedParameter(key: option, value: parsedArgs[option]);
        }
      }
    }
  }

  Future<ArgResults> _buildArgParser() async {
    final argParser = ArgParser();
    await _argsConfigBuilder?.call(argParser);
    return argParser.parse(_args);
  }
}
