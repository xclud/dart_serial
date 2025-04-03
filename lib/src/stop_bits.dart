part of '../serial.dart';

/// Stop bits.
enum StopBits {
  /// One.
  one,

  /// Two.
  two,
}

int _getStopBits(StopBits sb) {
  switch (sb) {
    case StopBits.one:
      return 1;
    case StopBits.two:
      return 2;
  }
}
