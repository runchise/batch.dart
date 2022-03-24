// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Dart imports:
import 'dart:async';

abstract class Banner {
  /// Returns the built banner.
  FutureOr<String> build();
}
