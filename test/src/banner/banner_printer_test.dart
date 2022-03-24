// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

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
