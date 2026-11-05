/// Preset document crop aspect ratios.
enum CropShape {
  free,
  original,
  a4,
  letter,
  square;

  String get label {
    switch (this) {
      case CropShape.free:
        return 'Free';
      case CropShape.original:
        return 'Original';
      case CropShape.a4:
        return 'A4';
      case CropShape.letter:
        return 'Letter';
      case CropShape.square:
        return 'Square';
    }
  }

  /// Target aspect ratio (width / height), or null when unconstrained.
  double? get aspectRatio {
    switch (this) {
      case CropShape.free:
      case CropShape.original:
        return null;
      case CropShape.a4:
        return 0.7071; // 1 / sqrt(2)
      case CropShape.letter:
        return 8.5 / 11.0; // ~0.7727
      case CropShape.square:
        return 1.0;
    }
  }
}

