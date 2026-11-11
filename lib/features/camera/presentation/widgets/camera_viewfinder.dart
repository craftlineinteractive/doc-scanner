import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/camera/corner_brackets_overlay.dart';
import '../../../../core/widgets/camera/scan_line.dart';
import '../../../../core/widgets/mock/mock_camera_background.dart';
import '../../application/book_scan_type.dart';
import '../../application/camera_mode.dart';
import '../../application/id_scan_sides.dart';
import 'camera_grid_overlay.dart';
import 'spirit_level_widget.dart';

/// Interactive viewfinder layer combining mode mock backgrounds, overlays, and guidance pills.
class CameraViewfinder extends StatelessWidget {
  const CameraViewfinder({
    super.key,
    required this.mode,
    required this.gridEnabled,
    required this.spiritLevel,
    required this.bookScanType,
    required this.idScanSides,
    required this.idCardFlipped,
  });

  final CameraMode mode;
  final bool gridEnabled;
  final bool spiritLevel;
  final BookScanType bookScanType;
  final IdScanSides idScanSides;
  final bool idCardFlipped;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // 1. Mock viewfinder subject
        MockCameraBackground(mode: mode, bookScanType: bookScanType),

        // 2. Alignment grid
        if (gridEnabled) const CameraGridOverlay(),

        // 3. Spirit level
        if (spiritLevel && mode != CameraMode.qrScanner)
          const SpiritLevelWidget(),

        // 4. Overlays per mode
        _buildModeOverlay(context),
      ],
    );
  }

  Widget _buildModeOverlay(BuildContext context) {
    switch (mode) {
      case CameraMode.document:
      case CameraMode.photo:
      case CameraMode.ocrText:
        return _buildDocumentOverlay(context);
      case CameraMode.idCard:
        return _buildIdCardOverlay(context);
      case CameraMode.book:
        return _buildBookOverlay(context);
      case CameraMode.signature:
        return _buildSignatureOverlay(context);
      case CameraMode.qrScanner:
        return _buildQrOverlay(context);
    }
  }

  Widget _buildDocumentOverlay(BuildContext context) {
    final disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    final outlineWidget = Container(
      width: 270,
      height: 380,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cameraDetection, width: 2.2),
        borderRadius: BorderRadius.circular(4),
      ),
    );

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          if (disableAnimations)
            outlineWidget
          else
            outlineWidget
                .animate()
                .scale(
                  begin: const Offset(1.05, 1.05),
                  end: const Offset(1.0, 1.0),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                )
                .fadeIn(),
          Positioned(
            bottom: 30,
            child: _buildHintPill(
              context,
              'Hold steady • Detecting document edges',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdCardOverlay(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 292,
            height: 188,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.cameraAccent, width: 2.5),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          Positioned(
            bottom: 40,
            child: _buildHintPill(
              context,
              idCardFlipped
                  ? 'Now flip to the BACK side'
                  : 'Place ID Card within the frame',
              isHighlighted: idCardFlipped,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookOverlay(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 320,
            height: 230,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.cameraAccent.withValues(alpha: 0.7),
                width: 1.8,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          if (bookScanType == BookScanType.twoPages)
            Container(height: 230, width: 2, color: AppColors.cameraAccent),
          Positioned(
            bottom: 35,
            child: _buildHintPill(
              context,
              bookScanType == BookScanType.twoPages
                  ? 'Two pages auto-split active'
                  : 'Align book pages inside frame',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureOverlay(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 60,
            child: _buildHintPill(
              context,
              'Optimal lighting detected • High contrast',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrOverlay(BuildContext context) {
    final disableAnimations =
        MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 240,
            height: 240,
            child: Stack(
              children: <Widget>[
                const CornerBracketsOverlay(
                  bracketColor: AppColors.cameraAccent,
                  strokeWidth: 4,
                  bracketLength: 32,
                  padding: 0,
                ),
                if (!disableAnimations)
                  Positioned(
                    top: 0,
                    left: 4,
                    right: 4,
                    child: ScanLine(
                      travelDistance: 236,
                      color: AppColors.cameraAccent,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Align QR code within the frame',
            style: AppTypography.labelMd.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Automatic scanning enabled',
            style: AppTypography.bodySm.copyWith(
              color: Colors.white.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHintPill(
    BuildContext context,
    String text, {
    bool isHighlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.cameraAccent
            : Colors.black.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHighlighted
              ? Colors.white
              : Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: AppTypography.labelSm.copyWith(
          color: Colors.white,
          fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }
}
