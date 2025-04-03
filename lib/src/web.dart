part of '../serial.dart';

/// Adds [serial] to [Navigator].
extension NavigatorExtension on Navigator {
  /// Serial accessor.
  external Serial get serial;
}

/// Adds [serial] to [WorkerNavigator].
extension WorkerNavigatorExtension on WorkerNavigator {
  /// Serial accessor.
  external Serial get serial;
}

/// Serial.
@JS()
extension type Serial._(JSObject _) {
  /// Presents the user with a dialog asking them to select a serial device to connect to.
  /// It returns a [JSPromise] that resolves with an instance of [SerialPort] representing the device chosen by the user.
  ///
  /// When the user first visits a site it will not have permission to access any serial devices.
  /// A site must first call [requestPort] to prompt the user to select which device the site should be allowed to control.
  ///
  /// This method must be called via transient activation.
  /// The user has to interact with the page or a UI element in order for this feature to work.
  @JS('requestPort')
  external JSPromise<SerialPort> requestPort();

  /// Returns a [JSPromise] that resolves with an array of [SerialPort] objects representing
  /// serial ports connected to the host which the origin has permission to access.
  @JS('getPorts')
  external JSPromise<JSArray<SerialPort>> getPorts();
}

/// The SerialPort interface of the Web Serial API provides access to a serial port on the host device.
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

  // /// Fired when the port connects to the device.
  // external JSAny? get connect;
  // external set connect(JSAny? value);

  // /// Fired when the port disconnects from the device.
  // external JSAny? get disconnect;
  // external set disconnect(JSAny? value);

  /// Returns a [JSPromise] that resolves when access to the serial port is revoked.
  external JSPromise forget();

  /// Closes the serial port.
  external JSPromise close();

  /// Returns an object containing identifying information for the device available via the port.
  external SerialPortInfo getInfo();

  /// Returns a [WritableStream] for sending data to the device connected to the port.
  /// Chunks written to this stream must be instances of [JSArrayBuffer], [JSTypedArray], or [JSDataView].
  ///
  /// This property is non-null as long as the port is open and has not encountered a fatal error.
  external WritableStream? get writable;

  /// Returns a [ReadableStream] for receiving data from the device connected to the port.
  /// Chunks read from this stream are instances of [JSUint8Array].
  ///
  /// This property is non-null as long as the port is open and has not encountered a fatal error.
  external ReadableStream? get readable;

  /// Indicates whether the port is logically connected to the device.
  ///
  /// When a wireless device goes out of range of the host, any wireless serial port opened by a web app automatically closes, even though it stays logically connected. In such cases, the web app could attempt to reopen the port using SerialPort.open().
  ///
  /// However, if the wireless device was intentionally disconnected (for example, if the user chose to disconnect it using the operating system control panel), the web app should refrain from reopening the port to prevent reconnecting to the wireless device.
  external bool get connected;

  /// Returns a [JSPromise] that resolves with an object containing the current state of the port's control signals.
  @JS('getSignals')
  external JSPromise<SignalState> getSignals();
  @JS('setSignals')
  external JSPromise _setSignals(_SignalOptions options);

  /// Sets control signals on the port and returns a [JSPromise] that resolves when they are set.
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
