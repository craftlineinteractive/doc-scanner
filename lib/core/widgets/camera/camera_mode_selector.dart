import 'package:flutter/material.dart';
import '../../constants/app_durations.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Supported camera capture modes according to mockup designs.
enum CameraMode {
  idCard('ID Card'),
  document('Document'),
  book('Book'),
  photo('Photo'),
  signature('Signature'),
  qrScanner('QR Scanner'),
  ocrText('OCR Text');

  const CameraMode(this.label);
  final String label;
}

/// Horizontal mode selector strip positioned immediately above the camera capture controls.
class CameraModeSelector extends StatelessWidget {
  const CameraModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
    this.modes = CameraMode.values,
  });

  final CameraMode selectedMode;
  final ValueChanged<CameraMode> onModeSelected;
  final List<CameraMode> modes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: modes.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: AppSpacing.sm),
        itemBuilder: (BuildContext context, int index) {
          final CameraMode mode = modes[index];
          final bool isSelected = mode == selectedMode;

          return GestureDetector(
            onTap: () => onModeSelected(mode),
            child: AnimatedContainer(
              duration: AppDurations.fast,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.cameraAccent
                    : Colors.white.withValues(alpha: 0.1),
                borderRadius: AppRadii.roundedPill,
              ),
              alignment: Alignment.center,
              child: Text(
                mode.label,
                style: AppTypography.labelSm.copyWith(
                  color: isSelected ? Colors.white : const Color(0xFF9AA0B4),
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

