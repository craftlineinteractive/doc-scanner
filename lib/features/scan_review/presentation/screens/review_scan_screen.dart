import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/camera/crop_overlay.dart';
import '../../../../core/widgets/mock/mock_document_page.dart';
import '../../application/review_ui_provider.dart';
import '../../application/scan_session_provider.dart';
import '../../domain/scan_page.dart';
import '../dialogs/delete_page_dialog.dart';
import '../dialogs/discard_scan_dialog.dart';
import '../dialogs/doc_name_dialog.dart';
import '../sheets/crop_shape_sheet.dart';
import '../widgets/review_bottom_bar.dart';
import '../widgets/review_color_bar.dart';
import '../widgets/review_crop_bar.dart';
import '../widgets/review_top_bar.dart';

/// Fullscreen multi-page review screen for inspecting, reordering, filtering, and cropping scans.
class ReviewScanScreen extends ConsumerStatefulWidget {
  const ReviewScanScreen({super.key, this.initialMode, this.initialDialog});

  final String? initialMode;
  final String? initialDialog;

  @override
  ConsumerState<ReviewScanScreen> createState() => _ReviewScanScreenState();
}

class _ReviewScanScreenState extends ConsumerState<ReviewScanScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    final initialIndex = ref.read(scanSessionProvider).currentIndex;
    _pageController = PageController(
      initialPage: initialIndex,
      viewportFraction: 0.82,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _applyInitialParams();
    });
  }

  void _applyInitialParams() {
    if (widget.initialMode == 'crop') {
      ref.read(reviewUiProvider.notifier).setMode(ReviewToolbarMode.crop);
    } else if (widget.initialMode == 'color') {
      ref.read(reviewUiProvider.notifier).setMode(ReviewToolbarMode.color);
    }

    if (widget.initialDialog == 'delete') {
      _showDeleteDialog();
    } else if (widget.initialDialog == 'discard') {
      _showDiscardDialog();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showRenameDialog() {
    final session = ref.read(scanSessionProvider);
    DocNameDialog.show(
      context,
      initialName: session.docName,
      onSave: (name) {
        ref.read(scanSessionProvider.notifier).rename(name);
      },
    );
  }

  void _showDeleteDialog() {
    final session = ref.read(scanSessionProvider);
    final pageNum = session.currentIndex + 1;
    DeletePageDialog.show(
      context,
      pageNumber: pageNum,
      onConfirmDelete: () {
        ref.read(scanSessionProvider.notifier).deletePage(session.currentIndex);
        if (ref.read(scanSessionProvider).pageCount == 0) {
          context.go(AppRoutes.home);
        }
      },
    );
  }

  void _showDiscardDialog() {
    final session = ref.read(scanSessionProvider);
    DiscardScanDialog.show(
      context,
      pageCount: session.pageCount,
      onConfirmDiscard: () {
        ref.read(scanSessionProvider.notifier).reset();
        if (context.canPop()) {
          context.pop();
        } else {
          context.go(AppRoutes.home);
        }
      },
    );
  }

  void _handleBack() {
    // Shows discard dialog if dirty or exits
    _showDiscardDialog();
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(scanSessionProvider);
    final uiState = ref.watch(reviewUiProvider);
    final isCropOpen = uiState.mode == ReviewToolbarMode.crop;
    final isColorOpen = uiState.mode == ReviewToolbarMode.color;

    return Theme(
      data: AppTheme.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6FA),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // Top Bar
              ReviewTopBar(
                docName: session.docName,
                onBack: _handleBack,
                onRename: _showRenameDialog,
              ),

              // Canvas with PageView
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    PageView.builder(
                      controller: _pageController,
                      itemCount: session.pageCount,
                      onPageChanged: (index) {
                        ref.read(scanSessionProvider.notifier).goTo(index);
                      },
                      itemBuilder: (context, index) {
                        final page = session.pages[index];
                        final bool isActivePage = index == session.currentIndex;

                        return Center(
                          child: _ReviewPageCard(
                            page: page,
                            showCrop: isActivePage && isCropOpen,
                            onCropChanged: (quad) {
                              ref
                                  .read(scanSessionProvider.notifier)
                                  .setCrop(index, quad);
                            },
                          ),
                        );
                      },
                    ),

                    // Page counter floating pill (bottom center)
                    Positioned(
                      bottom: 16,
                      child: Container(
                        height: 28,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF1E2340,
                          ).withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${session.currentIndex + 1} / ${session.pageCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Sub-toolbar if Crop is open
              if (isCropOpen)
                ReviewCropBar(
                  onFreeCrop: () {
                    final page = session.currentPage ?? session.pages.first;
                    CropShapeSheet.show(
                      context,
                      currentShape: page.shape,
                      onShapeSelected: (shape) {
                        ref
                            .read(scanSessionProvider.notifier)
                            .setShape(session.currentIndex, shape);
                      },
                    );
                  },
                  onAutoDetect: () {
                    ref
                        .read(scanSessionProvider.notifier)
                        .autoDetect(session.currentIndex);
                  },
                  onFlip: () {
                    ref
                        .read(scanSessionProvider.notifier)
                        .flip(session.currentIndex);
                  },
                  onCancel: () {
                    ref.read(reviewUiProvider.notifier).resetMode();
                  },
                  onConfirm: () {
                    ref.read(reviewUiProvider.notifier).resetMode();
                  },
                ),

              // Sub-toolbar if Color is open
              if (isColorOpen)
                ReviewColorBar(
                  selectedFilter:
                      (session.currentPage ?? session.pages.first).filter,
                  applyToAll: uiState.applyToAll,
                  onSelectFilter: (filter) {
                    if (uiState.applyToAll) {
                      ref
                          .read(scanSessionProvider.notifier)
                          .applyFilterToAll(filter);
                    } else {
                      ref
                          .read(scanSessionProvider.notifier)
                          .setFilter(session.currentIndex, filter);
                    }
                  },
                  onToggleApplyToAll: () {
                    ref.read(reviewUiProvider.notifier).toggleApplyToAll();
                  },
                ),

              // Main Bottom Toolbar
              ReviewBottomBar(
                activeMode: uiState.mode,
                onTapCrop: () {
                  final newMode = isCropOpen
                      ? ReviewToolbarMode.none
                      : ReviewToolbarMode.crop;
                  ref.read(reviewUiProvider.notifier).setMode(newMode);
                },
                onTapColor: () {
                  final newMode = isColorOpen
                      ? ReviewToolbarMode.none
                      : ReviewToolbarMode.color;
                  ref.read(reviewUiProvider.notifier).setMode(newMode);
                },
                onTapRotate: () {
                  ref
                      .read(scanSessionProvider.notifier)
                      .rotate(session.currentIndex);
                },
                onTapArrange: () {
                  context.push(AppRoutes.arrangePagesShort);
                },
                onTapRetake: () {
                  context.push(AppRoutes.camera);
                },
                onTapDelete: _showDeleteDialog,
                onTapSave: () {
                  context.go(AppRoutes.postScanViewer);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewPageCard extends StatelessWidget {
  const _ReviewPageCard({
    required this.page,
    required this.showCrop,
    this.onCropChanged,
  });

  final ScanPage page;
  final bool showCrop;
  final ValueChanged<dynamic>? onCropChanged;

  @override
  Widget build(BuildContext context) {
    Widget document = MockDocumentPage(
      variant: page.variant,
      showBorder: false,
    );

    final matrix = page.filter.colorFilter;
    if (matrix != null) {
      document = ColorFiltered(colorFilter: matrix, child: document);
    }

    if (page.isFlipped) {
      document = Transform.scale(scaleX: -1.0, child: document);
    }

    return Container(
      width: 260,
      height: 375,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFCBD5E1).withValues(alpha: 0.8),
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x1F1E2340),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          RotatedBox(
            quarterTurns: page.rotationQuarterTurns,
            child: Padding(padding: const EdgeInsets.all(12), child: document),
          ),
          if (showCrop)
            CropOverlay(
              initialTopLeft: page.crop.topLeft,
              initialTopRight: page.crop.topRight,
              initialBottomRight: page.crop.bottomRight,
              initialBottomLeft: page.crop.bottomLeft,
            ),
        ],
      ),
    );
  }
}
