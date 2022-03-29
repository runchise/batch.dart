// Copyright 2022 Kato Shinya. All rights reserved.
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided the conditions.

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

    expect(trace, isNotNull);
    expect(debug, isNotNull);
    expect(info, isNotNull);
    expect(warn, isNotNull);
    expect(error, isNotNull);
    expect(fatal, isNotNull);

    expect(log.trace, isNotNull);
    expect(log.debug, isNotNull);
    expect(log.info, isNotNull);
    expect(log.warn, isNotNull);
    expect(log.error, isNotNull);
    expect(log.fatal, isNotNull);

    expect(log == logger, isTrue);
    expect(trace == logger.trace, isTrue);
    expect(debug == logger.debug, isTrue);
    expect(info == logger.info, isTrue);
    expect(warn == logger.warn, isTrue);
    expect(error == logger.error, isTrue);
    expect(fatal == logger.fatal, isTrue);
  });
}
