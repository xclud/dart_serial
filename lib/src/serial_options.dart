part of serial;

/// Options for [SerialPortExtensions.open].
@JS()
@anonymous
abstract class _SerialOptions {
  /// The external constructor.
  external factory _SerialOptions({
    required int baudRate,
    int dataBits = 8,
    int stopBits = 1,
    String parity = 'none',
    int bufferSize = 255,
    String flowControl = 'none',
  });

  /// A positive, non-zero value indicating the baud rate at which serial communication should be established.
  external int get baudRate;
  external set baudRate(int v);

  /// The number of data bits per frame. Either 7 or 8.
  external int get dataBits;
  external set dataBits(int v);

  /// The number of stop bits at the end of a frame. Either 1 or 2.
  external int get stopBits;
  external set stopBits(int v);

  /// The parity mode.
  external String get parity;
  external set parity(String v);

  /// A positive, non-zero value indicating the size of the read and write buffers that should be created.
  external int get bufferSize;
  external set bufferSize(int v);

  /// Flow control.
  external String get flowControl;
  external set flowControl(String v);
}
