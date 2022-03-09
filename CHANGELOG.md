# Release Note

## 0.4.0

### New Features

- Added `onStarted`, `onSucceeded`, `onError` and `onCompleted` callbacks for `Job`, `Step` and `Task`.
- Added feature to specify the color of the message when logging out with `LogColor` and `ConsoleColor`.
- Improved log message from framework.
- Added convenient method `shutdown()` to shutdown the application from `Task`.

## 0.3.0

### New Features

- Added `Precondition` to check the preconditions for executing `Job`, `Step` and `Task`.
- Conditional branching is now possible for the all layers (`Job`/`Step`/`Task`) based on `BranchStatus` by using the `branchOnSucceeded`, `branchOnFailed` and `branchOnCompleted`.
- Due to the feature to create branches in `Job`, the schedule argument of the `Job` object is no longer required. However, be sure to set up a schedule for the root `Job`s.

### Destructive Changes

- Changed the type of the argument when specifying `Job` scheduling. Now you can use `CronParser` to specify the schedule in Cron format.

## 0.2.1

### New Features

- Added `DefaultLogFilter`.
- Added `Precondition` to check the starting condition of `Job` and `Step`. It can be specified as an argument when creating `Job` and `Step` instances.

### Destructive Changes

- Deleted `DevelopmentLogFilter` and `ProductionLogFilter`.

## 0.2.0

### New Features

- Added logging feature. Some logs are automatically output to the console during batch processing, but you can output logs at any log level by using the various methods for log output.
- Enabled parameter exchange between tasks in the same step.
- Added the concept of SharedParameters, which are shared by the entire batch application.

### Destructive Changes

- Refactored the structure, made `JobLauncher` private and released `BatchApplication` as new entry point.
- Added ExecutionContext as an argument to the execute method of the Task class.

## 0.1.0

- Improved documents.
- Wrapped the return value of execute with `Future` to allow asynchronous processing in `Task`. Asynchronous processing defined in `Task` is safely controlled by the `batch` library, so you don't need to be aware of it when running `JobLauncher`.

## 0.0.1

- First Release!
