// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

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
