part of '../serial.dart';

extension NavigatorExtension on Navigator {
  external Serial get serial;
}

@JS()
extension type Serial._(JSObject _) {
  @JS('requestPort')
  external JSPromise<SerialPort> requestPort();

  @JS('getPorts')
  external JSPromise<JSArray<SerialPort>> getPorts();
}

@JS()
extension type SerialPort._(JSObject _) implements JSObject {
  @JS('open')
  external JSPromise _open(_SerialOptions options);

  /// Opens the serial port.
  JSPromise open({
    required int baudRate,
    DataBits dataBits = DataBits.eight,
    StopBits stopBits = StopBits.one,
    Parity parity = Parity.none,
    int bufferSize = 255,
    FlowControl flowControl = FlowControl.none,
  }) {
    final options = _SerialOptions(
      baudRate: baudRate,
      dataBits: _getDataBits(dataBits),
      stopBits: _getStopBits(stopBits),
      parity: _getParityString(parity),
      bufferSize: bufferSize,
      flowControl: _getFlowControlString(flowControl),
    );

    return _open(options);
  }

  /// Closes the serial port.
  @JS('close')
  external JSPromise close();

  @JS('getInfo')
  external SerialPortInfo getInfo();

  @JS('writable')
  external WritableStream get writable;

  @JS('readable')
  external ReadableStream get readable;

  @JS('getSignals')
  external SignalState getSignals();
  @JS('setSignals')
  external JSPromise _setSignals(_SignalOptions options);

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
  JSPromise setSignals({
    bool dataTerminalReady = false,
    bool requestToSend = false,
    // bool break = false,
  }) {
    final promise = _setSignals(_SignalOptions(
      dataTerminalReady: dataTerminalReady,
      requestToSend: requestToSend,
      // break: break
    ));

    return promise;
  }
}
