// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/job/parameter/parameters.dart';

class SharedParameters extends Parameters {
  /// The internal constructor.
  SharedParameters._internal();

  /// Returns the singleton instance of [SharedParameters].
  static SharedParameters get instance => _singletonInstance;

  /// The singleton instance of this [SharedParameters].
  static final _singletonInstance = SharedParameters._internal();
}
