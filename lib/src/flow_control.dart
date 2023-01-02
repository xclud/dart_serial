part of serial;

/// The flow control type, either "none" or "hardware". The default value is "none".
enum FlowControl {
  none,
  hardware,
}

String _getFlowControlString(FlowControl fc) {
  switch (fc) {
    case FlowControl.none:
      return 'none';
    case FlowControl.hardware:
      return 'hardware';
  }
}
