// Copyright (c) 2022, Kato Shinya. All rights reserved.
// Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:batch/src/parameter/job_relationship.dart';
import 'package:batch/src/parameter/parameter.dart';
import 'package:batch/src/parameter/parameter_scope.dart';

class SharedParameters {
  /// The internal constructor.
  SharedParameters._internal();

  /// Returns the singleton instance of [SharedParameters].
  static SharedParameters get instance => _singletonInstance;

  /// The singleton instance of this [SharedParameters].
  static final _singletonInstance = SharedParameters._internal();

  /// The shared parameters
  final _parameters = <String, Parameter>{};

  void putAsGlobalScope<T>({
    required String key,
    required T value,
  }) =>
      _put(
        scope: ParameterScope.global,
        key: key,
        value: value,
        relationship: JobRelationship(),
      );

  void putAsJobScope<T>({
    required String key,
    required T value,
    required JobRelationship relationship,
  }) =>
      _put(
        scope: ParameterScope.job,
        key: key,
        value: value,
        relationship: relationship,
      );

  void putAsStepScope<T>({
    required String key,
    required T value,
    required JobRelationship relationship,
  }) =>
      _put(
        scope: ParameterScope.step,
        key: key,
        value: value,
        relationship: relationship,
      );

  T? getInGlobalScope<T>({
    required String key,
  }) =>
      _get(scope: ParameterScope.global, key: key);

  T? getInJobScope<T>({
    required String key,
  }) =>
      _get(scope: ParameterScope.job, key: key);

  T? getInStepScope<T>({
    required String key,
  }) =>
      _get(scope: ParameterScope.step, key: key);

  bool containsKey({
    required ParameterScope scope,
    required String key,
  }) {
    if (!_parameters.containsKey(key)) {
      return false;
    }

    return _parameters[key]!.scope == scope;
  }

  void _put<T>({
    required ParameterScope scope,
    required String key,
    required T value,
    required JobRelationship relationship,
  }) =>
      _parameters[key] = Parameter(
        scope: scope,
        value: value,
        relationship: relationship,
      );

  T? _get<T>({
    required ParameterScope scope,
    required String key,
  }) {
    if (!containsKey(scope: scope, key: key)) {
      return null;
    }

    return _parameters[key]!.value;
  }
}
