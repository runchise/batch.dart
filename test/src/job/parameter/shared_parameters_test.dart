// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/job/parameter/shared_parameters.dart';

void main() {
  test('Test SharedParameters', () {
    expect(SharedParameters.instance, SharedParameters.instance);
  });
}
