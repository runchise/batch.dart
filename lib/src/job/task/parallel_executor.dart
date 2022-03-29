// Dart imports:
import 'dart:async';

// Package imports:
import 'package:async_task/async_task.dart';

class ParallelExecutor extends AsyncTask<void, void> {
  @override
  AsyncTask<void, void> instantiate(void parameters,
      [Map<String, SharedData>? sharedData]) {
    return this;
  }

  @override
  void parameters() {}

  @override
  FutureOr<void> run() async {
    try {} catch (e) {
      rethrow;
    }
  }
}
