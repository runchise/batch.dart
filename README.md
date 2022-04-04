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
  - [1.1. Mission](#11-mission)
  - [1.2. Features](#12-features)
  - [1.3. Basic Usage](#13-basic-usage)
    - [1.3.1. Install Library](#131-install-library)
    - [1.3.2. Import](#132-import)
    - [1.3.3. Configure Job Schedules](#133-configure-job-schedules)
  - [1.4. Logging](#14-logging)
    - [1.4.1. Customize Log Configuration](#141-customize-log-configuration)
    - [1.4.2. LogOutput](#142-logoutput)
  - [1.5. Contribution](#15-contribution)
  - [1.6. Support](#16-support)
  - [1.7. License](#17-license)
  - [1.8. More Information](#18-more-information)

<!-- /TOC -->

# 1. About

The `Batch.dart` specification is large and more detailed documentation can be found from [official references](https://github.com/batch-dart/docs/blob/main/README.md).
Also you can find detail examples of implementation at [here](https://pub.dev/packages/batch/example).

## 1.1. Mission

The goal of this project is to provide a **_high-performance_** and **_intuitive_** job scheduling framework in the Dart language ecosystem that anyone can use in the world.

And the development concept of this framework is "[DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)", "[KISS](https://en.wikipedia.org/wiki/KISS_principle)" and "[YAGNI](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it)", which has been said in software engineering circles for a long time.

## 1.2. Features

- Easy and intuitive job scheduling.
- Scheduling in Cron format provided as standard (Customizable).
- Powerful logging feature provided as standard (Customizable).
- You can easily define parallel processes.
- There are no hard-to-understand configuration files.
- Supports conditional branching of jobs.
- Extensive callback functions are provided at each step.
- Supports skipping and retrying according to user defined conditions.

## 1.3. Basic Usage

### 1.3.1. Install Library

```terminal
 dart pub add batch
```

> Note:
> In pub.dev, the automatic determination at the time of release of this library labels it as usable in Flutter, but it is not suitable by any stretch of the imagination.

### 1.3.2. Import

The following import will provide all the materials for developing job scheduling using `Batch.dart`.

```dart
import 'package:batch/batch.dart';
```

### 1.3.3. Configure Job Schedules

The easiest way to use the `Batch.dart` is to create a class that implements `Task` and register it to `Step` and `Job` in the order you want to execute.

The execution schedule is specified for each job when creating a `Job` instance in the form of [Cron](https://en.wikipedia.org/wiki/Cron).

When creating `Job` and `Task` instances, the names should be unique. However, you can use the same name for steps contained in different `Job`.

**_Example_**

```dart
import 'package:batch/batch.dart';

void main() => BatchApplication(
      logConfig: LogConfiguration(
        level: LogLevel.trace,
        output: MultiLogOutput([
          ConsoleLogOutput(),
          FileLogOutput(file: File('./test.txt')),
        ]),
        color: LogColor(
          info: ConsoleColor.cyan3,
        ),
      ),
    )
      // You can add any parameters that is shared in this batch application.
      ..addSharedParameter(key: 'key1', value: 'value1')
      ..addSharedParameter(key: 'key2', value: {'any': 'object'})
      ..addJob(
        // Scheduled to start every minute in Cron format
        Job(name: 'Job', schedule: CronParser(value: '*/1 * * * *'))
          ..nextStep(
            Step(name: 'Step')..nextTask(DoSomethingTask()),
          ),
      )
      ..run();


class DoSomethingTask extends Task<DoSomethingTask> {
  @override
  void execute(ExecutionContext) {
    // Write your code here.
  }
}
```

The above example is a very simple, and so you should refer to another document for more detailed specifications and implementation instructions.

**_You can see more details at [official documents](https://github.com/batch-dart/docs/blob/main/README.md) or [example](https://pub.dev/packages/batch/example)_**.

## 1.4. Logging

The `Batch.dart` provides the following well-known logging features as a standard.

- **_trace_**
- **_debug_**
- **_info_**
- **_warn_**
- **_error_**
- **_fatal_**

The logging methods provided by the `Batch.dart` can be used from any class that imports `batch.dart`. **_And there is no need to instantiate any Loggers by yourself_**!

All you need to specify about logging in `Batch.dart` is the configuration of the log before run `BatchApplication`, and the Logger is provided safely under the lifecycle of the `Batch.dart`.

See the sample below for the simplest usage.

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

    // You can add "log." as a prefix.
    log.trace('Test trace');
  }
}
```

For example, if you run [example code](https://pub.dev/packages/batch/example), you will get the following log output.

```terminal
yyyy-MM-dd 19:25:10.575109 [info ] (_BatchApplication.run:129:11  ) - 🚀🚀🚀🚀🚀🚀🚀 The batch process has started! 🚀🚀🚀🚀🚀🚀🚀
yyyy-MM-dd 19:25:10.579318 [info ] (_BatchApplication.run:130:11  ) - Logger instance has completed loading
yyyy-MM-dd 19:25:10.580177 [info ] (_BootDiagnostics.run:32:9     ) - Batch application diagnostics have been started
yyyy-MM-dd 19:25:10.583234 [info ] (_BootDiagnostics.run:46:9     ) - Batch application diagnostics have been completed
yyyy-MM-dd 19:25:10.583344 [info ] (_BootDiagnostics.run:47:9     ) - Batch applications can be started securely
yyyy-MM-dd 19:25:10.585729 [info ] (JobScheduler.run:37:9         ) - Started Job scheduling on startup
yyyy-MM-dd 19:25:10.585921 [info ] (JobScheduler.run:38:9         ) - Detected 3 Jobs on the root
yyyy-MM-dd 19:25:10.586023 [info ] (JobScheduler.run:41:11        ) - Scheduling Job [name=Job1]
yyyy-MM-dd 19:25:10.595706 [info ] (JobScheduler.run:41:11        ) - Scheduling Job [name=Job2]
yyyy-MM-dd 19:25:10.597471 [info ] (JobScheduler.run:41:11        ) - Scheduling Job [name=Job4]
yyyy-MM-dd 19:25:10.597692 [info ] (JobScheduler.run:56:9         ) - Job scheduling has been completed and the batch application is now running
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

|                      | Description                                                                                                                      |
| -------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| **ConsoleLogOutput** | Provides features to output log to console. This filter is used by default.                                                      |
| **FileLogOutput**    | Provides features to output the log to the specified file.                                                                       |
| **MultiLogOutput**   | Allows multiple log outputs. This is useful, for example, when you want to have console output and file output at the same time. |

**_Example_**

```dart
BatchApplication(
  logConfig: LogConfiguration(
    output: ConsoleLogOutput(),
  ),
);
```

**_With MultiLogOutput_**

```dart
BatchApplication(
  logConfig: LogConfiguration(
    output: MultiLogOutput([
      ConsoleLogOutput(),
      FileLogOutput(file: File('./test.txt')),
    ]),
  ),
);
```

## 1.5. Contribution

If you would like to contribute to `Batch.dart`, please create an [issue](https://github.com/batch-dart/batch.dart/issues) or create a Pull Request.

Owner will respond to issues and review pull requests as quickly as possible.

## 1.6. Support

The simplest way to show us your support is by giving the project a star at [here](https://github.com/batch-dart/batch.dart).

And I'm always looking for sponsors to support this project. I am not asking for royalties for use in providing this framework, but I do need support to continue ongoing open source development.

Sponsors can be individuals or corporations, and the amount is optional.

If you would like to sponsor me, please check my [sponsorship page](https://github.com/sponsors/myConsciousness) on GitHub or contact me at kato.shinya.dev@gmail.com.

## 1.7. License

All resources of `Batch.dart` is provided under the `BSD-3` license.

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fbatch-dart%2Fbatch.dart.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fbatch-dart%2Fbatch.dart?ref=badge_large)

> Note:
> License notices in the source are strictly validated based on `.github/header-checker-lint.yml`. Please check [header-checker-lint.yml](https://github.com/batch-dart/batch.dart/tree/main/.github/header-checker-lint.yml) for the permitted standards.

## 1.8. More Information

`Batch.dart` was designed and implemented by **_Kato Shinya_**.

- [Creator Profile](https://github.com/myConsciousness)
- [License](https://github.com/batch-dart/batch.dart/blob/main/LICENSE)
- [API Document](https://pub.dev/documentation/batch/latest/batch/batch-library.html)
- [Official Documents](https://github.com/batch-dart/docs/blob/main/README.md)
- [Wikipedia](https://ja.wikipedia.org/wiki/Batch.dart)
- [Release Note](https://github.com/batch-dart/batch.dart/releases)
- [Bug Report](https://github.com/batch-dart/batch.dart/issues)
