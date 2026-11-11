import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../application/camera_settings.dart';

/// Modal bottom sheet allowing selection of document scan resolution quality.
class ScanQualitySheet extends StatefulWidget {
  const ScanQualitySheet({
    super.key,
    required this.initialQuality,
    required this.onSelected,
  });

  final ScanQuality initialQuality;
  final ValueChanged<ScanQuality> onSelected;

  static Future<ScanQuality?> show(
    BuildContext context, {
    required ScanQuality initialQuality,
    required ValueChanged<ScanQuality> onSelected,
  }) {
    return showModalBottomSheet<ScanQuality>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => ScanQualitySheet(
        initialQuality: initialQuality,
        onSelected: onSelected,
      ),
    );
  }

  @override
  State<ScanQualitySheet> createState() => _ScanQualitySheetState();
}

class _ScanQualitySheetState extends State<ScanQualitySheet> {
  late ScanQuality _selectedQuality;

  @override
  void initState() {
    super.initState();
    _selectedQuality = widget.initialQuality;
  }

  @override
  Widget build(BuildContext context) {
    final sheetColor = Theme.of(context).colorScheme.surface;

    return Container(
      decoration: BoxDecoration(
        color: sheetColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.1), width: 1),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Handle pill
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: AppRadii.roundedPill,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Title
            Text(
              'Scan Quality',
              style: AppTypography.headlineSm.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Quality options
            ...ScanQuality.values.map(_buildOptionRow),
            const SizedBox(height: AppSpacing.lg),

            // Done button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cameraAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  widget.onSelected(_selectedQuality);
                  Navigator.of(context).pop(_selectedQuality);
                },
                child: Text(
                  'Done',
                  style: AppTypography.labelMd.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionRow(ScanQuality quality) {
    final isSelected = quality == _selectedQuality;

    return InkWell(
      onTap: () => setState(() => _selectedQuality = quality),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.cameraAccent.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.cameraAccent.withValues(alpha: 0.4)
                : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  quality.label,
                  style: AppTypography.bodyMd.copyWith(
                    color: Colors.white,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                Text(
                  quality.hint,
                  style: AppTypography.labelSm.copyWith(
                    color: isSelected
                        ? AppColors.cameraAccentLight
                        : Colors.grey.shade400,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.cameraAccent
                      : Colors.grey.shade500,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: isSelected
                  ? Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.cameraAccent,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
