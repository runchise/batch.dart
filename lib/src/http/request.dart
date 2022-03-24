// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Package imports:
import 'package:meta/meta.dart';

abstract class Request<R> {
  /// Returns the base url.
  @visibleForTesting
  String get baseUrl;

  Future<R> send();
}
