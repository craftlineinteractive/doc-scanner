import 'package:flutter/material.dart';

/// CustomPainter rendering the financial performance line chart from Frame 1 & 3.
class PdfChartPainter extends CustomPainter {
  const PdfChartPainter({required this.lineColor, required this.fillColor});

  final Color lineColor;
  final Color fillColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final double scaleX = size.width / 280.0;
    final double scaleY = size.height / 60.0;

    final Path path = Path();
    path.moveTo(0 * scaleX, 48 * scaleY);
    path.cubicTo(
      40 * scaleX,
      45 * scaleY,
      60 * scaleX,
      30 * scaleY,
      100 * scaleX,
      35 * scaleY,
    );
    path.cubicTo(
      140 * scaleX,
      40 * scaleY,
      160 * scaleX,
      15 * scaleY,
      200 * scaleX,
      20 * scaleY,
    );
    path.cubicTo(
      240 * scaleX,
      25 * scaleY,
      260 * scaleX,
      5 * scaleY,
      280 * scaleX,
      4 * scaleY,
    );

    // Gradient or semi-transparent fill under curve
    final Path fillPath = Path.from(path)
      ..lineTo(280 * scaleX, 60 * scaleY)
      ..lineTo(0, 60 * scaleY)
      ..close();

    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawPath(fillPath, fillPaint);

    final Paint linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, linePaint);

    // Three indicator anchor circles
    final Paint circlePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(100 * scaleX, 35 * scaleY), 3.0, circlePaint);
    canvas.drawCircle(Offset(200 * scaleX, 20 * scaleY), 3.0, circlePaint);
    canvas.drawCircle(Offset(280 * scaleX, 4 * scaleY), 3.5, circlePaint);
  }

  @override
  bool shouldRepaint(covariant PdfChartPainter oldDelegate) {
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.fillColor != fillColor;
  }
}
