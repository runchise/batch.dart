<p align="center">
  <a href="https://github.com/myConsciousness/batch.dart">
    <img alt="batch" width="500px" src="https://user-images.githubusercontent.com/13072231/154017374-9cf5b25c-8647-4091-b73b-38883bef4a1f.png">
  </a>
</p>

<p align="center">
A lightweight and powerful job management and batch library written in Dart.
</p>

---

[![pub package](https://img.shields.io/pub/v/batch.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/batch)
[![Test](https://github.com/myConsciousness/batch.dart/actions/workflows/test.yml/badge.svg)](https://github.com/myConsciousness/batch.dart/actions/workflows/test.yml)
[![Analyzer](https://github.com/myConsciousness/batch.dart/actions/workflows/analyzer.yml/badge.svg)](https://github.com/myConsciousness/batch.dart/actions/workflows/analyzer.yml)
[![Last Commits](https://img.shields.io/github/last-commit/myConsciousness/batch.dart?logo=git&logoColor=white)](https://github.com/myConsciousness/batch.dart/commits/main)
[![Pull Requests](https://img.shields.io/github/issues-pr/myConsciousness/batch.dart?logo=github&logoColor=white)](https://github.com/myConsciousness/batch.dart/pulls)
[![Code size](https://img.shields.io/github/languages/code-size/myConsciousness/batch.dart?logo=github&logoColor=white)](https://github.com/myConsciousness/batch.dart)
[![License](https://img.shields.io/github/license/myConsciousness/batch.dart?logo=open-source-initiative&logoColor=green)](https://github.com/myConsciousness/batch.dart/blob/main/LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](https://github.com/myConsciousness/batch.dart/blob/main/CODE_OF_CONDUCT.md)

---

<!-- TOC -->

- [1. About](#1-about)
  - [1.1. Features](#11-features)
  - [1.2. Basic Concepts](#12-basic-concepts)
  - [1.3. Introduction](#13-introduction)
    - [1.3.1. Install Library](#131-install-library)
    - [1.3.2. Import It](#132-import-it)
    - [1.3.3. Use Batch library](#133-use-batch-library)
  - [1.4. Logging](#14-logging)
    - [1.4.1. Customize Log Configuration](#141-customize-log-configuration)
    - [1.4.2. LogFilter](#142-logfilter)
    - [1.4.3. LogOutput](#143-logoutput)
  - [1.5. Contribution](#15-contribution)
  - [1.6. License](#16-license)
  - [1.7. More Information](#17-more-information)

<!-- /TOC -->

# 1. About

The `batch` library was created to make it easier to develop `job management` and `batch` program in Dart language. It supports easy scheduling using `Cron` and it is a very lightweight and powerful.

## 1.1. Features

- Job management library written in Dart.
- Intuitive and easy to understand job definitions.
- Easy scheduling of job execution in Cron format.
- Powerful and customizable logging functions without the need for third-party libraries.
- **_You can use Dart's assets in Job management!_**

## 1.2. Basic Concepts

The processing of the `batch` library is mainly performed using the following elements.

|          | Description                                                                                                                                                          |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Job**  | `Job` is defined as the largest unit in a batch execution process in `batch` library. `Job` has a unique name and manages multiple `Step`.                           |
| **Step** | `Step` is defined as middle unit in a batch execution process in `batch` library. `Step` has a unique name and manages multiple `Task`.                              |
| **Task** | `Task` is defined as the smallest unit in a batch execution process in `batch` library. `Task` defines the specific process to be performed in the batch processing. |

The concepts in the table above are in hierarchical order, with the top concepts encompassing the lower elements. However, this hierarchy only represents the layers of processing, and the higher level processing does not affect the lower level processing and vice versa.

## 1.3. Introduction

### 1.3.1. Install Library

**_With Dart:_**

```terminal
 dart pub add batch
```

**_With Flutter:_**

```terminal
 flutter pub add batch
```

### 1.3.2. Import It

```dart
import 'package:batch/batch.dart';
```

### 1.3.3. Use Batch library

The easiest way to use the `batch` library is to create a class that implements `Task` and register it to Step and Job in the order you want to execute.

The execution schedule is specified for each job when creating a `Job` instance in the form of [Cron](https://en.wikipedia.org/wiki/Cron).

When creating `Job` and `Task` instances, the names should be unique. However, you can use the same name for steps contained in different `Job`.

```dart
import 'package:batch/batch.dart';

void main() {
  // The name of the Job must be unique.
  final job1 = Job(name: 'Job1', cron: '*/1 * * * *')
    // The name of the Step must be unique in this Job.
    ..nextStep(
      Step(name: 'Step1')
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    )
    ..nextStep(
      Step(name: 'Step2')
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    );

  final job2 = Job(name: 'Job2', cron: '*/3 * * * *')
    ..nextStep(
      // You can reuse the Step name for another Job.
      Step(name: 'Step1')
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    );

  // Add jobs and shared parameters, then run.
 BatchApplication()
    // You can add any parameters that is shared in this batch application.
    ..addSharedParameter(key: 'key1', value: 'value1')
    ..addSharedParameter(key: 'key2', value: {'any': 'object'})
    ..addJob(job1)
    ..addJob(job2)
    ..run();
}

class SayHelloTask extends Task<SayHelloTask> {
  @override
  Future<RepeatStatus> execute() async {
    // Logging output is possible at any log level.
    // This library provides trace, debug, info, warning, error and fatal.
    info('Hello,');
    return RepeatStatus.finished;
  }
}

class SayWorldTask extends Task<SayWorldTask> {
  @override
  Future<RepeatStatus> execute() async {
    info('World!');
    return RepeatStatus.finished;
  }
}
```

Also `RepeatStatus` is an important factor when defining `Task` processing.

A `Task` should always return `RepeatStatus`, and `RepeatStatus.finished` to finish the process of the `Task`. Another option to return in `Task` processing is `RepeatStatus.continuable`, but if this is returned, the same Task processing will be repeated over and over until `RepeatStatus.finished` is returned.

## 1.4. Logging

The `batch` library supports logging since version `0.2.0`.

The logging system provided by the `batch` library is a customized library of [Logger](https://pub.dev/packages/logger), and is optimized for the `batch` library specification. Also the logging system provided by the `batch` library inherits many elements from [Logger](https://pub.dev/packages/logger) from this background.

The `batch` library provides the following logging methods.

|             | Description                                                                                                                                                                        |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **trace**   | A log level describing events showing step by step execution of your code that can be ignored during the standard operation, but may be useful during extended debugging sessions. |
| **debug**   | A log level used for events considered to be useful during software debugging when more granular information is needed.                                                            |
| **info**    | An event happened, and the event is purely informative and can be ignored during normal operations.                                                                                |
| **warning** | Unexpected behavior happened inside the application, but it is continuing its work and the key business features are operating as expected.                                        |
| **error**   | One or more functionalities are not working, preventing some functionalities from working correctly.                                                                               |
| **fatal**   | One or more key business functionalities are not working and the whole system doesn’t fulfill the business functionalities.                                                        |

The logging methods provided by the `batch` library can be used from any class that imports `batch.dart`. Besides there is no need to instantiate an Logger by yourself.

All you need to specify about logging in `batch` library is the configuration of the log, and the Logger is provided safely under the lifecycle of the `batch` library.

See the sample code below for the simplest usage.

```dart
import 'package:batch/batch.dart';

class TestLogTask implements Task {
  @override
  Future<RepeatStatus> execute() async {
    trace('Test trace');
    debug('Test debug');
    info('Test info');
    warning('Test warning');
    error('Test error');
    fatal('Test fatal');

    return RepeatStatus.finished;
  }
}
```

For example, if you run [sample code](#123-use-batch-library) as described earlier, you will see the following log output.

```terminal
yyyy-MM-dd 15:03:46.523299 [info   ] :: The job schedule is being configured...
yyyy-MM-dd 15:03:46.532843 [info   ] :: The job schedule has configured!
yyyy-MM-dd 15:04:00.016205 [info   ] :: STARTED JOB (Job1)
yyyy-MM-dd 15:04:00.017023 [info   ] :: STARTED STEP (Job1 -> Step1)
yyyy-MM-dd 15:04:00.021285 [info   ] :: Hello,
yyyy-MM-dd 15:04:00.021510 [info   ] :: World!
yyyy-MM-dd 15:04:00.021581 [info   ] :: FINISHED STEP (Job1 -> Step1)
```

> Note:
> The setup of the logger is done when executing the method `run` in `BatchApplication`.
> If you want to use the logging feature outside the life cycle of the `batch` library,
> be sure to do so after executing the `run` method of the `BatchApplication`.

### 1.4.1. Customize Log Configuration

It is very easy to change the configuration of the Logger provided by the `batch` library to suit your preferences.
Just pass the `LogConfiguration` object to the constructor when instantiating the `JobLauncher`, and the easiest way is to change the log level as below.

```dart
BatchApplication(
  logConfig: LogConfiguration(
    level: LogLevel.debug,
  ),
);
```

Also, the logging feature can be freely customized by inheriting the following abstract classes and setting them in the `LogConfiguration`.

|                | Description                                                                                                             |
| -------------- | ----------------------------------------------------------------------------------------------------------------------- |
| **LogFilter**  | This is the layer that determines whether log output should be performed. By default, only the log level is determined. |
| **LogPrinter** | This layer defines the format for log output.                                                                           |
| **LogOutput**  | This is the layer that actually performs the log output. By default, it outputs to the console.                         |

Also, the `batch` library provides several classes that implement these abstract classes, so you can use them depending on your situation.

### 1.4.2. LogFilter

|                          | Description                                                                                                                                                                                  |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **DevelopmentLogFilter** | This is a simple log filter for development environments. You can control the output of logs just according to the log level in the development environment. This filter is used by default. |
| **ProductionLogFilter**  | This is a simple log filter for production environments. You can control the output of logs just according to the log level in the production environment.                                   |

**_Example_**

```dart
BatchApplication(
  logConfig: LogConfiguration(
    filter: ProductionLogFilter(),
  ),
);
```

### 1.4.3. LogOutput

|                      | Description                                                                 |
| -------------------- | --------------------------------------------------------------------------- |
| **ConsoleLogOutput** | Provides features to output log to console. This filter is used by default. |
| **FileLogOutput**    | Provides features to output the log to the specified file.                  |

**_Example_**

```dart
BatchApplication(
  logConfig: LogConfiguration(
    output: ConsoleLogOutput(),
  ),
);
```

## 1.5. Contribution

If you would like to contribute to the development of this library, please create an [issue](https://github.com/myConsciousness/batch.dart/issues) or create a Pull Request.

Developer will respond to issues and review pull requests as quickly as possible.

## 1.6. License

```license
Copyright (c) 2022, Kato Shinya. All rights reserved.
Use of this source code is governed by a
BSD-style license that can be found in the LICENSE file.
```

## 1.7. More Information

`Batch` was designed and implemented by **_Kato Shinya_**.

- [Creator Profile](https://github.com/myConsciousness)
- [License](https://github.com/myConsciousness/batch.dart/blob/main/LICENSE)
- [API Document](https://pub.dev/documentation/batch/latest/batch/batch-library.html)
- [Release Note](https://github.com/myConsciousness/batch.dart/releases)
- [Bug Report](https://github.com/myConsciousness/batch.dart/issues)
