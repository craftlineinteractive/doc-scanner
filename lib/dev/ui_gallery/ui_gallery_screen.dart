import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/doc_colors.dart';
import 'gallery_entries.dart';

/// Debug-only gallery listing every screen and modal grouped by numbered mockup folder.
class UiGalleryScreen extends StatelessWidget {
  const UiGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return const Scaffold(
        body: Center(
          child: Text('UI Gallery is only available in debug mode.'),
        ),
      );
    }

    final DocColors docColors = context.docColors;

    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Gallery'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.screenMargin),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: docColors.primaryTint,
                borderRadius: AppRadii.roundedPill,
              ),
              child: Text(
                'DEBUG ONLY',
                style: AppTypography.labelSm.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: AppSpacing.screenListPadding,
        itemCount: kGallerySections.length,
        itemBuilder: (BuildContext context, int sectionIndex) {
          final GallerySection section = kGallerySections[sectionIndex];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: AppSpacing.md,
                  bottom: AppSpacing.sm,
                  left: AppSpacing.xs,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: section.number == '00'
                            ? AppColors.gold
                            : AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        section.number,
                        style: AppTypography.labelSm.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      section.title,
                      style: AppTypography.headlineSm.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Theme.of(context).cardTheme.color,
                shape: RoundedRectangleBorder(
                  borderRadius: AppRadii.roundedCard,
                  side: BorderSide(color: docColors.hairline),
                ),
                clipBehavior: Clip.antiAlias,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: section.items.length,
                  separatorBuilder: (BuildContext context, int i) =>
                      Divider(color: docColors.hairline, height: 1),
                  itemBuilder: (BuildContext context, int itemIndex) {
                    final GalleryEntry item = section.items[itemIndex];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.xs,
                      ),
                      title: Text(
                        item.title,
                        style: AppTypography.labelMd.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Text(
                        item.subtitle,
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (item.badge != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              margin: const EdgeInsets.only(right: 6),
                              decoration: BoxDecoration(
                                color: docColors.primaryTint,
                                borderRadius: AppRadii.roundedPill,
                              ),
                              child: Text(
                                item.badge!,
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          const Icon(
                            Symbols.chevron_right_rounded,
                            size: 20,
                            color: AppColors.textMuted,
                          ),
                        ],
                      ),
                      onTap: () {
                        context.push(item.route);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          );
        },
      ),
    );
  }
}
