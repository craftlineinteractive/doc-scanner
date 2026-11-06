import 'dart:ui';

/// Immutable normalized (0.0 to 1.0) quadrilateral document crop points.
class CropQuad {
  const CropQuad({
    required this.topLeft,
    required this.topRight,
    required this.bottomRight,
    required this.bottomLeft,
  });

  final Offset topLeft;
  final Offset topRight;
  final Offset bottomRight;
  final Offset bottomLeft;

  /// Standard inset crop box suitable for const initialization.
  const CropQuad.standard()
      : topLeft = const Offset(0.06, 0.06),
        topRight = const Offset(0.94, 0.06),
        bottomRight = const Offset(0.94, 0.94),
        bottomLeft = const Offset(0.06, 0.94);

  static const double minSize = 0.15;

  factory CropQuad.full() {
    return const CropQuad(
      topLeft: Offset(0.0, 0.0),
      topRight: Offset(1.0, 0.0),
      bottomRight: Offset(1.0, 1.0),
      bottomLeft: Offset(0.0, 1.0),
    );
  }

  factory CropQuad.inset([double margin = 0.06]) {
    final m = margin.clamp(0.02, 0.4);
    return CropQuad(
      topLeft: Offset(m, m),
      topRight: Offset(1.0 - m, m),
      bottomRight: Offset(1.0 - m, 1.0 - m),
      bottomLeft: Offset(m, 1.0 - m),
    );
  }

  /// Preset tilt matching adjust mockup: (62,34), (298,24), (286,326), (50,334) on a 358x360 canvas.
  factory CropQuad.mockAdjust() {
    return const CropQuad(
      topLeft: Offset(0.17, 0.09),
      topRight: Offset(0.83, 0.07),
      bottomRight: Offset(0.80, 0.91),
      bottomLeft: Offset(0.14, 0.93),
    );
  }

  List<Offset> toList() => <Offset>[topLeft, topRight, bottomRight, bottomLeft];

  CropQuad copyWith({
    Offset? topLeft,
    Offset? topRight,
    Offset? bottomRight,
    Offset? bottomLeft,
  }) {
    return CropQuad(
      topLeft: topLeft ?? this.topLeft,
      topRight: topRight ?? this.topRight,
      bottomRight: bottomRight ?? this.bottomRight,
      bottomLeft: bottomLeft ?? this.bottomLeft,
    );
  }

  /// Updates a single corner by index (0: TL, 1: TR, 2: BR, 3: BL).
  CropQuad copyWithCorner(int index, Offset newPos) {
    final clamped = Offset(
      newPos.dx.clamp(0.0, 1.0),
      newPos.dy.clamp(0.0, 1.0),
    );

    switch (index) {
      case 0:
        final dx = clamped.dx.clamp(0.0, topRight.dx - minSize);
        final dy = clamped.dy.clamp(0.0, bottomLeft.dy - minSize);
        return copyWith(topLeft: Offset(dx, dy));
      case 1:
        final dx = clamped.dx.clamp(topLeft.dx + minSize, 1.0);
        final dy = clamped.dy.clamp(0.0, bottomRight.dy - minSize);
        return copyWith(topRight: Offset(dx, dy));
      case 2:
        final dx = clamped.dx.clamp(bottomLeft.dx + minSize, 1.0);
        final dy = clamped.dy.clamp(topRight.dy + minSize, 1.0);
        return copyWith(bottomRight: Offset(dx, dy));
      case 3:
        final dx = clamped.dx.clamp(0.0, bottomRight.dx - minSize);
        final dy = clamped.dy.clamp(topLeft.dy + minSize, 1.0);
        return copyWith(bottomLeft: Offset(dx, dy));
      default:
        return this;
    }
  }

  /// Shifts an edge by index (0: Top, 1: Right, 2: Bottom, 3: Left).
  CropQuad copyWithEdge(int edgeIndex, Offset delta) {
    switch (edgeIndex) {
      case 0: // Top edge
        final newY = (topLeft.dy + delta.dy).clamp(0.0, bottomLeft.dy - minSize);
        return copyWith(
          topLeft: Offset(topLeft.dx, newY),
          topRight: Offset(topRight.dx, newY),
        );
      case 1: // Right edge
        final newX = (topRight.dx + delta.dx).clamp(topLeft.dx + minSize, 1.0);
        return copyWith(
          topRight: Offset(newX, topRight.dy),
          bottomRight: Offset(newX, bottomRight.dy),
        );
      case 2: // Bottom edge
        final newY = (bottomRight.dy + delta.dy).clamp(topRight.dy + minSize, 1.0);
        return copyWith(
          bottomRight: Offset(bottomRight.dx, newY),
          bottomLeft: Offset(bottomLeft.dx, newY),
        );
      case 3: // Left edge
        final newX = (topLeft.dx + delta.dx).clamp(0.0, topRight.dx - minSize);
        return copyWith(
          topLeft: Offset(newX, topLeft.dy),
          bottomLeft: Offset(newX, bottomLeft.dy),
        );
      default:
        return this;
    }
  }

  /// Constructs a centered quadrilateral matching a specific aspect ratio inside 0..1.
  factory CropQuad.fromAspectRatio(double targetRatio) {
    double w = 0.88;
    double h = w / targetRatio;
    if (h > 0.88) {
      h = 0.88;
      w = h * targetRatio;
    }
    final left = (1.0 - w) / 2.0;
    final top = (1.0 - h) / 2.0;
    return CropQuad(
      topLeft: Offset(left, top),
      topRight: Offset(left + w, top),
      bottomRight: Offset(left + w, top + h),
      bottomLeft: Offset(left, top + h),
    );
  }
}

