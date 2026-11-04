import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';
import '../mock/mock_document_page.dart';

/// Multi-page manager document tile with page number indicator and applied filter tag.
class PageThumbnailCard extends StatelessWidget {
  const PageThumbnailCard({
    super.key,
    required this.pageNumber,
    this.filterLabel,
    this.isSelected = false,
    this.isSelectionMode = false,
    this.onTap,
    this.thumbnail,
    this.variant = MockDocumentVariant.invoice,
  });

  final int pageNumber;
  final String? filterLabel;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback? onTap;
  final Widget? thumbnail;
  final MockDocumentVariant variant;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.707,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: AppRadii.roundedInput,
                border: Border.all(
                  color: isSelected ? AppColors.primary : docColors.hairline,
                  width: isSelected ? 2.0 : 1.0,
                ),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(15, 23, 42, 0.04),
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  thumbnail ??
                      MockDocumentPage(
                        variant: variant,
                        showBorder: false,
                      ),

                  // Page index badge top-left
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xCC0F1220),
                        borderRadius: AppRadii.roundedPill,
                      ),
                      child: Text(
                        '$pageNumber',
                        style: AppTypography.labelSm.copyWith(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  // Selection checkbox top-right
                  if (isSelectionMode)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColors.primary
                              : Colors.white.withValues(alpha: 0.8),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textMuted,
                            width: 1.5,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: isSelected
                            ? const Icon(
                                Symbols.check_rounded,
                                color: Colors.white,
                                size: 14,
                              )
                            : null,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (filterLabel != null) ...<Widget>[
            const SizedBox(height: AppSpacing.xs),
            Text(
              filterLabel!,
              style: AppTypography.bodySm.copyWith(
                color: AppColors.textMuted,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}

