// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

abstract class Banner {
  /// Returns the built banner.
  FutureOr<String> build();
}
