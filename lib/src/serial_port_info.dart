part of serial;

@JS()
@anonymous
abstract class SerialPortInfo {
  external factory SerialPortInfo({
    int? usbVendorId,
    int? usbProductId,
  });

  /// If the port is part of a USB device, an unsigned short integer that identifies a USB device vendor, otherwise `null`.
  external int? get usbVendorId;
  external set usbVendorId(int? v);

  /// If the port is part of a USB device, an unsigned short integer that identiffies a USB device, otherwise `null`.
  external int? get usbProductId;
  external set usbProductId(int? v);
}
