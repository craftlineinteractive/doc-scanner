import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../application/pdf_viewer_providers.dart';
import '../../data/mock_pdf_document.dart';
import '../dialogs/add_password_dialog.dart';
import '../dialogs/pdf_help_dialog.dart';
import '../sheets/pdf_toolkit_drawer.dart';
import '../widgets/pdf_bottom_dock.dart';
import '../widgets/pdf_page_card.dart';
import '../widgets/pdf_search_bar.dart';
import '../widgets/pdf_search_jump_card.dart';
import '../widgets/pdf_top_bar.dart';

/// Interactive PDF Viewer screen implementing Frame 1 of Suite 06.
class PdfViewerScreen extends ConsumerStatefulWidget {
  const PdfViewerScreen({
    super.key,
    this.initialState = 'default',
    this.initialQuery = 'Financial',
    this.initialPage = 0,
  });

  final String initialState;
  final String initialQuery;
  final int initialPage;

  @override
  ConsumerState<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends ConsumerState<PdfViewerScreen> {
  late final ScrollController _scrollController;
  int _visiblePage = 0;

  @override
  void initState() {
    super.initState();
    _visiblePage = widget.initialPage;
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialState == 'search') {
        ref
            .read(pdfViewerProvider.notifier)
            .setSearchActive(true, defaultQuery: widget.initialQuery);
      } else if (widget.initialState == 'toolkit') {
        _openToolkitDrawer();
      } else if (widget.initialState == 'password') {
        AddPasswordDialog.show(context);
      } else if (widget.initialState == 'help') {
        _openHelpDialog();
      }
    });
  }

  void _openHelpDialog() {
    PdfHelpDialog.show(
      context,
      onGotIt: () {
        ref.read(pdfViewerProvider.notifier).setHelpShown(true);
      },
    );
  }

  void _scrollToPage(int pageIndex) {
    if (!_scrollController.hasClients) return;
    final double targetOffset = (pageIndex * 640.0).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _openToolkitDrawer() {
    PdfToolkitDrawer.show(
      context,
      onToolSelected: (String tool) {
        showAppSnackbar(context: context, message: '$tool is coming later');
      },
      onNavigateToOcr: () {
        context.push(AppRoutes.ocrResult);
      },
      onShowAddPassword: () {
        AddPasswordDialog.show(context);
      },
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final double offset = _scrollController.offset;
    // Estimated average card height + margins ~ 640px
    final int page = (offset / 640).floor().clamp(
      0,
      MockPdfDocument.pages.length - 1,
    );
    if (page != _visiblePage) {
      setState(() => _visiblePage = page);
      ref.read(pdfViewerProvider.notifier).setCurrentPage(page);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PdfViewerState state = ref.watch(pdfViewerProvider);

    final PreferredSizeWidget topBar = state.searchActive
        ? PdfSearchBar(
            initialQuery: state.searchQuery,
            totalMatches: state.matches.length,
            currentMatchIndex: state.matchIndex,
            onQueryChanged: (String q) {
              ref.read(pdfViewerProvider.notifier).setSearchQuery(q);
            },
            onPreviousMatch: () {
              ref.read(pdfViewerProvider.notifier).previousMatch();
              final match = ref.read(pdfViewerProvider).currentMatch;
              if (match != null) _scrollToPage(match.pageIndex);
            },
            onNextMatch: () {
              ref.read(pdfViewerProvider.notifier).nextMatch();
              final match = ref.read(pdfViewerProvider).currentMatch;
              if (match != null) _scrollToPage(match.pageIndex);
            },
            onClose: () {
              ref.read(pdfViewerProvider.notifier).setSearchActive(false);
            },
          )
        : PdfTopBar(
            fileName: MockPdfDocument.fileName,
            onBack: () =>
                context.canPop() ? context.pop() : context.go(AppRoutes.home),
            onSearchTap: () {
              ref.read(pdfViewerProvider.notifier).setSearchActive(true);
            },
            onHelpTap: _openHelpDialog,
          );

    final String pillText;
    if (state.searchActive) {
      if (state.matches.isNotEmpty) {
        pillText =
            'Page ${_visiblePage + 1} of ${MockPdfDocument.pages.length} • ${state.matches.length} Matches';
      } else {
        pillText = 'No matches';
      }
    } else {
      pillText = 'Page ${_visiblePage + 1} of ${MockPdfDocument.pages.length}';
    }

    return Scaffold(
      backgroundColor: const Color(0xFFE9ECF3),
      appBar: topBar,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // Interactive viewer for pinch-to-zoom
            InteractiveViewer(
              minScale: 1.0,
              maxScale: 4.0,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(top: 12, bottom: 96),
                itemCount: MockPdfDocument.pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return PdfPageCard(
                    content: MockPdfDocument.pages[index],
                    searchQuery: state.searchActive ? state.searchQuery : '',
                    currentMatch: state.currentMatch,
                  );
                },
              ),
            ),

            // Floating Page Count Pill
            Positioned(
              bottom: state.searchActive ? 84 : 84,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.textPrimary.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    pillText,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Fixed Bottom Area: Search Jump Card or Dock
            Positioned(
              left: 0,
              right: 0,
              bottom: state.searchActive ? 16 : 0,
              child: state.searchActive
                  ? (state.currentMatch != null
                        ? PdfSearchJumpCard(
                            match: state.currentMatch!,
                            totalMatches: state.matches.length,
                            onJump: () =>
                                _scrollToPage(state.currentMatch!.pageIndex),
                          )
                        : const SizedBox.shrink())
                  : PdfBottomDock(
                      onToolkitTap: _openToolkitDrawer,
                      onToolTap: (String tool) {
                        showAppSnackbar(
                          context: context,
                          message: '$tool is coming later',
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
