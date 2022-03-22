// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Dart imports:
import 'dart:async';

abstract class Banner {
  /// Returns the built banner.
  FutureOr<String> build();
}
