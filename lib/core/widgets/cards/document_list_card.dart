import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';
import '../buttons/icon_circle_button.dart';
import '../mock/mock_document_page.dart';

/// Primary list card representing a scanned document with thumbnail, metadata, and quick actions.
class DocumentListCard extends StatelessWidget {
  const DocumentListCard({
    super.key,
    required this.title,
    required this.dateText,
    required this.pageCount,
    this.thumbnail,
    this.onTap,
    this.onMoreTap,
    this.isFavorite = false,
    this.isLocked = false,
    this.isSynced = false,
    this.documentVariant = MockDocumentVariant.invoice,
  });

  final String title;
  final String dateText;
  final int pageCount;
  final Widget? thumbnail;
  final VoidCallback? onTap;
  final VoidCallback? onMoreTap;
  final bool isFavorite;
  final bool isLocked;
  final bool isSynced;
  final MockDocumentVariant documentVariant;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: AppRadii.roundedCard,
        border: Border.all(color: docColors.hairline),
        boxShadow: AppShadows.level1,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: AppRadii.roundedCard,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: <Widget>[
                // Document thumbnail
                SizedBox(
                  width: 44,
                  height: 56,
                  child: thumbnail ??
                      MockDocumentPage(
                        variant: documentVariant,
                        showBorder: true,
                      ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Title & metadata details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        title,
                        style: AppTypography.headlineSm.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: docColors.primaryTint,
                              borderRadius: AppRadii.roundedPill,
                            ),
                            child: Text(
                              '$pageCount ${pageCount == 1 ? 'page' : 'pages'}',
                              style: AppTypography.labelSm.copyWith(
                                color: AppColors.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            '· $dateText',
                            style: AppTypography.bodySm.copyWith(
                              color: AppColors.textMuted,
                              fontSize: 12,
                            ),
                          ),
                          if (isFavorite) ...<Widget>[
                            const SizedBox(width: 4),
                            Icon(
                              Symbols.star_rounded,
                              size: 14,
                              color: docColors.gold,
                            ),
                          ],
                          if (isLocked) ...<Widget>[
                            const SizedBox(width: 4),
                            const Icon(
                              Symbols.lock_rounded,
                              size: 14,
                              color: AppColors.textMuted,
                            ),
                          ],
                          if (isSynced) ...<Widget>[
                            const SizedBox(width: 4),
                            Icon(
                              Symbols.cloud_done_rounded,
                              size: 14,
                              color: docColors.success,
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Trailing context action
                if (onMoreTap != null)
                  IconCircleButton(
                    icon: const Icon(Symbols.more_vert_rounded),
                    iconColor: AppColors.textMuted,
                    onPressed: onMoreTap,
                    size: 40,
                    tooltip: 'Options',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

