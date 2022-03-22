// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/batch.dart';
import 'package:batch/src/banner/banner.dart';
import 'package:batch/src/banner/banner_printer.dart';
import 'package:batch/src/log/logger.dart';

void main() {
  test('Test BannerPrinter', () {
    Logger.loadFrom(config: LogConfiguration());
    expect(() async => await BannerPrinter(banner: _TestBanner()).execute(),
        returnsNormally);
  });
}

class _TestBanner implements Banner {
  @override
  String build() => 'Test Banner';
}
