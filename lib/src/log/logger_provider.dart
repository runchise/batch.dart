// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/log/logger.dart';

/// Logging function for trace level.
final trace = Logger.instance.trace;

/// Logging function for debug level.
final debug = Logger.instance.debug;

/// Logging function for info level.
final info = Logger.instance.info;

/// Logging function for warning level.
final warn = Logger.instance.warn;

/// Logging function for error level.
final error = Logger.instance.error;

/// Logging function for fatal level.
final fatal = Logger.instance.fatal;
