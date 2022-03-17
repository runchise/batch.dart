// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Project imports:
import 'package:batch/src/builder.dart';
import 'package:batch/src/version/version.dart';

abstract class Banner implements Builder<String> {
  /// Returns the new instance of [Banner].
  factory Banner() => _Banner();

  /// Returns the line.
  String get line;

  /// Returns the logo.
  String get logo;

  /// Returns the description of library.
  String get description;

  /// Returns the credit.
  String get credit;
}

class _Banner implements Banner {
  @override
  String build() {
    return '$line\n$logo\n$line\n${description.padLeft(description.length + 36)}\n$line\n\n$credit\n\n$line\n';
  }

  @override
  String get line =>
      '-------------------------------------------------------------------------------------------------------------------------------------------';

  @override
  final String logo = '''
          _____                    _____                _____                    _____                    _____
         /\\    \\                  /\\    \\              /\\    \\                  /\\    \\                  /\\    \\
        /::\\    \\                /::\\    \\            /::\\    \\                /::\\    \\                /::\\____\\
       /::::\\    \\              /::::\\    \\           \\:::\\    \\              /::::\\    \\              /:::/    /
      /::::::\\    \\            /::::::\\    \\           \\:::\\    \\            /::::::\\    \\            /:::/    /
     /:::/\\:::\\    \\          /:::/\\:::\\    \\           \\:::\\    \\          /:::/\\:::\\    \\          /:::/    /
    /:::/__\\:::\\    \\        /:::/__\\:::\\    \\           \\:::\\    \\        /:::/  \\:::\\    \\        /:::/____/
   /::::\\   \\:::\\    \\      /::::\\   \\:::\\    \\          /::::\\    \\      /:::/    \\:::\\    \\      /::::\\    \\
  /::::::\\   \\:::\\    \\    /::::::\\   \\:::\\    \\        /::::::\\    \\    /:::/    / \\:::\\    \\    /::::::\\    \\   _____
 /:::/\\:::\\   \\:::\\ ___\\  /:::/\\:::\\   \\:::\\    \\      /:::/\\:::\\    \\  /:::/    /   \\:::\\    \\  /:::/\\:::\\    \\ /\\    \\
/:::/__\\:::\\   \\:::|    |/:::/  \\:::\\   \\:::\\____\\    /:::/  \\:::\\____\\/:::/____/     \\:::\\____\\/:::/  \\:::\\    /::\\____\\
\\:::\\   \\:::\\  /:::|____|\\::/    \\:::\\  /:::/    /   /:::/    \\::/    /\\:::\\    \\      \\::/    /\\::/    \\:::\\  /:::/    /
 \\:::\\   \\:::\\/:::/    /  \\/____/ \\:::\\/:::/    /   /:::/    / \\/____/  \\:::\\    \\      \\/____/  \\/____/ \\:::\\/:::/    /
  \\:::\\   \\::::::/    /            \\::::::/    /   /:::/    /            \\:::\\    \\                       \\::::::/    /
   \\:::\\   \\::::/    /              \\::::/    /   /:::/    /              \\:::\\    \\                       \\::::/    /
    \\:::\\  /:::/    /               /:::/    /    \\::/    /                \\:::\\    \\                      /:::/    /
     \\:::\\/:::/    /               /:::/    /      \\/____/                  \\:::\\    \\                    /:::/    /
      \\::::::/    /               /:::/    /                                 \\:::\\    \\                  /:::/    /
       \\::::/    /               /:::/    /                                   \\:::\\____\\                /:::/    /
        \\::/____/                \\::/    /                                     \\::/    /                \\::/    /
         ~~                       \\/____/                                       \\/____/                  \\/____/
''';

  @override
  String get description =>
      'A lightweight and powerful Job Scheduling Framework.';

  @override
  String get credit => '''  Version: ${Version().current}
  License: BSD 3-Clause
  Author : Kato Shinya (https://github.com/myConsciousness)''';
}
