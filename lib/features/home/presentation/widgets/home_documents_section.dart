import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/scan_document.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/doc_colors.dart';
import '../../../../core/widgets/cards/document_grid_card.dart';
import '../../../../core/widgets/cards/document_list_card.dart';
import '../../../../core/widgets/chips/count_badge.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/mock/mock_document_page.dart';
import '../../application/home_providers.dart';

/// Documents section displaying document collection in list or grid layout.
class HomeDocumentsSection extends StatelessWidget {
  const HomeDocumentsSection({
    super.key,
    required this.documents,
    required this.viewMode,
  });

  final List<ScanDocument> documents;
  final HomeViewMode viewMode;

  @override
  Widget build(BuildContext context) {
    if (documents.isEmpty) return const SizedBox.shrink();

    final DocColors docColors = context.docColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  AppStrings.documents,
                  style: AppTypography.headlineSm.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                CountBadge(count: documents.length),
              ],
            ),
            // Date sort chip
            Material(
              color: Theme.of(context).cardTheme.color,
              shape: RoundedRectangleBorder(
                borderRadius: AppRadii.roundedPill,
                side: BorderSide(color: docColors.hairline),
              ),
              child: InkWell(
                onTap: () => showAppSnackbar(
                  context: context,
                  message: 'Sort options are coming later',
                ),
                borderRadius: AppRadii.roundedPill,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        AppStrings.dateSort,
                        style: AppTypography.labelSm.copyWith(
                          color: AppColors.textMuted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Symbols.expand_more_rounded,
                        size: 16,
                        color: AppColors.textMuted,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Collection representation
        if (viewMode == HomeViewMode.list)
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: documents.length,
            separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (BuildContext context, int index) {
              final ScanDocument doc = documents[index];
              return DocumentListCard(
                title: doc.title,
                dateText: doc.relativeDateText(),
                pageCount: doc.pageCount,
                isFavorite: doc.isFavorite,
                isLocked: doc.isLocked,
                isSynced: doc.isSynced,
                thumbnail: MockDocumentPage(
                  variant: doc.thumbnailVariant,
                  showPdfBadge: true,
                ),
                onTap: () =>
                    context.push('${AppRoutes.pageManager}?id=${doc.id}'),
                onMoreTap: () => showAppSnackbar(
                  context: context,
                  message: 'Document options are coming later',
                ),
              );
            },
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: documents.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.sm,
              mainAxisSpacing: AppSpacing.sm,
              childAspectRatio: 0.85,
            ),
            itemBuilder: (BuildContext context, int index) {
              final ScanDocument doc = documents[index];
              return DocumentGridCard(
                title: doc.title,
                dateText: doc.relativeDateText(),
                pageCount: doc.pageCount,
                variant: doc.thumbnailVariant,
                thumbnail: MockDocumentPage(
                  variant: doc.thumbnailVariant,
                  showPdfBadge: true,
                ),
                onTap: () =>
                    context.push('${AppRoutes.pageManager}?id=${doc.id}'),
                onMoreTap: () => showAppSnackbar(
                  context: context,
                  message: 'Document options are coming later',
                ),
              );
            },
          ),
      ],
    );
  }
}
