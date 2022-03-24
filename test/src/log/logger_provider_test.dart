// Copyright (c) 2022, Kato Shinya
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided the conditions.
//
// See more details at https://github.com/batch-dart/batch.dart/blob/main/LICENSE

// Package imports:
import 'package:test/test.dart';

// Project imports:
import 'package:batch/src/log/log_configuration.dart';
import 'package:batch/src/log/logger.dart';
import 'package:batch/src/log/logger_provider.dart';

void main() {
  test('Test LoggerProvider before load logger', () {
    expect(() => trace, throwsA(isA<NoSuchMethodError>()));
    expect(() => debug, throwsA(isA<NoSuchMethodError>()));
    expect(() => info, throwsA(isA<NoSuchMethodError>()));
    expect(() => warn, throwsA(isA<NoSuchMethodError>()));
    expect(() => error, throwsA(isA<NoSuchMethodError>()));
    expect(() => fatal, throwsA(isA<NoSuchMethodError>()));
  });

  test('Test LoggerProvider after load logger', () {
    final logger = Logger.loadFrom(config: LogConfiguration());
    expect(trace != null, true);
    expect(debug != null, true);
    expect(info != null, true);
    expect(warn != null, true);
    expect(error != null, true);
    expect(fatal != null, true);

    expect(trace == logger.trace, true);
    expect(debug == logger.debug, true);
    expect(info == logger.info, true);
    expect(warn == logger.warn, true);
    expect(error == logger.error, true);
    expect(fatal == logger.fatal, true);
  });
}
