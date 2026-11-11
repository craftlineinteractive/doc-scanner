import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../../features/camera/application/book_scan_type.dart';
import '../../../features/camera/application/camera_mode.dart';
import 'mock_document_page.dart';

/// Dark gradient background simulating a desk surface with a captured subject inside the camera viewfinder.
class MockCameraBackground extends StatelessWidget {
  const MockCameraBackground({
    super.key,
    this.mode = CameraMode.document,
    this.bookScanType = BookScanType.twoPages,
    this.variant = MockDocumentVariant.invoice,
    this.documentScale = 0.75,
  });

  final CameraMode mode;
  final BookScanType bookScanType;
  final MockDocumentVariant variant;
  final double documentScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cameraBackground,
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: <Color>[
            Color(0xFF1E1610), // Warm desk glow from mockups
            AppColors.cameraBackground,
          ],
        ),
      ),
      child: Center(
        child: _buildSubject(context),
      ),
    );
  }

  Widget _buildSubject(BuildContext context) {
    switch (mode) {
      case CameraMode.document:
      case CameraMode.photo:
      case CameraMode.ocrText:
        return _buildPaperPage();
      case CameraMode.idCard:
        return _buildIdCard();
      case CameraMode.book:
        return _buildBook();
      case CameraMode.signature:
        return _buildSignaturePaper();
      case CameraMode.qrScanner:
        return _buildQrTarget();
    }
  }

  Widget _buildPaperPage() {
    return FractionallySizedBox(
      widthFactor: documentScale,
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color(0x66000000),
              offset: Offset(0, 12),
              blurRadius: 24,
              spreadRadius: 4,
            ),
          ],
          borderRadius: AppRadii.roundedSm,
        ),
        child: MockDocumentPage(
          variant: variant,
          showBorder: false,
        ),
      ),
    );
  }

  Widget _buildIdCard() {
    return Container(
      width: 280,
      height: 176,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x77000000),
            offset: Offset(0, 14),
            blurRadius: 28,
            spreadRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: <Widget>[
          Container(
            width: 72,
            height: 96,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Symbols.person_rounded,
              size: 40,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 70,
                  height: 8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF94A3B8),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 110,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 85,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCBD5E1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBook() {
    return Container(
      width: 310,
      height: 220,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x77000000),
            offset: Offset(0, 14),
            blurRadius: 28,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  7,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    height: 5,
                    width: i == 0 ? 60 : (i % 2 == 0 ? 100 : 80),
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 2,
            color: Colors.grey.shade400,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  7,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    height: 5,
                    width: i % 2 == 0 ? 95 : 75,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignaturePaper() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      height: 210,
      decoration: BoxDecoration(
        color: const Color(0xFFFAFBFD),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cameraAccent.withValues(alpha: 0.4),
          width: 1.8,
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x66000000),
            offset: Offset(0, 16),
            blurRadius: 32,
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text(
                  'SIGNATURE PAPER',
                  style: AppTypography.labelSm.copyWith(
                    color: const Color(0xFF8A90A6),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Auto Crop',
                  style: AppTypography.labelSm.copyWith(
                    color: AppColors.cameraAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          CustomPaint(
            size: const Size(220, 70),
            painter: _SignaturePainter(),
          ),
          Text(
            'Place signature inside box',
            style: AppTypography.bodySm.copyWith(
              color: const Color(0xFF8A90A6),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrTarget() {
    return Container(
      width: 240,
      height: 240,
      alignment: Alignment.center,
      child: Icon(
        Symbols.qr_code_2_rounded,
        size: 140,
        color: Colors.white.withValues(alpha: 0.18),
      ),
    );
  }
}

class _SignaturePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E2340)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(20, 45)
      ..cubicTo(35, 15, 45, 10, 55, 35)
      ..cubicTo(65, 60, 80, 30, 100, 20)
      ..cubicTo(115, 12, 130, 45, 140, 40)
      ..cubicTo(155, 32, 165, 22, 180, 28)
      ..cubicTo(195, 32, 170, 60, 210, 52);

    canvas.drawPath(path, paint);

    final linePaint = Paint()
      ..color = const Color(0xFFCBD5E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawLine(const Offset(40, 58), const Offset(190, 58), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
