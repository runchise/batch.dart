// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Dart imports:
import 'dart:convert';
import 'dart:io';

// Project imports:
import 'package:batch/src/log/output/log_output.dart';
import 'package:batch/src/log/output_log_event.dart';

class FileLogOutput extends LogOutput {
  /// Returns the new instance of [FileLogOutput].
  FileLogOutput({
    required this.file,
    this.overwrite = false,
    this.encoding = utf8,
  });

  /// The file
  final File file;

  /// The flag whether or not to overwrite existing file
  final bool overwrite;

  /// The encoding
  final Encoding encoding;

  /// The IO sink
  IOSink? _sink;

  @override
  void init() {
    _sink = file.openWrite(
      mode: overwrite ? FileMode.writeOnly : FileMode.writeOnlyAppend,
      encoding: encoding,
    );
  }

  @override
  void output(final OutputLogEvent event) {
    _sink?.writeAll(event.lines, '\n');
    _sink?.writeln();
  }

  @override
  void dispose() async {
    await _sink?.flush();
    await _sink?.close();
  }
}
