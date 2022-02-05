// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html';
import 'dart:typed_data';

import 'package:js/js.dart';

extension NavigatorExtension on Navigator {
  external Serial get serial;
}

@JS()
@staticInterop
abstract class Serial {}

extension SerialExtensions on Serial {
  @JS('getPorts')
  external Object _getPorts();

  @JS('requestPort')
  external Object _requestPort();

  Future<List<SerialPort>> getPorts() =>
      promiseToFuture<List<SerialPort>>(_getPorts());

  Future<SerialPort> requestPort() =>
      promiseToFuture<SerialPort>(_requestPort());
}

@JS()
@staticInterop
abstract class SerialPort {}

@JS()
@anonymous
abstract class WritableStream {}

@JS()
@anonymous
abstract class ReadableStream {}

@JS()
@anonymous
abstract class WritableStreamDefaultWriter {}

@JS()
@anonymous
abstract class ReadableStreamReader {}

@JS()
@anonymous
abstract class ReadableStreamDefaultReadResult {}

class SerialOptions {
  SerialOptions({
    required this.baudRate,
    this.dataBits = 8,
    this.stopBits = 1,
    this.parity = 'none',
    this.bufferSize = 255,
    this.flowControl = 'none',
  });

  /// A positive, non-zero value indicating the baud rate at which serial communication should be established.
  final int baudRate;

  /// The number of data bits per frame. Either 7 or 8.
  final int dataBits;

  /// The number of stop bits at the end of a frame. Either 1 or 2.
  final int stopBits;

  /// The parity mode.
  final String parity;

  /// A positive, non-zero value indicating the size of the read and write buffers that should be created.
  final int bufferSize;

  final String flowControl;
}

@JS()
@anonymous
abstract class SerialPortInfo {
  external factory SerialPortInfo({
    int? usbVendorId,
    int? usbProductId,
  });

  /// If the port is part of a USB device, an unsigned short integer that identifies a USB device vendor, otherwise `null`.
  external int? get usbVendorId;

  /// If the port is part of a USB device, an unsigned short integer that identiffies a USB device, otherwise `null`.
  external int? get usbProductId;
}

extension SerialPortExtensions on SerialPort {
  @JS('open')
  external Object _open(SerialOptions options);
  @JS('close')
  external Object _close();

  external WritableStream get writable;
  external ReadableStream get readable;

  @JS('getInfo')
  external SerialPortInfo? getInfo();

  Future<void> open(SerialOptions options) => promiseToFuture(_open(options));
  Future<void> close() => promiseToFuture(_close());

  // Returns a `Future` that resolves with a `SerialPortInfo` containing properties of the port.
  //
  // This feature is available only in secure contexts (HTTPS), in some or all supporting browsers.
  //
  // Future<SerialPortInfo?> getInfo() async {
  //   final promise = _getInfo();
  //   if (promise == null) {
  //     return null;
  //   }

  //   final info = await promiseToFuture<SerialPortInfo?>(promise);

  //   return info;
  // }
}

extension WritableStreamExtensions on WritableStream {
  @JS('getWriter')
  external WritableStreamDefaultWriter _getWriter();

  @JS('getReader')
  external ReadableStreamReader _getReader();

  @JS('close')
  external Object _close();

  Future<void> close() => promiseToFuture(_close());
  WritableStreamDefaultWriter get writer => _getWriter();
  ReadableStreamReader get reader => _getReader();
}

extension ReadableStreamExtensions on ReadableStream {
  @JS('getReader')
  external ReadableStreamReader _getReader();

  @JS('close')
  external Object _close();

  Future<void> close() => promiseToFuture(_close());
  ReadableStreamReader get reader => _getReader();
}

extension WritableStreamDefaultWriterExtensions on WritableStreamDefaultWriter {
  @JS('write')
  external Object _write(Uint8List chunk);
  @JS('close')
  external Object _close();

  @JS('closed')
  external Object get _closed;
  external double? get desiredSize;

  @JS('ready')
  external Object get _ready;
  @JS('abort')
  external Object _abort([Object? reason]);
  external void releaseLock();

  Future<void> write(Uint8List chunk) => promiseToFuture(_write(chunk));
  Future<void> close() => promiseToFuture(_close());
  Future<void> get ready => promiseToFuture(_ready);

  /// Returns a promise that will be fulfilled when the stream becomes closed,
  /// or rejected if the stream ever errors or the reader’s lock is released
  /// before the stream finishes closing.
  Future<void> get closed => promiseToFuture(_closed);
  Future<void> abort([Object? reason]) => promiseToFuture(_abort(reason));
}

extension ReadableStreamReaderExtensions on ReadableStreamReader {
  @JS('read')
  external Object _read();

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

  /// Returns a promise that allows access to the next chunk from the stream’s internal queue, if available.
  ///
  /// - If the chunk does become available, the promise will be fulfilled with an object of the form { value: theChunk, done: false }.
  /// - If the stream becomes closed, the promise will be fulfilled with an object of the form { value: undefined, done: true }.
  /// - If the stream becomes errored, the promise will be rejected with the relevant error.
  ///
  /// If reading a chunk causes the queue to become empty, more data will be pulled from the underlying source.
  Future<ReadableStreamDefaultReadResult> read() => promiseToFuture(_read());
}

extension ReadableStreamDefaultReadResultExtensions
    on ReadableStreamDefaultReadResult {
  external Uint8List get value;
  external bool get done;
}
