import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/buttons/labelled_dual_pill_fab.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../application/viewer_providers.dart';
import '../../domain/saved_document.dart';
import '../../../scan_review/presentation/dialogs/doc_name_dialog.dart';
import '../sheets/page_manager_action_drawer.dart';
import '../widgets/page_manager_grid_card.dart';
import '../widgets/page_manager_search_view.dart';

/// Multi-Page Manager Screen implementing frames 1 to 3 of suite 03.
class PageManagerScreen extends ConsumerStatefulWidget {
  const PageManagerScreen({
    super.key,
    this.initialDocId = 'doc_multi_4',
    this.initialState = 'grid',
    this.initialQuery = 'Invoice',
  });

  final String initialDocId;
  final String initialState;
  final String initialQuery;

  @override
  ConsumerState<PageManagerScreen> createState() => _PageManagerScreenState();
}

class _PageManagerScreenState extends ConsumerState<PageManagerScreen> {
  late bool _isSearchActive;

  @override
  void initState() {
    super.initState();
    _isSearchActive = widget.initialState == 'search';

    if (widget.initialState == 'drawer') {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showActionDrawer());
    }
  }

  @override
  void didUpdateWidget(covariant PageManagerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialState != oldWidget.initialState) {
      setState(() {
        _isSearchActive = widget.initialState == 'search';
      });
      if (widget.initialState == 'drawer') {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => _showActionDrawer(),
        );
      }
    }
  }

  void _showActionDrawer() {
    final SavedDocument doc = ref
        .read(savedDocumentsProvider.notifier)
        .getDocument(widget.initialDocId);

    PageManagerActionDrawer.show(
      context,
      document: doc,
      onRenameTap: () {
        Navigator.of(context).pop();
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
      },
      onFavoriteToggle: () {
        ref
            .read(savedDocumentsProvider.notifier)
            .toggleFavorite(widget.initialDocId);
      },
      onDeleteDoc: () {
        showAppSnackbar(context: context, message: 'Document moved to Trash');
        context.go(AppRoutes.home);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isSearchActive) {
      return PageManagerSearchView(
        initialQuery: widget.initialQuery,
        onClose: () {
          if (_isSearchActive && widget.initialState != 'search') {
            setState(() => _isSearchActive = false);
          } else if (context.canPop()) {
            context.pop();
          } else {
            setState(() => _isSearchActive = false);
          }
        },
        onJumpToPage: (int pageIndex) {
          context.push(
            '${AppRoutes.savedViewer}?id=${widget.initialDocId}&page=$pageIndex',
          );
        },
        onOpenPdf: () => showAppSnackbar(
          context: context,
          message: 'Opening PDF document...',
        ),
      );
    }

    ref.watch(savedDocumentsProvider);
    final SavedDocument doc = ref
        .read(savedDocumentsProvider.notifier)
        .getDocument(widget.initialDocId);

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(
            Symbols.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(AppRoutes.home),
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              doc.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    doc.isSynced ? 'Cloud Synced' : 'Local Only',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Symbols.search_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: () => setState(() => _isSearchActive = true),
            tooltip: 'Search document',
          ),
          InkWell(
            onTap: () => context.push(
              '${AppRoutes.savedViewer}?id=${widget.initialDocId}&frame=5',
            ),
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryTint,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    Symbols.picture_as_pdf_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'PDF',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Symbols.more_vert_rounded,
              color: AppColors.textPrimary,
            ),
            onPressed: _showActionDrawer,
            tooltip: 'More options',
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // Sub-metadata bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  color: AppColors.surfaceSubdued,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            const Icon(
                              Symbols.folder_open_rounded,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                '${doc.pageCount} Pages • ${doc.sizeMb.toStringAsFixed(1)} MB • ${doc.scannedLabel}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.hairline),
                        ),
                        child: Text(
                          'Pg 1-${doc.pageCount}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // 2-Column Grid
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 96),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.68,
                        ),
                    itemCount: doc.pages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return PageManagerGridCard(
                        page: doc.pages[index],
                        pageNumber: index + 1,
                        onTap: () {
                          context.push(
                            '${AppRoutes.savedViewer}?id=${widget.initialDocId}&page=$index',
                          );
                        },
                        onMoreTap: () {
                          ref
                              .read(savedDocumentsProvider.notifier)
                              .rotatePage(widget.initialDocId, index);
                          showAppSnackbar(
                            context: context,
                            message: 'Rotated Page ${index + 1}',
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),

            // Persistent Floating Dual Pill Capsule
            Positioned(
              bottom: 24,
              left: 0,
              right: 0,
              child: Center(
                child: LabelledDualPillFab(
                  onScanPageTap: () => context.push(AppRoutes.camera),
                  onImportTap: () => showAppSnackbar(
                    context: context,
                    message: 'Select image or document to import',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
