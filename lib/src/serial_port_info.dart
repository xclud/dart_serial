part of '../serial.dart';

/// Provides information about the [SerialPort].
@JS()
extension type SerialPortInfo._(JSObject _) {
  /// If the port is part of a USB device, an unsigned short [int] that identifies a USB device vendor, otherwise `null`.
  external int? get usbVendorId;

  /// If the port is part of a USB device, an unsigned short [int] that identiffies a USB device, otherwise `null`.
  external int? get usbProductId;

  /// If the port is a Bluetooth RFCOMM service, this property is an unsigned long [int] or [String] representing the device's Bluetooth service class ID. If not, it is `null`.
  external Object? get bluetoothServiceClassId;
}
