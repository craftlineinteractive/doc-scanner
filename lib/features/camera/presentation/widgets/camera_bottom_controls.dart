import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/buttons/shutter_button.dart';
import '../../../../core/widgets/camera/camera_mode_selector.dart';

/// Camera bottom interaction area managing the horizontal mode strip and shutter control row.
class CameraBottomControls extends StatefulWidget {
  const CameraBottomControls({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
    required this.onShutterTap,
    required this.onGalleryTap,
    required this.onOptionsTap,
  });

  final CameraMode selectedMode;
  final ValueChanged<CameraMode> onModeSelected;
  final VoidCallback onShutterTap;
  final VoidCallback onGalleryTap;
  final VoidCallback onOptionsTap;

  @override
  State<CameraBottomControls> createState() => _CameraBottomControlsState();
}

class _CameraBottomControlsState extends State<CameraBottomControls> {
  bool _isAuto = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.8),
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Mode selector strip
            CameraModeSelector(
              selectedMode: widget.selectedMode,
              onModeSelected: widget.onModeSelected,
            ),
            const SizedBox(height: AppSpacing.sm),

            // Controls row
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildLeftAction(),
                    _buildCenterAction(),
                    _buildRightAction(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftAction() {
    if (widget.selectedMode == CameraMode.signature ||
        widget.selectedMode == CameraMode.qrScanner) {
      return _buildRoundIconButton(
        icon: Symbols.photo_library_rounded,
        onTap: widget.onGalleryTap,
        tooltip: 'Gallery',
      );
    }

    // Document / ID Card / Book / Photo / OCR: AUTO / MANUAL toggle chip
    return GestureDetector(
      onTap: () => setState(() => _isAuto = !_isAuto),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: AppRadii.roundedPill,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Symbols.timelapse_rounded,
              size: 16,
              color: AppColors.cameraAccent,
            ),
            const SizedBox(width: 6),
            Text(
              _isAuto ? 'AUTO' : 'MANUAL',
              style: AppTypography.labelSm.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterAction() {
    if (widget.selectedMode == CameraMode.qrScanner) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.12),
          borderRadius: AppRadii.roundedPill,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF34D399), // emerald-400
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Auto Detect',
              style: AppTypography.labelMd.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return ShutterButton(
      size: 72,
      onTap: widget.onShutterTap,
    );
  }

  Widget _buildRightAction() {
    if (widget.selectedMode == CameraMode.signature ||
        widget.selectedMode == CameraMode.qrScanner) {
      return _buildRoundIconButton(
        icon: Symbols.add_rounded,
        onTap: widget.onOptionsTap,
        tooltip: 'More options',
      );
    }

    return _buildRoundIconButton(
      icon: Symbols.photo_library_rounded,
      onTap: widget.onGalleryTap,
      tooltip: 'Gallery',
    );
  }

  Widget _buildRoundIconButton({
    required IconData icon,
    required VoidCallback onTap,
    required String tooltip,
  }) {
    return Material(
      color: Colors.white.withValues(alpha: 0.12),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            icon,
            size: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
