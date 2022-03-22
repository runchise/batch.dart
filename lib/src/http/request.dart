// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:meta/meta.dart';

abstract class Request<R> {
  /// Returns the base url.
  @visibleForTesting
  String get baseUrl;

  Future<R> send();
}
