part of '../serial.dart';

/// Data bits.
enum DataBits {
  /// Seven.
  seven,

  ///Eight.
  eight,
}

int _getDataBits(DataBits dataBits) {
  switch (dataBits) {
    case DataBits.seven:
      return 7;
    case DataBits.eight:
      return 8;
  }
}
