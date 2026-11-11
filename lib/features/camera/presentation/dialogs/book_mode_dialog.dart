import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../application/book_scan_type.dart';

/// Modal dialog allowing the user to configure Book scanning mode.
class BookModeDialog extends StatelessWidget {
  const BookModeDialog({
    super.key,
    required this.currentType,
    required this.onSelected,
  });

  final BookScanType currentType;
  final ValueChanged<BookScanType> onSelected;

  static Future<BookScanType?> show(
    BuildContext context, {
    required BookScanType currentType,
    required ValueChanged<BookScanType> onSelected,
  }) {
    return showDialog<BookScanType>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (context) =>
          BookModeDialog(currentType: currentType, onSelected: onSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: 340,
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header with Close (X)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Scan Book',
                  style: AppTypography.headlineSm.copyWith(
                    color: const Color(0xFF1E2340),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(Symbols.close_rounded),
                  color: const Color(0xFF8A90A6),
                  iconSize: 22,
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // 3 Stacked Options
            ...BookScanType.values.map(
              (type) => _buildOptionRow(context, type: type),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionRow(BuildContext context, {required BookScanType type}) {
    final isSelected = type == currentType;
    final borderColor = isSelected
        ? AppColors.primary
        : const Color(0xFFE5E7EB);
    final bgColor = isSelected
        ? const Color(0xFFEEF0FF).withValues(alpha: 0.3)
        : Colors.white;

    final IconData icon;
    switch (type) {
      case BookScanType.singlePage:
        icon = Symbols.menu_book_rounded;
        break;
      case BookScanType.twoPages:
        icon = Symbols.auto_stories_rounded;
        break;
      case BookScanType.flattenCurved:
        icon = Symbols.crop_free_rounded;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {
          onSelected(type);
          Navigator.of(context).pop(type);
        },
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: borderColor,
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          child: Row(
            children: <Widget>[
              // Icon container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary
                      : const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: isSelected ? Colors.white : AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.md),

              // Title and Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      type.title,
                      style: AppTypography.labelSm.copyWith(
                        color: const Color(0xFF1E2340),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      type.subtitle,
                      style: AppTypography.labelSm.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : const Color(0xFF8A90A6),
                        fontWeight: isSelected
                            ? FontWeight.w500
                            : FontWeight.w400,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              // Trailing indicator
              if (isSelected)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                )
              else
                const Icon(
                  Symbols.chevron_right_rounded,
                  size: 18,
                  color: Color(0xFFD1D5DB),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
