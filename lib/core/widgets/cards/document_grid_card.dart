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

/// Grid presentation card displaying a large document thumbnail preview and bottom metadata.
class DocumentGridCard extends StatelessWidget {
  const DocumentGridCard({
    super.key,
    required this.title,
    required this.dateText,
    required this.pageCount,
    this.thumbnail,
    this.onTap,
    this.onMoreTap,
    this.variant = MockDocumentVariant.invoice,
  });

  final String title;
  final String dateText;
  final int pageCount;
  final Widget? thumbnail;
  final VoidCallback? onTap;
  final VoidCallback? onMoreTap;
  final MockDocumentVariant variant;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Preview area
              Expanded(
                child: Container(
                  width: double.infinity,
                  color: docColors.surfaceSubdued,
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Center(
                    child: thumbnail ??
                        MockDocumentPage(
                          variant: variant,
                          showBorder: true,
                        ),
                  ),
                ),
              ),

              // Bottom details
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title,
                            style: AppTypography.labelMd.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '$pageCount pgs · $dateText',
                            style: AppTypography.bodySm.copyWith(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    if (onMoreTap != null)
                      IconCircleButton(
                        icon: const Icon(Symbols.more_vert_rounded),
                        iconColor: AppColors.textMuted,
                        onPressed: onMoreTap,
                        size: 32,
                        tooltip: 'Options',
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

