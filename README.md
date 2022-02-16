<p align="center">
  <a href="https://github.com/myConsciousness/batch.dart">
    <img alt="batch" width="500px" src="https://user-images.githubusercontent.com/13072231/154017374-9cf5b25c-8647-4091-b73b-38883bef4a1f.png">
  </a>
</p>

<p align="center">
A lightweight and powerful batch library written in Dart.
</p>

---

[![pub package](https://img.shields.io/pub/v/batch.svg?logo=dart&logoColor=00b9fc)](https://pub.dartlang.org/packages/batch)
[![Test](https://github.com/myConsciousness/batch.dart/actions/workflows/test.yml/badge.svg)](https://github.com/myConsciousness/batch.dart/actions/workflows/test.yml)
[![Analyzer](https://github.com/myConsciousness/batch.dart/actions/workflows/analyzer.yml/badge.svg)](https://github.com/myConsciousness/batch.dart/actions/workflows/analyzer.yml)
[![Last Commits](https://img.shields.io/github/last-commit/myConsciousness/batch.dart?logo=git&logoColor=white)](https://github.com/myConsciousness/batch.dart/commits/main)
[![Pull Requests](https://img.shields.io/github/issues-pr/myConsciousness/batch.dart?logo=github&logoColor=white)](https://github.com/myConsciousness/batch.dart/pulls)
[![Code size](https://img.shields.io/github/languages/code-size/myConsciousness/batch.dart?logo=github&logoColor=white)](https://github.com/leisimyConsciousnessm/batch.dart)
[![License](https://img.shields.io/github/license/myConsciousness/batch.dart?logo=open-source-initiative&logoColor=green)](https://github.com/myConsciousness/batch.dart/blob/main/LICENSE)

---

<!-- TOC -->

- [1. About](#1-about)
  - [1.1. Concepts](#11-concepts)
  - [1.2. Introduction](#12-introduction)
    - [1.2.1. Install Library](#121-install-library)
    - [1.2.2. Import It](#122-import-it)
    - [1.2.3. Use Batch](#123-use-batch)
  - [1.3. Contribution](#13-contribution)
  - [1.4. License](#14-license)
  - [1.5. More Information](#15-more-information)

<!-- /TOC -->

# 1. About

The `batch` library was created to make it easier to develop `CLI program` in Dart language. It supports scheduling using `Cron` and it is a very lightweight and powerful.

## 1.1. Concepts

The processing of the `batch` library is mainly performed using the following elements.

|          | Remarks                                                                                                                                                              |
| -------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Job**  | `Job` is defined as the largest unit in a batch execution process in `batch` library. `Job` has a unique name and manages multiple `Step`.                           |
| **Step** | `Step` is defined as middle unit in a batch execution process in `batch` library. `Step` has a unique name and manages multiple `Task`.                              |
| **Task** | `Task` is defined as the smallest unit in a batch execution process in `batch` library. `Task` defines the specific process to be performed in the batch processing. |

The concepts in the table above are in hierarchical order, with the top concepts encompassing the lower elements. However, this hierarchy only represents the layers of processing, and the higher level processing does not affect the lower level processing and vice versa.

## 1.2. Introduction

### 1.2.1. Install Library

**_With Dart:_**

```terminal
 dart pub add batch
```

**_With Flutter:_**

```terminal
 flutter pub add batch
```

### 1.2.2. Import It

```dart
import 'package:batch/batch.dart';
```

### 1.2.3. Use Batch

The easiest way to use the `batch` library is to create a class that implements `Task` and register it to Step and Job in the order you want to execute.

The execution schedule is specified for each job when creating a `Job` instance in the form of [Cron](https://en.wikipedia.org/wiki/Cron).

When creating `Job` and `Task` instances, the names should be unique. However, you can use the same name for steps contained in different `Job`.

```dart
import 'package:batch/batch.dart';

void main() {
  // The name of the Job must be unique.
  final job1 = Job.from(name: 'Job1', cron: '*/1 * * * *')
    // The name of the Step must be unique in this Job.
    ..nextStep(
      Step.from(name: 'Step1')
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    )
    ..nextStep(
      Step.from(name: 'Step2')
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    );

  final job2 = Job.from(name: 'Job2', cron: '*/3 * * * *')
    ..nextStep(
      // You can reuse the Step name for another Job.
      Step.from(name: 'Step1')
        ..nextTask(SayHelloTask())
        ..nextTask(SayWorldTask()),
    );

  // Add jobs and execute.
  JobLauncher.newInstance()
    ..addJob(job1)
    ..addJob(job2)
    ..execute();
}

class SayHelloTask extends Task {
  @override
  Future<RepeatStatus> execute() async {
    print('Hello,');
    return RepeatStatus.finished;
  }
}

class SayWorldTask extends Task {
  @override
  Future<RepeatStatus> execute() async {
    print('World!');
    return RepeatStatus.finished;
  }
}
```

Also `RepeatStatus` is an important factor when defining `Task` processing.

A `Task` should always return `RepeatStatus`,　 and `RepeatStatus.finished` to finish the process of the `Task`. Another option to return in `Task` processing is `RepeatStatus.continuable`, but if this is returned, the same Task processing will be repeated over and over until `RepeatStatus.finished` is returned.

## 1.3. Contribution

If you would like to contribute to the development of this library, please create an [issue](https://github.com/myConsciousness/batch.dart/issues) or create a Pull Request.

Developer will respond to issues and review pull requests as quickly as possible.

## 1.4. License

```license
Copyright (c) 2022, Kato Shinya. All rights reserved.
Use of this source code is governed by a
BSD-style license that can be found in the LICENSE file.
```

## 1.5. More Information

`Batch` was designed and implemented by **_Kato Shinya_**.

- [Creator Profile](https://github.com/myConsciousness)
- [License](https://github.com/myConsciousness/batch.dart/blob/main/LICENSE)
- [API Document](https://pub.dev/documentation/batch/latest/batch/batch-library.html)
- [Release Note](https://github.com/myConsciousness/batch.dart/releases)
- [Bug Report](https://github.com/myConsciousness/batch.dart/issues)
