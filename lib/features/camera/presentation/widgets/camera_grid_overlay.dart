import 'package:flutter/material.dart';

/// Rule-of-thirds alignment grid overlay for camera viewfinder.
class CameraGridOverlay extends StatelessWidget {
  const CameraGridOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _GridPainter(),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 1.0;

    // Two vertical lines
    final double colWidth = size.width / 3;
    canvas.drawLine(Offset(colWidth, 0), Offset(colWidth, size.height), paint);
    canvas.drawLine(
      Offset(colWidth * 2, 0),
      Offset(colWidth * 2, size.height),
      paint,
    );

    // Two horizontal lines
    final double rowHeight = size.height / 3;
    canvas.drawLine(Offset(0, rowHeight), Offset(size.width, rowHeight), paint);
    canvas.drawLine(
      Offset(0, rowHeight * 2),
      Offset(size.width, rowHeight * 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

