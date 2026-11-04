import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';

/// Preset variants for simulated document mockups.
enum MockDocumentVariant {
  invoice,
  idCard,
  contract,
  receipt,
}

/// Custom-painted vector mock document representing a paper document without raster assets.
class MockDocumentPage extends StatelessWidget {
  const MockDocumentPage({
    super.key,
    this.variant = MockDocumentVariant.invoice,
    this.aspectRatio = 0.707, // Standard ISO A4 ratio (1 / sqrt(2))
    this.backgroundColor = Colors.white,
    this.showBorder = true,
  });

  final MockDocumentVariant variant;
  final double aspectRatio;
  final Color backgroundColor;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: AppRadii.roundedSm,
          border: showBorder
              ? Border.all(color: AppColors.hairline, width: 1)
              : null,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(15, 23, 42, 0.04),
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: CustomPaint(
          painter: _DocumentPagePainter(variant: variant),
        ),
      ),
    );
  }
}

class _DocumentPagePainter extends CustomPainter {
  const _DocumentPagePainter({required this.variant});

  final MockDocumentVariant variant;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = AppColors.hairline
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final Paint accentPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.7)
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final double w = size.width;
    final double h = size.height;

    switch (variant) {
      case MockDocumentVariant.invoice:
        _paintInvoice(canvas, linePaint, accentPaint, w, h);
        break;
      case MockDocumentVariant.idCard:
        _paintIdCard(canvas, linePaint, accentPaint, w, h);
        break;
      case MockDocumentVariant.contract:
        _paintContract(canvas, linePaint, accentPaint, w, h);
        break;
      case MockDocumentVariant.receipt:
        _paintReceipt(canvas, linePaint, accentPaint, w, h);
        break;
    }
  }

  void _paintInvoice(Canvas c, Paint l, Paint a, double w, double h) {
    // Header block
    c.drawLine(Offset(w * 0.1, h * 0.1), Offset(w * 0.45, h * 0.1), a);
    c.drawLine(Offset(w * 0.65, h * 0.1), Offset(w * 0.9, h * 0.1), l);

    // Meta rows
    c.drawLine(Offset(w * 0.1, h * 0.18), Offset(w * 0.5, h * 0.18), l);
    c.drawLine(Offset(w * 0.1, h * 0.23), Offset(w * 0.35, h * 0.23), l);

    // Table header
    c.drawLine(Offset(w * 0.1, h * 0.35), Offset(w * 0.9, h * 0.35), a);
    // Table rows
    for (int i = 0; i < 4; i++) {
      final double y = h * (0.43 + i * 0.08);
      c.drawLine(Offset(w * 0.1, y), Offset(w * 0.6, y), l);
      c.drawLine(Offset(w * 0.75, y), Offset(w * 0.9, y), l);
    }
    // Total block
    c.drawLine(Offset(w * 0.55, h * 0.8), Offset(w * 0.9, h * 0.8), a);
  }

  void _paintIdCard(Canvas c, Paint l, Paint a, double w, double h) {
    // Avatar box
    final Rect avatarRect =
        Rect.fromLTWH(w * 0.1, h * 0.18, w * 0.28, h * 0.35);
    c.drawRRect(
      RRect.fromRectAndRadius(avatarRect, const Radius.circular(4)),
      l,
    );
    // Detail lines
    c.drawLine(Offset(w * 0.45, h * 0.22), Offset(w * 0.88, h * 0.22), a);
    c.drawLine(Offset(w * 0.45, h * 0.30), Offset(w * 0.80, h * 0.30), l);
    c.drawLine(Offset(w * 0.45, h * 0.38), Offset(w * 0.75, h * 0.38), l);
    c.drawLine(Offset(w * 0.45, h * 0.46), Offset(w * 0.65, h * 0.46), l);

    // Barcode / MRZ bottom band
    c.drawLine(Offset(w * 0.1, h * 0.75), Offset(w * 0.9, h * 0.75), l);
    c.drawLine(Offset(w * 0.1, h * 0.82), Offset(w * 0.9, h * 0.82), l);
  }

  void _paintContract(Canvas c, Paint l, Paint a, double w, double h) {
    // Centered title
    c.drawLine(Offset(w * 0.25, h * 0.1), Offset(w * 0.75, h * 0.1), a);

    // Paragraph lines
    for (int i = 0; i < 7; i++) {
      final double y = h * (0.2 + i * 0.06);
      c.drawLine(Offset(w * 0.1, y), Offset(w * 0.9, y), l);
    }
    c.drawLine(Offset(w * 0.1, h * 0.62), Offset(w * 0.6, h * 0.62), l);

    // Signature box
    c.drawLine(Offset(w * 0.1, h * 0.82), Offset(w * 0.45, h * 0.82), a);
    c.drawLine(Offset(w * 0.55, h * 0.82), Offset(w * 0.9, h * 0.82), a);
  }

  void _paintReceipt(Canvas c, Paint l, Paint a, double w, double h) {
    // Top store header
    c.drawLine(Offset(w * 0.3, h * 0.08), Offset(w * 0.7, h * 0.08), a);
    c.drawLine(Offset(w * 0.2, h * 0.14), Offset(w * 0.8, h * 0.14), l);

    // Itemized list
    for (int i = 0; i < 5; i++) {
      final double y = h * (0.26 + i * 0.08);
      c.drawLine(Offset(w * 0.15, y), Offset(w * 0.55, y), l);
      c.drawLine(Offset(w * 0.7, y), Offset(w * 0.85, y), l);
    }
    // Barcode bottom
    c.drawLine(Offset(w * 0.15, h * 0.82), Offset(w * 0.85, h * 0.82), a);
  }

  @override
  bool shouldRepaint(covariant _DocumentPagePainter oldDelegate) =>
      oldDelegate.variant != variant;
}

