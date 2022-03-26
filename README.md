<p align="center">
  <a href="https://github.com/batch-dart/batch.dart">
    <img alt="batch" width="500px" src="https://user-images.githubusercontent.com/13072231/157616062-6208b014-e104-49f4-8227-b491b7ef6d42.png">
  </a>
</p>

<p align="center">
A lightweight and powerful Job Scheduling Framework.
</p>

---

[![pub package](https://img.shields.io/pub/v/batch.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/batch)
[![Dart SDK Version](https://badgen.net/pub/sdk-version/batch)](https://pub.dev/packages/batch/)
[![Test](https://github.com/batch-dart/batch.dart/actions/workflows/test.yml/badge.svg)](https://github.com/batch-dart/batch.dart/actions/workflows/test.yml)
[![Analyzer](https://github.com/batch-dart/batch.dart/actions/workflows/analyzer.yml/badge.svg)](https://github.com/batch-dart/batch.dart/actions/workflows/analyzer.yml)
[![codecov](https://codecov.io/gh/batch-dart/batch.dart/branch/main/graph/badge.svg?token=J5GT1PF9Y3)](https://codecov.io/gh/batch-dart/batch.dart)
[![CodeFactor](https://www.codefactor.io/repository/github/batch-dart/batch.dart/badge)](https://www.codefactor.io/repository/github/batch-dart/batch.dart)
[![Issues](https://img.shields.io/github/issues/batch-dart/batch.dart?logo=github&logoColor=white)](https://github.com/batch-dart/batch.dart/issues)
[![Pull Requests](https://img.shields.io/github/issues-pr/batch-dart/batch.dart?logo=github&logoColor=white)](https://github.com/batch-dart/batch.dart/pulls)
[![Stars](https://img.shields.io/github/stars/batch-dart/batch.dart?logo=github&logoColor=white)](https://github.com/batch-dart/batch.dart)
[![Code size](https://img.shields.io/github/languages/code-size/batch-dart/batch.dart?logo=github&logoColor=white)](https://github.com/batch-dart/batch.dart)
[![Last Commits](https://img.shields.io/github/last-commit/batch-dart/batch.dart?logo=git&logoColor=white)](https://github.com/batch-dart/batch.dart/commits/main)
[![License](https://img.shields.io/github/license/batch-dart/batch.dart?logo=open-source-initiative&logoColor=green)](https://github.com/batch-dart/batch.dart/blob/main/LICENSE)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](https://github.com/batch-dart/batch.dart/blob/main/CODE_OF_CONDUCT.md)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbatch-dart%2Fbatch.dart.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbatch-dart%2Fbatch.dart?ref=badge_shield)

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
    - [1.4.2. LogOutput](#142-logoutput)
  - [1.5. Contribution](#15-contribution)
  - [1.6. License](#16-license)
  - [1.7. More Information](#17-more-information)

<!-- /TOC -->


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbatch-dart%2Fbatch.dart.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbatch-dart%2Fbatch.dart?ref=badge_large)

# 1. About

The `batch` library was created to make it easier to develop `job scheduling` and `batch` program in Dart language. It supports easy scheduling using `Cron` and it is a very lightweight and powerful.

> Caution:
> This framework is still in beta and so may contain disruptive changes in the release.

## 1.1. Features

- Very powerful batch library written in Dart.
- Multiple job schedules can be easily defined.
- Intuitive and easy to understand job definitions.
- Easy scheduling of job execution in Cron format.
- Powerful and customizable logging functions without the need for third-party libraries.
- **_You can develop with Dart's resources!_**

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

**_You can check the latest sample codes [here](https://pub.dev/packages/batch/example)!_**

## 1.4. Logging

The `batch` library supports logging since version `0.2.0`.

The logging system provided by the `batch` library is a customized library of [Logger](https://pub.dev/packages/logger), and is optimized for the `batch` library specification. Also the logging system provided by the `batch` library inherits many elements from [Logger](https://pub.dev/packages/logger) from this background.

The `batch` library provides the following logging methods.

|           | Description                                                                                                                                                                        |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **trace** | A log level describing events showing step by step execution of your code that can be ignored during the standard operation, but may be useful during extended debugging sessions. |
| **debug** | A log level used for events considered to be useful during software debugging when more granular information is needed.                                                            |
| **info**  | An event happened, and the event is purely informative and can be ignored during normal operations.                                                                                |
| **warn**  | Unexpected behavior happened inside the application, but it is continuing its work and the key business features are operating as expected.                                        |
| **error** | One or more functionalities are not working, preventing some functionalities from working correctly.                                                                               |
| **fatal** | One or more key business functionalities are not working and the whole system doesn’t fulfill the business functionalities.                                                        |

The logging methods provided by the `batch` library can be used from any class that imports `batch.dart`. Besides there is no need to instantiate an Logger by yourself.

All you need to specify about logging in `batch` library is the configuration of the log, and the Logger is provided safely under the lifecycle of the `batch` library.

See the sample code below for the simplest usage.

```dart
import 'package:batch/batch.dart';

class TestLogTask extends Task<TestLogTask> {
  @override
  void execute() {
    trace('Test trace');
    debug('Test debug');
    info('Test info');
    warn('Test warning');
    error('Test error');
    fatal('Test fatal');
  }
}
```

For example, if you run [sample code](#133-use-batch-library) as described earlier, you will see the following log output.

```terminal
yyyy-MM-dd 19:12:42.860904 [info ] (_BatchApplication.run:117:11  ) - Logger instance has completed loading
yyyy-MM-dd 19:12:42.863685 [info ] (JobScheduler.run:37:9         ) - Started Job scheduling on startup
yyyy-MM-dd 19:12:42.864049 [info ] (JobScheduler.run:38:9         ) - Detected 2 Jobs on the root
yyyy-MM-dd 19:12:42.864413 [info ] (JobScheduler.run:45:11        ) - Scheduling Job [name=Job1]
yyyy-MM-dd 19:12:42.880243 [info ] (JobScheduler.run:45:11        ) - Scheduling Job [name=Job2]
yyyy-MM-dd 19:12:42.882694 [info ] (JobScheduler.run:55:9         ) - Job scheduling has been completed and the batch application is now running
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

### 1.4.2. LogOutput

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

If you would like to contribute to the development of this library, please create an [issue](https://github.com/batch-dart/batch.dart/issues) or create a Pull Request.

Developer will respond to issues and review pull requests as quickly as possible.

## 1.6. License

```license
Copyright 2022 Kato Shinya. All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided the conditions.
```

> Note:
> License notices in the source are strictly validated based on `.github/header-checker-lint.yml`. Please check [header-checker-lint.yml](https://github.com/batch-dart/batch.dart/tree/main/.github/header-checker-lint.yml) for the permitted standards.

## 1.7. More Information

`batch.dart` was designed and implemented by **_Kato Shinya_**.

- [Creator Profile](https://github.com/batch-dart)
- [License](https://github.com/batch-dart/batch.dart/blob/main/LICENSE)
- [API Document](https://pub.dev/documentation/batch/latest/batch/batch-library.html)
- [Release Note](https://github.com/batch-dart/batch.dart/releases)
- [Bug Report](https://github.com/batch-dart/batch.dart/issues)