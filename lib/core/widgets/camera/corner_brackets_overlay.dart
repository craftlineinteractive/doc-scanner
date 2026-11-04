import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Camera viewfinder framing overlay featuring 4 stylized corner brackets for QR and document detection.
class CornerBracketsOverlay extends StatelessWidget {
  const CornerBracketsOverlay({
    super.key,
    this.bracketColor = AppColors.cameraAccent,
    this.strokeWidth = 3.5,
    this.bracketLength = 28.0,
    this.aspectRatio = 1.0,
    this.padding = 32.0,
  });

  final Color bracketColor;
  final double strokeWidth;
  final double bracketLength;
  final double aspectRatio;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Center(
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: CustomPaint(
            painter: _CornerBracketsPainter(
              color: bracketColor,
              strokeWidth: strokeWidth,
              length: bracketLength,
            ),
          ),
        ),
      ),
    );
  }
}

class _CornerBracketsPainter extends CustomPainter {
  const _CornerBracketsPainter({
    required this.color,
    required this.strokeWidth,
    required this.length,
  });

  final Color color;
  final double strokeWidth;
  final double length;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double w = size.width;
    final double h = size.height;

    // Top Left
    canvas.drawLine(const Offset(0, 0), Offset(length, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(0, length), paint);

    // Top Right
    canvas.drawLine(Offset(w, 0), Offset(w - length, 0), paint);
    canvas.drawLine(Offset(w, 0), Offset(w, length), paint);

    // Bottom Left
    canvas.drawLine(Offset(0, h), Offset(length, h), paint);
    canvas.drawLine(Offset(0, h), Offset(0, h - length), paint);

    // Bottom Right
    canvas.drawLine(Offset(w, h), Offset(w - length, h), paint);
    canvas.drawLine(Offset(w, h), Offset(w, h - length), paint);
  }

  @override
  bool shouldRepaint(covariant _CornerBracketsPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.length != length;
}

