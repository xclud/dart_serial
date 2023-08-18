part of serial;

@JS()
@anonymous
abstract class SignalState {
  external factory SignalState({
    bool? clearToSend,
    bool? dataCarrierDetect,
    bool? dataSetReady,
    bool? ringIndicator,
  });

  /// A boolean indicating to the other end of a serial connection that is clear to send data.
  external bool? get clearToSend;
  external set clearToSend(bool? v);

  /// A boolean that toggles the control signal needed to communicate over a serial connection.
  external bool? get dataCarrierDetect;
  external set dataCarrierDetect(bool? v);

  /// A boolean indicating whether the device is ready to send and receive data.
  external bool? get dataSetReady;
  external set dataSetReady(bool? v);

  /// A boolean indicating whether a ring signal should be sent down the serial connection.
  external bool? get ringIndicator;
  external set ringIndicator(bool? v);
}
