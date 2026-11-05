import 'package:flutter/material.dart';

/// Preset scanning filter with display labels and simulated ColorFilter matrices.
enum ScanFilter {
  original,
  autoEnhance,
  vividLight,
  grayscale,
  blackAndWhite;

  String get label {
    switch (this) {
      case ScanFilter.original:
        return 'Original';
      case ScanFilter.autoEnhance:
        return 'Auto Enhance';
      case ScanFilter.vividLight:
        return 'Vivid Light';
      case ScanFilter.grayscale:
        return 'Grayscale';
      case ScanFilter.blackAndWhite:
        return 'B&W';
    }
  }

  String get fullLabel {
    switch (this) {
      case ScanFilter.blackAndWhite:
        return 'Black & White';
      default:
        return label;
    }
  }

  /// ColorFilter matrix simulating paper enhancement without raster assets.
  ColorFilter? get colorFilter {
    switch (this) {
      case ScanFilter.original:
        return null;
      case ScanFilter.autoEnhance:
        return const ColorFilter.matrix(<double>[
          1.15, 0,    0,    0, -10,
          0,    1.15, 0,    0, -10,
          0,    0,    1.15, 0, -10,
          0,    0,    0,    1,   0,
        ]);
      case ScanFilter.vividLight:
        return const ColorFilter.matrix(<double>[
          1.25, 0,    0,    0,  5,
          0,    1.25, 0,    0,  5,
          0,    0,    1.30, 0, 10,
          0,    0,    0,    1,  0,
        ]);
      case ScanFilter.grayscale:
        return const ColorFilter.matrix(<double>[
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0.2126, 0.7152, 0.0722, 0, 0,
          0,      0,      0,      1, 0,
        ]);
      case ScanFilter.blackAndWhite:
        return const ColorFilter.matrix(<double>[
          1.5, 1.5, 1.5, 0, -160,
          1.5, 1.5, 1.5, 0, -160,
          1.5, 1.5, 1.5, 0, -160,
          0,   0,   0,   1,    0,
        ]);
    }
  }
}

