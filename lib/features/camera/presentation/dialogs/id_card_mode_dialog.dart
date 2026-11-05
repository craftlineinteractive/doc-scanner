import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../application/id_scan_sides.dart';

/// Modal dialog allowing the user to select between Single Side or Both Sides ID card scan.
class IdCardModeDialog extends StatelessWidget {
  const IdCardModeDialog({
    super.key,
    required this.currentSides,
    required this.onSelected,
  });

  final IdScanSides currentSides;
  final ValueChanged<IdScanSides> onSelected;

  static Future<IdScanSides?> show(
    BuildContext context, {
    required IdScanSides currentSides,
    required ValueChanged<IdScanSides> onSelected,
  }) {
    return showDialog<IdScanSides>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (context) => IdCardModeDialog(
        currentSides: currentSides,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Scan ID Card',
              style: AppTypography.headlineSm.copyWith(
                color: const Color(0xFF1E2340),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Two selectable cards side by side
            Row(
              children: <Widget>[
                Expanded(
                  child: _buildOptionCard(
                    context,
                    sides: IdScanSides.single,
                    isSelected: currentSides == IdScanSides.single,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _buildOptionCard(
                    context,
                    sides: IdScanSides.both,
                    isSelected: currentSides == IdScanSides.both,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Close text button
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: AppTypography.labelMd.copyWith(
                  color: const Color(0xFF8A90A6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required IdScanSides sides,
    required bool isSelected,
  }) {
    final borderColor = isSelected
        ? AppColors.primary
        : const Color(0xFFE5E7EB);
    final bgColor = isSelected
        ? const Color(0xFFEEF0FF).withValues(alpha: 0.6)
        : Colors.white;

    return InkWell(
      onTap: () {
        onSelected(sides);
        Navigator.of(context).pop(sides);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: borderColor,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildIllustration(sides, isSelected),
            const SizedBox(height: 12),
            Text(
              sides.title,
              style: AppTypography.labelSm.copyWith(
                color: const Color(0xFF1E2340),
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              sides.subtitle,
              style: AppTypography.labelSm.copyWith(
                color: const Color(0xFF8A90A6),
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration(IdScanSides sides, bool isSelected) {
    if (sides == IdScanSides.single) {
      return Container(
        width: 56,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFD1D5DB),
            width: 1.5,
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x11000000),
              offset: Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          children: <Widget>[
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Symbols.person_rounded,
                size: 10,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 3,
                    width: 18,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    height: 2,
                    width: 12,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Both sides: overlapping front & back cards
    return SizedBox(
      width: 56,
      height: 38,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 2,
            child: Container(
              width: 44,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: const Color(0xFFD1D5DB),
                  width: 1,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 2,
            child: Container(
              width: 44,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFF9CA3AF),
                  width: 1.2,
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x15000000),
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(3),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 2.5,
                        width: 14,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        height: 2,
                        width: 9,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
