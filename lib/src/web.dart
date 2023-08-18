part of serial;
// ignore_for_file: avoid_web_libraries_in_flutter

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

  Future<List<SerialPort>> getPorts() async {
      final dynamic ports = await promiseToFuture(_getPorts());
      if (ports is List) {
          return List<SerialPort>.from(ports);
      }
      return [];
  }

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

extension SerialPortExtensions on SerialPort {
  @JS('open')
  external Object _open(_SerialOptions options);
  @JS('close')
  external Object _close();

  @JS('getInfo')
  external SerialPortInfo getInfo();

  @JS('getSignals')
  external SignalState getSignals();
  @JS('setSignals')
  external Object _setSignals(_SignalOptions options);

  external WritableStream get writable;
  external ReadableStream get readable;

  /// Opens the serial port.
  Future<void> open({
    required int baudRate,
    DataBits dataBits = DataBits.eight,
    StopBits stopBits = StopBits.one,
    Parity parity = Parity.none,
    int bufferSize = 255,
    FlowControl flowControl = FlowControl.none,
  }) {
    final promise = _open(
      _SerialOptions(
        baudRate: baudRate,
        dataBits: _getDataBits(dataBits),
        stopBits: _getStopBits(stopBits),
        parity: _getParityString(parity),
        bufferSize: bufferSize,
        flowControl: _getFlowControlString(flowControl),
      ),
    );

    return promiseToFuture(promise);
  }

  /// Closes the serial port.
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

  /// Sets control signals on the port.
  Future<void> setSignals({
    bool dataTerminalReady = false,
    bool requestToSend = false,
    // bool break = false,
  }) {
    final promise = _setSignals(_SignalOptions(
      dataTerminalReady: dataTerminalReady,
      requestToSend: requestToSend,
      // break: break
    ));

    return promiseToFuture(promise);
  }
}

/// Extensions on [WritableStream].
extension WritableStreamExtensions on WritableStream {
  @JS('getWriter')
  external WritableStreamDefaultWriter _getWriter();

  @JS('close')
  external Object _close();

  /// Closes the [WritableStream].
  Future<void> close() => promiseToFuture(_close());

  /// Gets the writer interface of the [WritableStream].
  WritableStreamDefaultWriter get writer => _getWriter();
}

/// Extensions on [ReadableStream].
extension ReadableStreamExtensions on ReadableStream {
  @JS('getReader')
  external ReadableStreamReader _getReader();

  @JS('cancel')
  external Object _cancel();

  @JS('close')
  external Object _close();

  external bool get locked;

  /// Cancels the [ReadableStream].
  Future<void> cancel() => promiseToFuture(_cancel());

  /// Closes the [ReadableStream].
  Future<void> close() => promiseToFuture(_close());

  /// Gets the reader interface of the [ReadableStream].
  ReadableStreamReader get reader => _getReader();
}

/// Extensions on [WritableStreamDefaultWriter].
extension WritableStreamDefaultWriterExtensions on WritableStreamDefaultWriter {
  @JS('write')
  external Object _write(Uint8List chunk);
  @JS('close')
  external Object _close();

  @JS('closed')
  external Object get _closed;

  /// Gets the desired size.
  external double? get desiredSize;

  @JS('ready')
  external Object get _ready;
  @JS('abort')
  external Object _abort([Object? reason]);

  /// Release Lock.
  external void releaseLock();

  /// Writes a chunk.
  Future<void> write(Uint8List chunk) => promiseToFuture(_write(chunk));

  /// Closes the writer.
  Future<void> close() => promiseToFuture(_close());

  /// Await until the stream is ready.
  Future<void> get ready => promiseToFuture(_ready);

  /// Returns a promise that will be fulfilled when the stream becomes closed,
  /// or rejected if the stream ever errors or the reader’s lock is released
  /// before the stream finishes closing.
  Future<void> get closed => promiseToFuture(_closed);
  Future<void> abort([Object? reason]) => promiseToFuture(_abort(reason));
}

/// Extensions on [ReadableStreamReader].
extension ReadableStreamReaderExtensions on ReadableStreamReader {
  @JS('closed')
  external Object get _closed;

  @JS('read')
  external Object _read();

  @JS('cancel')
  external Object _cancel();

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

  Future<void> get closed => promiseToFuture(_closed);

  /// Returns a promise that allows access to the next chunk from the stream’s internal queue, if available.
  ///
  /// - If the chunk does become available, the promise will be fulfilled with an object of the form { value: theChunk, done: false }.
  /// - If the stream becomes closed, the promise will be fulfilled with an object of the form { value: undefined, done: true }.
  /// - If the stream becomes errored, the promise will be rejected with the relevant error.
  ///
  /// If reading a chunk causes the queue to become empty, more data will be pulled from the underlying source.
  Future<ReadableStreamDefaultReadResult> read() => promiseToFuture(_read());

  /// Cancels the [ReadableStreamReader].
  Future<void> cancel() => promiseToFuture(_cancel());
}

/// Extensions on [ReadableStreamDefaultReadResult].
extension ReadableStreamDefaultReadResultExtensions
    on ReadableStreamDefaultReadResult {
  external Uint8List get value;
  external bool get done;
}
