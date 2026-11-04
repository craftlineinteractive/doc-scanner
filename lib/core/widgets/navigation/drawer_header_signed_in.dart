import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Navigation drawer header for authenticated users with Google Drive sync indicators.
class DrawerHeaderSignedIn extends StatelessWidget {
  const DrawerHeaderSignedIn({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.backupSize = '589 MB',
    this.isSynced = true,
    this.onTap,
  });

  final String name;
  final String email;
  final String? avatarUrl;
  final String backupSize;
  final bool isSynced;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Container(
      decoration: BoxDecoration(
        color: docColors.primaryTint,
        borderRadius: AppRadii.headerBottomRadius,
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              // Avatar with online status
              Stack(
                children: <Widget>[
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: avatarUrl != null
                        ? Image.network(
                            avatarUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Symbols.person_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                          )
                        : const Icon(
                            Symbols.person_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: docColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: AppTypography.headlineSm.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      email,
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.textMuted,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Symbols.add_to_drive_rounded,
                          color: AppColors.primary,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Google Drive',
                          style: AppTypography.labelSm.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Divider
          Container(
            height: 1,
            color: AppColors.primary.withValues(alpha: 0.12),
          ),
          const SizedBox(height: 10),
          // Backup size text and Synced chip
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${AppStrings.backupSizePrefix}$backupSize',
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 12,
                ),
              ),
              if (isSynced)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: docColors.successTint,
                    borderRadius: AppRadii.roundedPill,
                    border: Border.all(
                      color: docColors.success.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    AppStrings.synced,
                    style: AppTypography.labelSm.copyWith(
                      color: docColors.success,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
