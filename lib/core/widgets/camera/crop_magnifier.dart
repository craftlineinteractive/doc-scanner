import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../mock/mock_document_page.dart';

/// Circular loupe displaying a magnified preview of corner document edges during boundary drags.
class CropMagnifier extends StatelessWidget {
  const CropMagnifier({
    super.key,
    this.size = 96.0,
    this.strokeColor = AppColors.cameraAccent,
    this.borderColor = Colors.white,
    this.zoomText = '2.5×',
  });

  final double size;
  final Color strokeColor;
  final Color borderColor;
  final String zoomText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF171B2F),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x80000000),
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Scaled document corner simulation
          Transform.scale(
            scale: 2.5,
            alignment: Alignment.topRight,
            child: const MockDocumentPage(
              variant: MockDocumentVariant.invoice,
              showBorder: false,
            ),
          ),

          // Hairline crosshairs with center ring
          CustomPaint(
            painter: _CrosshairsPainter(color: strokeColor),
          ),

          // Zoom badge in bottom right
          Positioned(
            bottom: 6,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                zoomText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CrosshairsPainter extends CustomPainter {
  const _CrosshairsPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint hairPaint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeWidth = 1.0;

    final double cx = size.width / 2;
    final double cy = size.height / 2;

    // Crosshair lines
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), hairPaint);
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), hairPaint);

    // Center target circle ring & dot
    final Paint ringPaint = Paint()
      ..color = color.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(cx, cy), 10.0, ringPaint);

    final Paint dotPaint = Paint()..color = color;
    canvas.drawCircle(Offset(cx, cy), 3.0, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _CrosshairsPainter oldDelegate) => false;
}
