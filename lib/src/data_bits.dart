part of serial;

/// Data bits.
enum DataBits {
  seven,
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
