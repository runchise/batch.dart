// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

abstract class SkippableExceptions {
  /// Returns the new instance of [SkippableExceptions].
  factory SkippableExceptions({required List<String> objects}) =>
      _SkippableExceptions(objects: objects);

  /// Returns true if this object has [exception], otherwise false.
  bool has(final Exception exception);
}

class _SkippableExceptions implements SkippableExceptions {
  _SkippableExceptions({required this.objects});

  // The included exceptions
  final List<String> objects;

  @override
  bool has(final Exception exception) =>
      objects.contains(exception.runtimeType.toString());
}
