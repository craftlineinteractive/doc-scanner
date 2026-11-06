import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/mock/mock_document_page.dart';
import '../../domain/viewer_page.dart';

/// 2-column grid card displaying document page thumbnail with badge, caption, and filter label.
class PageManagerGridCard extends StatelessWidget {
  const PageManagerGridCard({
    super.key,
    required this.page,
    required this.pageNumber,
    required this.onTap,
    required this.onMoreTap,
  });

  final ViewerPage page;
  final int pageNumber;
  final VoidCallback onTap;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    IconData filterIcon = Symbols.auto_fix_high_rounded;
    Color filterColor = AppColors.primary;

    if (page.filterLabel == 'Original') {
      filterIcon = Symbols.contrast_rounded;
      filterColor = AppColors.textMuted;
    } else if (page.filterLabel == 'Vivid Light') {
      filterIcon = Symbols.filter_vintage_rounded;
      filterColor = AppColors.textMuted;
    }

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      elevation: 1,
      shadowColor: Colors.black12,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Thumbnail Container
              Expanded(
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: AppColors.canvas,
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: RotatedBox(
                          quarterTurns: page.rotationQuarterTurns,
                          child: ColorFiltered(
                            colorFilter: page.filter.colorFilter ??
                                const ColorFilter.mode(
                                  Colors.transparent,
                                  BlendMode.dst,
                                ),
                            child: MockDocumentPage(
                              variant: page.variant,
                              aspectRatio: 0.707,
                              showBorder: false,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Top Right Badges (Page Number & More)
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.textPrimary.withValues(alpha: 0.8),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '$pageNumber',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: onMoreTap,
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.9),
                                shape: BoxShape.circle,
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Symbols.more_vert_rounded,
                                  size: 14,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Caption Area
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Page $pageNumber',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: <Widget>[
                            Icon(filterIcon, size: 12, color: filterColor),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                page.filterLabel,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: filterColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Symbols.drag_indicator_rounded,
                    size: 18,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

