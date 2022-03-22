// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/banner/banner.dart';

void main() {
  test('Test Banner', () {
    expect(_Banner().build(), 'success');
  });
}

class _Banner implements Banner {
  @override
  String build() {
    return 'success';
  }
}
