# Release Note

## 0.1.0

- Improved documents.
- Wrapped the return value of execute with `Future` to allow asynchronous processing in `Task`. Asynchronous processing defined in `Task` is safely controlled by the `batch` library, so you don't need to be aware of it when running `JobLauncher`.

## 0.0.1

- First Release!
