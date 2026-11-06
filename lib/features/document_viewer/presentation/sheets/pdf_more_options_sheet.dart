import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';

/// More PDF options bottom sheet matching Frame 5 of Saved Document Viewer suite.
class PdfMoreOptionsSheet extends StatelessWidget {
  const PdfMoreOptionsSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) => const PdfMoreOptionsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.hairline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'More PDF options',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Symbols.close_rounded, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: AppColors.hairline, height: 1),

          _PdfOptionRow(
            icon: Symbols.view_headline_rounded,
            iconBg: AppColors.primaryTint,
            iconColor: AppColors.primary,
            label: 'Header and footer',
            onTap: () {
              Navigator.of(context).pop();
              showAppSnackbar(
                context: context,
                message: 'Custom header and footer configured',
              );
            },
          ),
          _PdfOptionRow(
            icon: Symbols.open_in_new_rounded,
            iconBg: AppColors.canvas,
            iconColor: AppColors.textPrimary,
            label: 'Open with...',
            onTap: () {
              Navigator.of(context).pop();
              showAppSnackbar(
                context: context,
                message: 'Simulating open with default PDF viewer',
              );
            },
          ),
          _PdfOptionRow(
            icon: Symbols.format_color_fill_rounded,
            iconBg: AppColors.canvas,
            iconColor: AppColors.textPrimary,
            label: 'PDF background color',
            onTap: () {
              Navigator.of(context).pop();
              showAppSnackbar(
                context: context,
                message: 'Background color set to Pure White',
              );
            },
          ),
          _PdfOptionRow(
            icon: Symbols.photo_size_select_small_rounded,
            iconBg: AppColors.canvas,
            iconColor: AppColors.textPrimary,
            label: 'Resize',
            onTap: () {
              Navigator.of(context).pop();
              showAppSnackbar(
                context: context,
                message: 'PDF pages resized to A4 Standard',
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PdfOptionRow extends StatelessWidget {
  const _PdfOptionRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(icon, size: 18, color: iconColor),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Symbols.chevron_right_rounded,
              size: 18,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

