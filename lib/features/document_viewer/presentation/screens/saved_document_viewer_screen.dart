import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../scan_review/domain/crop_quad.dart';
import '../../../scan_review/domain/crop_shape.dart';
import '../../../scan_review/domain/scan_filter.dart';
import '../../../scan_review/presentation/sheets/filter_bottom_sheet.dart';
import '../../application/viewer_providers.dart';
import '../../domain/saved_document.dart';
import '../../domain/viewer_page.dart';
import '../../domain/viewer_tool_tier.dart';
import '../dialogs/edit_version_dialog.dart';
import '../sheets/pdf_more_options_sheet.dart';
import '../widgets/post_scan_canvas.dart';
import '../widgets/post_scan_crop_toolbar.dart';
import '../widgets/post_scan_edit_toolbar.dart';
import '../widgets/saved_viewer_toolbars.dart';

/// Saved Document Viewer Screen implementing frames 1 to 5 of suite 02.
class SavedDocumentViewerScreen extends ConsumerStatefulWidget {
  const SavedDocumentViewerScreen({
    super.key,
    this.initialDocId = 'doc_saved_5',
    this.initialFrame,
    this.initialPageIndex = 0,
  });

  final String initialDocId;
  final int? initialFrame;
  final int initialPageIndex;

  @override
  ConsumerState<SavedDocumentViewerScreen> createState() =>
      _SavedDocumentViewerScreenState();
}

class _SavedDocumentViewerScreenState
    extends ConsumerState<SavedDocumentViewerScreen> {
  late PageController _pageController;
  late int _currentPage;
  late ViewerToolTier _toolTier;
  CropShape _cropShape = CropShape.free;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPageIndex;
    _pageController = PageController(initialPage: _currentPage);

    switch (widget.initialFrame) {
      case 2:
        _toolTier = ViewerToolTier.main;
        WidgetsBinding.instance.addPostFrameCallback((_) => _showEditChoiceDialog());
        break;
      case 3:
        _toolTier = ViewerToolTier.edit;
        break;
      case 4:
        _toolTier = ViewerToolTier.crop;
        break;
      case 5:
        _toolTier = ViewerToolTier.pdf;
        WidgetsBinding.instance.addPostFrameCallback((_) => PdfMoreOptionsSheet.show(context));
        break;
      default:
        _toolTier = ViewerToolTier.main;
        break;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showEditChoiceDialog() {
    EditVersionDialog.show(context).then((EditDocumentVersion? version) {
      if (version != null) {
        setState(() => _toolTier = ViewerToolTier.edit);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(savedDocumentsProvider);
    final SavedDocument doc = ref
        .read(savedDocumentsProvider.notifier)
        .getDocument(widget.initialDocId);

    final ViewerPage? currentPage = doc.getPage(_currentPage);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: () => context.canPop() ? context.pop() : context.go(AppRoutes.home),
        ),
        title: Text(
          doc.title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${_currentPage + 1} / ${doc.pageCount}',
                style: const TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Page View Canvas
          Expanded(
            child: PostScanCanvas(
              pages: doc.pages,
              currentIndex: _currentPage,
              pageController: _pageController,
              toolTier: _toolTier,
              isOcrActive: false,
              onPageChanged: (int idx) => setState(() => _currentPage = idx),
              onCropChanged: (CropQuad crop) {
                ref
                    .read(savedDocumentsProvider.notifier)
                    .setPageCrop(widget.initialDocId, _currentPage, crop);
              },
            ),
          ),

          // Crop Tier
          if (_toolTier == ViewerToolTier.crop)
            PostScanCropToolbar(
              selectedShape: _cropShape,
              onShapeSelected: (CropShape shape) {
                setState(() => _cropShape = shape);
              },
              onAutoDetect: () => showAppSnackbar(
                context: context,
                message: 'Auto Edge Detection re-aligned',
              ),
              onFlip: () {
                ref
                    .read(savedDocumentsProvider.notifier)
                    .flipPage(widget.initialDocId, _currentPage);
              },
              onCancel: () => setState(() => _toolTier = ViewerToolTier.edit),
              onApply: () {
                setState(() => _toolTier = ViewerToolTier.edit);
                showAppSnackbar(
                  context: context,
                  message: 'Crop changes saved',
                );
              },
            ),

          // Edit Tier
          if (_toolTier == ViewerToolTier.edit)
            PostScanEditToolbar(
              onCropTap: () => setState(() => _toolTier = ViewerToolTier.crop),
              onFilterTap: () {
                if (currentPage == null) return;
                FilterBottomSheet.show(
                  context,
                  currentFilter: currentPage.filter,
                  onFilterChanged: (ScanFilter filter) {
                    ref
                        .read(savedDocumentsProvider.notifier)
                        .setPageFilter(widget.initialDocId, _currentPage, filter);
                  },
                );
              },
              onRotateTap: () {
                ref
                    .read(savedDocumentsProvider.notifier)
                    .rotatePage(widget.initialDocId, _currentPage);
              },
              onEraseTap: () => showAppSnackbar(
                context: context,
                message: 'Erase tool activated',
              ),
              onSignTap: () => showAppSnackbar(
                context: context,
                message: 'Tap document to place signature',
              ),
              onWatermarkTap: () => showAppSnackbar(
                context: context,
                message: 'Watermark added: CONFIDENTIAL',
              ),
              onCloseTap: () => setState(() => _toolTier = ViewerToolTier.main),
            ),

          // PDF Sub-tool Tier
          if (_toolTier == ViewerToolTier.pdf)
            SavedViewerPdfSubToolbar(
              onCompress: () => context.push(AppRoutes.pdfViewer),
              onWatermark: () => context.push(AppRoutes.pdfViewer),
              onFitType: () => context.push(AppRoutes.pdfViewer),
              onPageSize: () => context.push(AppRoutes.pdfViewer),
              onOrientation: () => context.push(AppRoutes.pdfViewer),
              onMore: () => context.push(AppRoutes.pdfViewer),
            ),

          // Main 6-Tool Row
          SavedViewerMainToolbar(
            currentTier: _toolTier,
            onEditTap: _showEditChoiceDialog,
            onEditAllTap: () => context.push(AppRoutes.arrangePages),
            onOpenPdfTap: () => context.push(AppRoutes.pdfViewer),
            onShareTap: () => showAppSnackbar(
              context: context,
              message: 'Preparing document for sharing...',
            ),
            onSaveTap: () => showAppSnackbar(
              context: context,
              message: 'Document saved to Device Storage',
            ),
            onRetakeTap: () => context.push(AppRoutes.camera),
          ),
        ],
      ),
    );
  }
}

