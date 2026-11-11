import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../scan_review/domain/crop_quad.dart';
import '../../../scan_review/domain/crop_shape.dart';
import '../../../scan_review/domain/scan_filter.dart';
import '../../../scan_review/presentation/dialogs/doc_name_dialog.dart';
import '../../../scan_review/presentation/sheets/filter_bottom_sheet.dart';
import '../../application/viewer_providers.dart';
import '../../domain/saved_document.dart';
import '../../domain/viewer_page.dart';
import '../../domain/viewer_tool_tier.dart';
import '../sheets/document_more_options_sheet.dart';
import '../widgets/post_scan_canvas.dart';
import '../widgets/post_scan_crop_toolbar.dart';
import '../widgets/post_scan_edit_toolbar.dart';
import '../widgets/post_scan_main_toolbar.dart';
import '../widgets/post_scan_ocr_panel.dart';
import '../widgets/post_scan_top_bar.dart';

/// Full interactive Post-Scan Viewer Screen representing frames 01 to 05.
class PostScanViewerScreen extends ConsumerStatefulWidget {
  const PostScanViewerScreen({
    super.key,
    this.initialDocId = 'doc_post_scan',
    this.initialTier,
    this.initialPanel,
    this.initialPageIndex = 0,
  });

  final String initialDocId;
  final String? initialTier;
  final String? initialPanel;
  final int initialPageIndex;

  @override
  ConsumerState<PostScanViewerScreen> createState() =>
      _PostScanViewerScreenState();
}

class _PostScanViewerScreenState extends ConsumerState<PostScanViewerScreen> {
  late PageController _pageController;
  late int _currentPage;
  late ViewerToolTier _toolTier;
  bool _isOcrActive = false;
  CropShape _cropShape = CropShape.free;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.initialPageIndex;
    _pageController = PageController(initialPage: _currentPage);

    if (widget.initialTier == 'edit') {
      _toolTier = ViewerToolTier.edit;
    } else if (widget.initialTier == 'crop') {
      _toolTier = ViewerToolTier.crop;
    } else {
      _toolTier = ViewerToolTier.main;
    }

    if (widget.initialPanel == 'ocr') {
      _isOcrActive = true;
    }

    if (widget.initialPanel == 'more') {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showMoreOptionsSheet();
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _showMoreOptionsSheet() {
    final SavedDocument doc = ref
        .read(savedDocumentsProvider.notifier)
        .getDocument(widget.initialDocId);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) => DocumentMoreOptionsSheet(
        document: doc,
        onRename: () {
          Navigator.of(ctx).pop();
          _showRenameDialog(doc);
        },
        onFavoriteToggle: () {
          ref
              .read(savedDocumentsProvider.notifier)
              .toggleFavorite(widget.initialDocId);
          Navigator.of(ctx).pop();
        },
      ),
    );
  }

  void _showRenameDialog(SavedDocument doc) {
    DocNameDialog.show(
      context,
      initialName: doc.title,
      onSave: (String newName) {
        if (newName.isNotEmpty) {
          ref
              .read(savedDocumentsProvider.notifier)
              .rename(widget.initialDocId, newName);
        }
      },
    );
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
      appBar: PostScanTopBar(
        title: doc.title,
        currentPage: _currentPage + 1,
        totalPages: doc.pageCount,
        isCropMode: _toolTier == ViewerToolTier.crop,
        isOcrActive: _isOcrActive,
        isFavorite: doc.isFavorite,
        onBack: () =>
            context.canPop() ? context.pop() : context.go(AppRoutes.home),
        onTitleTap: () => _showRenameDialog(doc),
        onFavoriteToggle: () => ref
            .read(savedDocumentsProvider.notifier)
            .toggleFavorite(widget.initialDocId),
        onMoreTap: _showMoreOptionsSheet,
        onCropApply: () {
          setState(() => _toolTier = ViewerToolTier.edit);
          showAppSnackbar(
            context: context,
            message: 'Crop applied successfully',
          );
        },
        onCropCancel: () {
          setState(() => _toolTier = ViewerToolTier.edit);
        },
      ),
      body: Column(
        children: <Widget>[
          // Interactive Canvas
          Expanded(
            child: PostScanCanvas(
              pages: doc.pages,
              currentIndex: _currentPage,
              pageController: _pageController,
              toolTier: _toolTier,
              isOcrActive: _isOcrActive,
              onPageChanged: (int idx) => setState(() => _currentPage = idx),
              onCropChanged: (CropQuad crop) {
                ref
                    .read(savedDocumentsProvider.notifier)
                    .setPageCrop(widget.initialDocId, _currentPage, crop);
              },
            ),
          ),

          // Optional OCR Preview Card (Frame 04)
          if (_isOcrActive && currentPage != null)
            PostScanOcrPanel(
              extractedText: currentPage.extractedText,
              onClose: () => setState(() => _isOcrActive = false),
              onCopyAll: () => showAppSnackbar(
                context: context,
                message: 'Copied to Clipboard! Ready',
              ),
              onExportTxt: () => showAppSnackbar(
                context: context,
                message: 'Exported as TXT file',
              ),
              onTranslate: () => showAppSnackbar(
                context: context,
                message: 'Translating document...',
              ),
              onSearch: () => showAppSnackbar(
                context: context,
                message: 'Searching in document...',
              ),
            ),

          // 3rd-tier Crop Toolbar
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

          // 2nd-tier Edit Toolbar
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
                        .setPageFilter(
                          widget.initialDocId,
                          _currentPage,
                          filter,
                        );
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
                message: 'Erase annotation tool active',
              ),
              onSignTap: () => showAppSnackbar(
                context: context,
                message: 'Tap page to position signature',
              ),
              onWatermarkTap: () => showAppSnackbar(
                context: context,
                message: 'Watermark applied: CONFIDENTIAL',
              ),
              onCloseTap: () => setState(() => _toolTier = ViewerToolTier.main),
            ),

          // 1st-tier Main Toolbar
          if (_toolTier != ViewerToolTier.crop)
            PostScanMainToolbar(
              isEditActive: _toolTier == ViewerToolTier.edit,
              onEditTap: () {
                setState(() {
                  _toolTier = _toolTier == ViewerToolTier.edit
                      ? ViewerToolTier.main
                      : ViewerToolTier.edit;
                });
              },
              onOpenPdfTap: () => showAppSnackbar(
                context: context,
                message: 'Opening PDF preview...',
              ),
              onShareTap: () => showAppSnackbar(
                context: context,
                message: 'Simulating document export & share...',
              ),
              onRetakeTap: () => context.push(AppRoutes.camera),
              onPrintTap: () => showAppSnackbar(
                context: context,
                message: 'Connecting to printer...',
              ),
              onCopyTextTap: () => setState(() => _isOcrActive = !_isOcrActive),
              onImageToTap: () => showAppSnackbar(
                context: context,
                message: 'Exporting as JPEG...',
              ),
              onRotateTap: () {
                ref
                    .read(savedDocumentsProvider.notifier)
                    .rotatePage(widget.initialDocId, _currentPage);
              },
              onMoreTap: _showMoreOptionsSheet,
            ),
        ],
      ),
    );
  }
}
