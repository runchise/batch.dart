// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

// Project imports:
import 'package:batch/src/log/output/log_output.dart';
import 'package:batch/src/log/output_log_event.dart';

class MultiLogOutput extends LogOutput {
  /// Returns the new instance of [MultiLogOutput].
  MultiLogOutput(this.outputs);

  /// The log outputs
  final List<LogOutput> outputs;

  @override
  void init() {
    for (final output in outputs) {
      output.init();
    }
  }

  @override
  void output(final OutputLogEvent event) {
    for (final output in outputs) {
      output.logColor ??= super.logColor;
      output.output(event);
    }
  }

  @override
  void dispose() async {
    for (final output in outputs) {
      output.dispose();
    }
  }
}
