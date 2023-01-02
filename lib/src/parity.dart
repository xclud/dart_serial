part of serial;

/// The parity mode.
enum Parity {
  none,
  even,
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
