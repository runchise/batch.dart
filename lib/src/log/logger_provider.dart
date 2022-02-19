// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/log/logger_instance.dart';

/// Logging function for trace level.
final trace = LoggerInstance.instance!.trace;

/// Logging function for debug level.
final debug = LoggerInstance.instance!.debug;

/// Logging function for info level.
final info = LoggerInstance.instance!.info;

/// Logging function for warning level.
final warning = LoggerInstance.instance!.warning;

/// Logging function for error level.
final error = LoggerInstance.instance!.error;

/// Logging function for fatal level.
final fatal = LoggerInstance.instance!.fatal;
