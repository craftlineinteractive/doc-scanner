import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../mock/mock_document_page.dart';

/// Circular loupe displaying a magnified preview of corner document edges during boundary drags.
class CropMagnifier extends StatelessWidget {
  const CropMagnifier({
    super.key,
    this.size = 88.0,
    this.strokeColor = AppColors.cameraAccent,
  });

  final double size;
  final Color strokeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.cameraSheet,
        border: Border.all(color: strokeColor, width: 3),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x66000000),
            offset: Offset(0, 8),
            blurRadius: 16,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Scaled document corner simulation
          Transform.scale(
            scale: 2.2,
            alignment: Alignment.topLeft,
            child: const MockDocumentPage(
              variant: MockDocumentVariant.invoice,
              showBorder: false,
            ),
          ),

          // Hairline crosshairs
          CustomPaint(
            painter: _CrosshairsPainter(color: strokeColor),
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
    final Paint paint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeWidth = 1.0;

    final double cx = size.width / 2;
    final double cy = size.height / 2;

    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), paint);
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), paint);
    canvas.drawCircle(
      Offset(cx, cy),
      3.0,
      Paint()..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant _CrosshairsPainter oldDelegate) => false;
}

