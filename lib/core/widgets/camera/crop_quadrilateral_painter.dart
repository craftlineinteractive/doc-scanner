import 'package:flutter/material.dart';

/// CustomPainter rendering the translucent boundary fill and interactive control handles for CropOverlay.
class CropQuadrilateralPainter extends CustomPainter {
  const CropQuadrilateralPainter({
    required this.points,
    required this.strokeColor,
    required this.handleColor,
    this.activeIndex,
  });

  final List<Offset> points;
  final Color strokeColor;
  final Color handleColor;
  final int? activeIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = strokeColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..moveTo(points[0].dx, points[0].dy)
      ..lineTo(points[1].dx, points[1].dy)
      ..lineTo(points[2].dx, points[2].dy)
      ..lineTo(points[3].dx, points[3].dy)
      ..close();

    // Translucent mask inside crop boundary
    final Paint fillPaint = Paint()
      ..color = strokeColor.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, linePaint);

    // Draw midpoint edge handles
    for (int i = 0; i < 4; i++) {
      final Offset a = points[i];
      final Offset b = points[(i + 1) % 4];
      final Offset mid = Offset((a.dx + b.dx) / 2, (a.dy + b.dy) / 2);

      canvas.drawCircle(mid, 5.0, Paint()..color = strokeColor);
      canvas.drawCircle(mid, 3.0, Paint()..color = handleColor);
    }

    // Draw 4 corner handles
    for (int i = 0; i < points.length; i++) {
      final Offset p = points[i];
      final bool isActive = i == activeIndex;

      // Outer glow/ring
      canvas.drawCircle(
        p,
        isActive ? 14.0 : 10.0,
        Paint()..color = strokeColor.withValues(alpha: 0.4),
      );
      // Border ring
      canvas.drawCircle(
        p,
        9.0,
        Paint()
          ..color = strokeColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );
      // Solid center dot
      canvas.drawCircle(p, 6.5, Paint()..color = handleColor);
    }
  }

  @override
  bool shouldRepaint(covariant CropQuadrilateralPainter oldDelegate) => true;
}

