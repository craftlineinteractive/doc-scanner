/// Supported camera flash states.
enum FlashMode {
  off('Off', 'Off'),
  on('On', 'On'),
  auto('Auto', 'A');

  const FlashMode(this.label, this.badge);

  /// Long label e.g. "Off", "On", "Auto".
  final String label;

  /// Short symbol/letter for the top bar badge e.g. "Off", "On", "A".
  final String badge;
}

