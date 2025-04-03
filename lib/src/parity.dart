part of '../serial.dart';

/// The parity mode.
enum Parity {
  /// None.
  none,

  /// Even.
  even,

  /// Odd.
  odd,
}

String _getParityString(Parity parity) {
  switch (parity) {
    case Parity.none:
      return 'none';
    case Parity.even:
      return 'even';
    case Parity.odd:
      return 'odd';
  }
}
