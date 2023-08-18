part of serial;

/// Options for [SignalPortExtensions.setSignals].
@JS()
@anonymous
abstract class _SignalOptions {
  /// The external constructor.
  external factory _SignalOptions({
    bool dataTerminalReady = false,
    bool requestToSend = false,
    // bool break = false
  });

  /// A boolean indicating whether to invoke the operating system to either assert (if true) or de-assert (if false) the "data terminal ready" or "DTR" signal on the serial port.
  external bool get dataTerminalReady;
  external set dataTerminalReady(bool v);

  /// A boolean indicating whether to invoke the operating system to either assert (if true) or de-assert (if false) the "request to send" or "RTS" signal on the serial port.
  external bool get requestToSend;
  external set requestToSend(bool v);

  /// A boolean indicating whether to invoke the operating system to either assert (if true) or de-assert (if false) the "break" signal on the serial port.
  // TODO: break is reserved keyword
  // external bool get break;
  // external set break(bool v);
}
