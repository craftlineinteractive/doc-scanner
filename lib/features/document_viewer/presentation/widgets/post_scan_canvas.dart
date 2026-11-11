import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/camera/crop_overlay.dart';
import '../../../../core/widgets/mock/mock_document_page.dart';
import '../../../scan_review/domain/crop_quad.dart';
import '../../domain/viewer_page.dart';
import '../../domain/viewer_tool_tier.dart';

/// Canvas viewing area with PageView, pinch-to-zoom, crop overlay, and mode banners.
class PostScanCanvas extends StatelessWidget {
  const PostScanCanvas({
    super.key,
    required this.pages,
    required this.currentIndex,
    required this.pageController,
    required this.toolTier,
    required this.isOcrActive,
    required this.onPageChanged,
    required this.onCropChanged,
  });

  final List<ViewerPage> pages;
  final int currentIndex;
  final PageController pageController;
  final ViewerToolTier toolTier;
  final bool isOcrActive;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<CropQuad> onCropChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.hairline,
      child: Stack(
        children: <Widget>[
          // Page View with Pinch Zoom
          PageView.builder(
            controller: pageController,
            onPageChanged: onPageChanged,
            itemCount: pages.length,
            itemBuilder: (BuildContext context, int index) {
              final ViewerPage page = pages[index];
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 3.5,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        RotatedBox(
                          quarterTurns: page.rotationQuarterTurns,
                          child: ColorFiltered(
                            colorFilter:
                                page.filter.colorFilter ??
                                const ColorFilter.mode(
                                  Colors.transparent,
                                  BlendMode.dst,
                                ),
                            child: Transform.scale(
                              scaleX: page.isFlipped ? -1 : 1,
                              child: MockDocumentPage(
                                variant: page.variant,
                                aspectRatio: 0.707,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        // OCR text highlight overlay simulation
                        if (isOcrActive)
                          Positioned.fill(
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.4,
                                  ),
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 24,
                                      left: 16,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    color: AppColors.gold.withValues(
                                      alpha: 0.35,
                                    ),
                                    child: const Text(
                                      'GLOBAL LOGISTICS LLC #INV-2026-091',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      top: 8,
                                      left: 16,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                      vertical: 2,
                                    ),
                                    color: AppColors.gold.withValues(
                                      alpha: 0.35,
                                    ),
                                    child: const Text(
                                      'TOTAL DUE \$165.00',
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // Active interactive crop overlay
                        if (toolTier == ViewerToolTier.crop &&
                            index == currentIndex)
                          Positioned.fill(
                            child: CropOverlay(
                              initialTopLeft: page.crop.topLeft,
                              initialTopRight: page.crop.topRight,
                              initialBottomRight: page.crop.bottomRight,
                              initialBottomLeft: page.crop.bottomLeft,
                              onQuadChanged: (tl, tr, br, bl) {
                                onCropChanged(
                                  CropQuad(
                                    topLeft: tl,
                                    topRight: tr,
                                    bottomRight: br,
                                    bottomLeft: bl,
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Editing Mode banner across top of canvas
          if (toolTier == ViewerToolTier.edit)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                color: AppColors.primary,
                child: const Row(
                  children: <Widget>[
                    Icon(Symbols.info_rounded, color: Colors.white, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Editing Mode Enabled • Touch page to position annotation',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Floating "Page X of Y" pill at bottom
          if (toolTier != ViewerToolTier.crop)
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    'Page ${currentIndex + 1} of ${pages.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
