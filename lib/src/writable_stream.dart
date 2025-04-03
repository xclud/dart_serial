part of '../serial.dart';

@JS()
extension type WritableStream._(JSObject _) {
  /// Gets the writer interface of the [WritableStream].
  @JS('getWriter')
  external WritableStreamDefaultWriter getWriter();

  /// Closes the [WritableStream].
  @JS('close')
  external JSPromise close();

  /// Closes the [WritableStream].
  @JS('abort')
  external JSPromise abort([String? reason]);

  @JS('locked')
  external bool get locked;
}

@JS()
extension type WritableStreamDefaultWriter._(JSObject _) {
  external WritableStreamDefaultWriter();

  /// Writes a chunk.
  @JS('write')
  external JSPromise write(JSUint8Array chunk);

  /// Closes the writer.
  @JS('close')
  external JSPromise close();

  /// Returns a promise that will be fulfilled when the stream becomes closed,
  /// or rejected if the stream ever errors or the reader’s lock is released
  /// before the stream finishes closing.
  @JS('closed')
  external JSPromise get closed;

  /// Gets the desired size.
  external double? get desiredSize;

  /// Await until the stream is ready.
  @JS('ready')
  external JSPromise get ready;

  @JS('abort')
  external JSPromise abort([JSObject? reason]);

  /// Release Lock.
  external void releaseLock();
}
