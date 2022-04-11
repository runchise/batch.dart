// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/log/logger_instance.dart';

/// The logger
final Logger log = LoggerInstance.instance;

/// Logging function for trace level.
final trace = LoggerInstance.instance.trace;

/// Logging function for debug level.
final debug = LoggerInstance.instance.debug;

/// Logging function for info level.
final info = LoggerInstance.instance.info;

/// Logging function for warning level.
final warn = LoggerInstance.instance.warn;

/// Logging function for error level.
final error = LoggerInstance.instance.error;

/// Logging function for fatal level.
final fatal = LoggerInstance.instance.fatal;
