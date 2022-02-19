// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/log/logger.dart';

/// This is a simple class for managing instances of the [Logger].
///
/// This class does not work by itself, but was created to use the functionality
/// of the [Logger] class via the logging methods defined in `logger_provider.dart`.
///
/// By using this structure, users of the `batch` library do not need to instantiate
/// a [Logger] every time they use it. Also users do not need to be aware of
/// [Logger] initialization other than to configure it, and can safely use the logging feature
/// anywhere in the classes in the lifecycle of the `batch` library.
class LoggerInstance {
  /// The instance of [Logger].
  static Logger? instance;
}
