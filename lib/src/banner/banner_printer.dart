// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/banner/banner.dart';
import 'package:batch/src/log/logger_provider.dart';

abstract class BannerPrinter {
  /// Returns the new instance of [BannerPrinter].
  factory BannerPrinter({required Banner banner}) =>
      _BannerPrinter(banner: banner);

  /// Prints the banner.
  Future<void> execute();
}

class _BannerPrinter implements BannerPrinter {
  /// Returns the new instance of [_BannerPrinter].
  _BannerPrinter({required this.banner});

  /// The banner
  final Banner banner;

  @override
  Future<void> execute() async => info('\n${await banner.build()}');
}
