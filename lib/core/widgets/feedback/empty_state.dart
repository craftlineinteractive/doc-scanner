import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Clean empty state placeholder built from vector symbols, heading, body,
/// interactive guidance chips, and on-device privacy guarantee.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.title,
    required this.description,
    this.illustration,
    this.primaryIcon = Symbols.document_scanner_rounded,
    this.onCameraHintTap,
    this.onPlusHintTap,
    this.footerText = AppStrings.onDeviceProcessing,
    this.action,
  });

  final String title;
  final String description;
  final Widget? illustration;
  final IconData primaryIcon;
  final VoidCallback? onCameraHintTap;
  final VoidCallback? onPlusHintTap;
  final String? footerText;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.xl,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Vector illustration or custom illustration
            illustration ?? _buildDefaultIllustration(docColors),
            const SizedBox(height: AppSpacing.xl),

            // Title & description
            Text(
              title,
              style: AppTypography.headlineLg.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: Text(
                description,
                style: AppTypography.bodyMd.copyWith(
                  color: AppColors.textMuted,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Hint pills
            _buildHintChip(
              context: context,
              icon: Symbols.photo_camera_rounded,
              iconColor: AppColors.primary,
              iconBg: docColors.primaryTint,
              label: AppStrings.hintCamera,
              onTap: onCameraHintTap,
            ),
            const SizedBox(height: AppSpacing.sm),
            _buildHintChip(
              context: context,
              icon: Symbols.add_photo_alternate_rounded,
              iconColor: docColors.success,
              iconBg: docColors.successTint,
              label: AppStrings.hintPlus,
              onTap: onPlusHintTap,
            ),

            if (action != null) ...<Widget>[
              const SizedBox(height: AppSpacing.xl),
              action!,
            ],

            if (footerText != null) ...<Widget>[
              const SizedBox(height: AppSpacing.xl),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(
                    Symbols.lock_rounded,
                    size: 14,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    footerText!,
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultIllustration(DocColors docColors) {
    return SizedBox(
      width: 176,
      height: 176,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          // Angled back document 2
          Transform.rotate(
            angle: -0.2,
            child: Container(
              width: 96,
              height: 128,
              decoration: BoxDecoration(
                color: docColors.hairline,
                borderRadius: AppRadii.roundedCard,
              ),
            ),
          ),
          // Angled back document 1
          Transform.rotate(
            angle: 0.1,
            child: Container(
              width: 104,
              height: 136,
              decoration: BoxDecoration(
                color: docColors.primaryTint,
                borderRadius: AppRadii.roundedCard,
              ),
            ),
          ),
          // Front hero document
          Container(
            width: 112,
            height: 144,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppRadii.roundedCard,
              boxShadow: AppShadows.level2,
              border: Border.all(color: docColors.hairline),
            ),
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: docColors.primaryTint,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Symbols.description_rounded,
                        color: AppColors.primary,
                        size: 14,
                      ),
                    ),
                    Icon(
                      Symbols.verified_rounded,
                      color: docColors.success,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  width: 56,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.textMuted.withValues(alpha: 0.25),
                    borderRadius: AppRadii.roundedPill,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textMuted.withValues(alpha: 0.15),
                    borderRadius: AppRadii.roundedPill,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 64,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.textMuted.withValues(alpha: 0.15),
                    borderRadius: AppRadii.roundedPill,
                  ),
                ),
                const Spacer(),
                // Animated-style scan line
                Container(
                  width: double.infinity,
                  height: 2,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: AppRadii.roundedPill,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 32,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.textMuted.withValues(alpha: 0.2),
                        borderRadius: AppRadii.roundedPill,
                      ),
                    ),
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: docColors.successTint,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Symbols.check_rounded,
                        color: docColors.success,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Floating sparkle badge
          Positioned(
            top: 4,
            right: 8,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: AppShadows.level2,
              ),
              child: const Icon(
                Symbols.auto_awesome_rounded,
                color: AppColors.primary,
                size: 18,
              ),
            ),
          ),
          // Floating QR scanner badge
          Positioned(
            bottom: 6,
            left: 8,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: AppShadows.level2,
              ),
              child: Icon(
                Symbols.qr_code_scanner_rounded,
                color: docColors.success,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHintChip({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required VoidCallback? onTap,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: Material(
        color: Theme.of(context).cardTheme.color,
        borderRadius: AppRadii.roundedPill,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadii.roundedPill,
          side: BorderSide(color: context.docColors.hairline),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadii.roundedPill,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: <Widget>[
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 16),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    label,
                    style: AppTypography.labelMd.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Symbols.arrow_forward_rounded,
                  color: AppColors.textMuted,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
