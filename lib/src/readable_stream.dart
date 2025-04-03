part of '../serial.dart';

@JS()
extension type ReadableStream._(JSObject _) {
  external ReadableStream();

  /// Gets the reader interface of the [ReadableStream].
  @JS('getReader')
  external ReadableStreamDefaultReader getReader();

  /// Cancels the [ReadableStream].
  @JS('cancel')
  external JSPromise cancel([String? reason]);

  /// Closes the [ReadableStream].
  @JS('close')
  external JSPromise close();

  @JS('locked')
  external bool get locked;
}

@JS()
extension type ReadableStreamDefaultReader._(JSObject _) {
  @JS('closed')
  external JSPromise get closed;

  /// Returns a promise that allows access to the next chunk from the stream’s internal queue, if available.
  ///
  /// - If the chunk does become available, the promise will be fulfilled with an object of the form { value: theChunk, done: false }.
  /// - If the stream becomes closed, the promise will be fulfilled with an object of the form { value: undefined, done: true }.
  /// - If the stream becomes errored, the promise will be rejected with the relevant error.
  ///
  /// If reading a chunk causes the queue to become empty, more data will be pulled from the underlying source.
  @JS('read')
  external JSPromise<ReadableStreamDefaultReadResult> read();

  /// Cancels the [ReadableStreamDefaultReader].
  @JS('cancel')
  external JSPromise cancel();

  /// Releases the reader’s lock on the corresponding stream.
  /// After the lock is released, the reader is no longer active.
  /// If the associated stream is errored when the lock is released,
  /// the reader will appear errored in the same way from now on;
  /// otherwise, the reader will appear closed.
  ///
  /// If the reader’s lock is released while it still has pending read requests,
  /// then the promises returned by the reader’s `read` method are immediately rejected
  /// with a TypeError. Any unread chunks remain in the stream’s internal queue and can
  /// be read later by acquiring a new reader.
  external void releaseLock();
}

@JS()
extension type ReadableStreamDefaultReadResult._(JSObject _) implements JSAny {
  external JSUint8Array? get value;
  external bool get done;
}
