part of serial;

/// Stop bits.
enum StopBits {
  one,
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
