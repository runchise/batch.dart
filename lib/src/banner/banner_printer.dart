// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/banner/banner.dart';
import 'package:batch/src/log/logger_provider.dart';
import 'package:batch/src/version/version.dart';

abstract class BannerPrinter {
  /// Returns the new instance of [BannerPrinter].
  factory BannerPrinter({required Banner banner}) =>
      _BannerPrinter(banner: banner);

  Future<void> execute();
}

class _BannerPrinter implements BannerPrinter {
  /// Returns the new instance of [_BannerPrinter].
  _BannerPrinter({required this.banner});

  /// The update notification
  static const _updateNotification = '''
  ╔════════════════════════════════════════════════════════════════════════════╗
  ║ A new version of batch is available!                                       ║
  ║                                                                            ║
  ║ See the latest release at https://pub.dev/packages/batch                   ║
  ║ Or to update to the latest version, run "dart pub upgrade"                 ║
  ╚════════════════════════════════════════════════════════════════════════════╝
''';

  /// The banner
  final Banner banner;

  /// The version
  final Version version = Version();

  @override
  Future<void> execute() async {
    _printBanner();
    await _printUpdateNotification();
  }

  void _printBanner() => info(
      '\n${banner.line}\n${banner.logo}\n${banner.line}\n${banner.description.padLeft(banner.description.length + 36)}\n${banner.line}\n\n${banner.credit}\n\n${banner.line}\n');

  Future<void> _printUpdateNotification() async {
    final status = await version.status;

    if (status.isLatest) {
      return;
    }

    warn('\n\n$_updateNotification');
  }
}
