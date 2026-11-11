import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_theme.dart';
import '../../application/scan_session_provider.dart';
import '../dialogs/doc_name_dialog.dart';
import '../sheets/crop_shape_sheet.dart';
import '../sheets/filter_bottom_sheet.dart';
import '../widgets/adjust_canvas.dart';
import '../widgets/adjust_controls.dart';

/// Fullscreen dark adjust screen shown after camera capture for border cropping and filters.
class AdjustScreen extends ConsumerStatefulWidget {
  const AdjustScreen({
    super.key,
    this.initialSheet,
    this.initialDialog,
    this.initialDrag,
  });

  final String? initialSheet;
  final String? initialDialog;
  final String? initialDrag;

  @override
  ConsumerState<AdjustScreen> createState() => _AdjustScreenState();
}

class _AdjustScreenState extends ConsumerState<AdjustScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _handleInitialParams();
    });
  }

  void _handleInitialParams() {
    if (widget.initialSheet == 'filters') {
      _showFilterSheet();
    } else if (widget.initialSheet == 'shape') {
      _showCropShapeSheet();
    }

    if (widget.initialDialog == 'doc_name') {
      _showDocNameDialog();
    }
  }

  void _showFilterSheet() {
    final session = ref.read(scanSessionProvider);
    final activePage = session.currentPage ?? session.pages.first;
    FilterBottomSheet.show(
      context,
      currentFilter: activePage.filter,
      onFilterChanged: (filter) {
        ref
            .read(scanSessionProvider.notifier)
            .setFilter(session.currentIndex, filter);
      },
    );
  }

  void _showCropShapeSheet() {
    final session = ref.read(scanSessionProvider);
    final activePage = session.currentPage ?? session.pages.first;
    CropShapeSheet.show(
      context,
      currentShape: activePage.shape,
      onShapeSelected: (shape) {
        ref
            .read(scanSessionProvider.notifier)
            .setShape(session.currentIndex, shape);
      },
    );
  }

  void _showDocNameDialog() {
    final session = ref.read(scanSessionProvider);
    DocNameDialog.show(
      context,
      initialName: session.docName,
      onSave: (name) {
        ref.read(scanSessionProvider.notifier).rename(name);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(scanSessionProvider);
    final activePage = session.currentPage ?? session.pages.first;
    final bool forceDrag = widget.initialDrag == 'true';

    return Theme(
      data: AppTheme.camera,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F1220),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // Top App Bar (56px)
              SizedBox(
                height: 56,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (context.canPop()) {
                            context.pop();
                          } else {
                            context.go(AppRoutes.camera);
                          }
                        },
                      ),
                      const Text(
                        'Adjust',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${session.currentIndex + 1}/${session.pageCount}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Document Canvas Area with interactive quad
              Expanded(
                child: Center(
                  child: AdjustCanvas(
                    page: activePage,
                    forceShowMagnifier: forceDrag,
                    onCropChanged: (quad) {
                      ref
                          .read(scanSessionProvider.notifier)
                          .setCrop(session.currentIndex, quad);
                    },
                  ),
                ),
              ),

              // Helper instruction hint
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.info_outline_rounded,
                      size: 14,
                      color: Color(0xFF8A90A6),
                    ),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'Drag the points to adjust the borders.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8A90A6),
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // Controls Panel
              AdjustControls(
                currentFilter: activePage.filter,
                showCropAfterCapture: session.showCropAfterCapture,
                onOpenFilters: _showFilterSheet,
                onRotate: () {
                  ref
                      .read(scanSessionProvider.notifier)
                      .rotate(session.currentIndex);
                },
                onOpenCropShape: _showCropShapeSheet,
                onOpenDocName: _showDocNameDialog,
                onToggleCropAfterCapture: (val) {
                  ref
                      .read(scanSessionProvider.notifier)
                      .setShowCropAfterCapture(val);
                },
                onRetake: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go(AppRoutes.camera);
                  }
                },
                onContinue: () {
                  context.go(AppRoutes.reviewScan);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
