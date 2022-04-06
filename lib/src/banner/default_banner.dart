// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Dart imports:
import 'dart:async';

// Project imports:
import 'package:batch/src/banner/banner.dart';
import 'package:batch/src/version/version.dart';

class DefaultBanner implements Banner {
  /// The brand logo
  static const _logo = '''
╔═════════════════════════════════════════════════════════════════════════╗
║                                                                         ║
║  ╭━━╮╱╱╱╭╮╱╱╱╭╮╱╱╱╱╭╮╱╱╱╱╭╮                                             ║
║  ┃╭╮┃╱╱╭╯╰╮╱╱┃┃╱╱╱╱┃┃╱╱╱╭╯╰╮                                            ║
║  ┃╰╯╰┳━┻╮╭╋━━┫╰━╮╭━╯┣━━┳┻╮╭╯                                            ║
║  ┃╭━╮┃╭╮┃┃┃╭━┫╭╮┃┃╭╮┃╭╮┃╭┫┃                                             ║
║  ┃╰━╯┃╭╮┃╰┫╰━┫┃┃┣┫╰╯┃╭╮┃┃┃╰╮                                            ║
║  ╰━━━┻╯╰┻━┻━━┻╯╰┻┻━━┻╯╰┻╯╰━╯                                            ║
║  ╱╱╭╮╱╱╭╮╱╱╭━━━╮╱╱╭╮╱╱╱╱╱╱╭╮╱╱╭╮╱╱╱╱╱╱╱╱╭━━━╮╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭╮     ║
║  ╱╱┃┃╱╱┃┃╱╱┃╭━╮┃╱╱┃┃╱╱╱╱╱╱┃┃╱╱┃┃╱╱╱╱╱╱╱╱┃╭━━╯╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱┃┃     ║
║  ╱╱┃┣━━┫╰━╮┃╰━━┳━━┫╰━┳━━┳━╯┣╮╭┫┃╭┳━╮╭━━╮┃╰━━┳━┳━━┳╮╭┳━━┳╮╭╮╭┳━━┳━┫┃╭╮   ║
║  ╭╮┃┃╭╮┃╭╮┃╰━━╮┃╭━┫╭╮┃┃━┫╭╮┃┃┃┃┃┣┫╭╮┫╭╮┃┃╭━━┫╭┫╭╮┃╰╯┃┃━┫╰╯╰╯┃╭╮┃╭┫╰╯╯   ║
║  ┃╰╯┃╰╯┃╰╯┃┃╰━╯┃╰━┫┃┃┃┃━┫╰╯┃╰╯┃╰┫┃┃┃┃╰╯┃┃┃╱╱┃┃┃╭╮┃┃┃┃┃━╋╮╭╮╭┫╰╯┃┃┃╭╮╮   ║
║  ╰━━┻━━┻━━╯╰━━━┻━━┻╯╰┻━━┻━━┻━━┻━┻┻╯╰┻━╮┃╰╯╱╱╰╯╰╯╰┻┻┻┻━━╯╰╯╰╯╰━━┻╯╰╯╰╯   ║
║  ╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭━╯┃                                ║
║  ╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╰━━╯                                ║
║                                                                         ║
╠═════════════════════════════════════════════════════════════════════════╣
║  Version  : ${Version.current}                                                       ║
║  License  : BSD 3-Clause                                                ║
║  Author   : Kato Shinya (https://github.com/myConsciousness)            ║
╚═════════════════════════════════════════════════════════════════════════╝
''';

  @override
  FutureOr<String> build() => _logo;
}
