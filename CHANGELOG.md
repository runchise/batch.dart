# Release Note

## 0.2.0

### New Features

- Added logging feature. Some logs are automatically output to the console during batch processing, but you can output logs at any log level by using the various methods for log output.

### Destructive Changes

- Refactored the structure, made `JobLauncher` private and released `BatchApplication` as new entry point.

## 0.1.0

- Improved documents.
- Wrapped the return value of execute with `Future` to allow asynchronous processing in `Task`. Asynchronous processing defined in `Task` is safely controlled by the `batch` library, so you don't need to be aware of it when running `JobLauncher`.

## 0.0.1

- First Release!
