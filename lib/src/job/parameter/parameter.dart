// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

class Parameter {
  /// Returns the new instance of [Parameter].
  Parameter({
    required this.key,
    required this.value,
  });

  /// The key
  final String key;

  /// The value
  final dynamic value;

  @override
  String toString() => '$key=$value';
}
