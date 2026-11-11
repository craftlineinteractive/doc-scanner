/// Supported resolution quality presets for scanned documents.
enum ScanQuality {
  standard('Standard', 'Fastest'),
  high('High', 'Recommended'),
  max('Max', 'Largest files');

  const ScanQuality(this.label, this.hint);

  /// Human-readable name.
  final String label;

  /// Explanatory subtext.
  final String hint;
}

/// Immutable snapshot of camera configuration settings.
class CameraSettings {
  const CameraSettings({
    this.captureSound = true,
    this.focusSound = true,
    this.autoCrop = true,
    this.colorFilter = 'Vivid Light',
    this.imageRotation = 'Auto',
    this.spiritLevel = true,
    this.scanQuality = ScanQuality.high,
    this.autoCaptureSeconds = 2,
    this.gridEnabled = false,
  });

  final bool captureSound;
  final bool focusSound;
  final bool autoCrop;
  final String colorFilter;
  final String imageRotation;
  final bool spiritLevel;
  final ScanQuality scanQuality;
  final int autoCaptureSeconds;
  final bool gridEnabled;

  CameraSettings copyWith({
    bool? captureSound,
    bool? focusSound,
    bool? autoCrop,
    String? colorFilter,
    String? imageRotation,
    bool? spiritLevel,
    ScanQuality? scanQuality,
    int? autoCaptureSeconds,
    bool? gridEnabled,
  }) {
    return CameraSettings(
      captureSound: captureSound ?? this.captureSound,
      focusSound: focusSound ?? this.focusSound,
      autoCrop: autoCrop ?? this.autoCrop,
      colorFilter: colorFilter ?? this.colorFilter,
      imageRotation: imageRotation ?? this.imageRotation,
      spiritLevel: spiritLevel ?? this.spiritLevel,
      scanQuality: scanQuality ?? this.scanQuality,
      autoCaptureSeconds: autoCaptureSeconds ?? this.autoCaptureSeconds,
      gridEnabled: gridEnabled ?? this.gridEnabled,
    );
  }
}
