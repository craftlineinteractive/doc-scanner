import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';

/// Modal dialog introducing OCR text recognition mode.
class OcrModeDialog extends StatelessWidget {
  const OcrModeDialog({super.key, this.onContinue});

  final VoidCallback? onContinue;

  static Future<void> show(BuildContext context, {VoidCallback? onContinue}) {
    return showDialog<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (context) => OcrModeDialog(onContinue: onContinue),
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
            // Icon & Title & Edge AI chip
            Row(
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEF0FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Symbols.find_in_page_rounded,
                    color: AppColors.primary,
                    size: 26,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'OCR Recognition',
                        style: AppTypography.headlineSm.copyWith(
                          color: const Color(0xFF1E2340),
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFECFDF5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Edge AI Model',
                          style: AppTypography.labelSm.copyWith(
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            // Description
            Text(
              'Convert scans into editable, searchable text',
              style: AppTypography.bodyMd.copyWith(
                color: const Color(0xFF4B5563),
                fontSize: 13,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Tappable Row: OCR Language
            InkWell(
              onTap: () {
                showAppSnackbar(
                  context: context,
                  message: 'Language picker is coming later',
                );
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6FA),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Symbols.translate_rounded,
                        size: 18,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'OCR LANGUAGE',
                            style: AppTypography.labelSm.copyWith(
                              color: const Color(0xFF8A90A6),
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'English',
                            style: AppTypography.labelSm.copyWith(
                              color: const Color(0xFF1E2340),
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Symbols.chevron_right_rounded,
                      size: 20,
                      color: Color(0xFF8A90A6),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Action Buttons: Close & Continue
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Close',
                    style: AppTypography.labelSm.copyWith(
                      color: const Color(0xFF8A90A6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    onContinue?.call();
                  },
                  child: Text(
                    'Continue',
                    style: AppTypography.labelSm.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
