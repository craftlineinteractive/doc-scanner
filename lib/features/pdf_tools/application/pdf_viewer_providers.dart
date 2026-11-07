import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_pdf_document.dart';
import '../domain/pdf_search_match.dart';

/// Immutable state container for the PDF viewer, search, and toolkit.
class PdfViewerState {
  const PdfViewerState({
    this.currentPage = 0,
    this.toolkitOpen = false,
    this.searchActive = false,
    this.searchQuery = '',
    this.matchIndex = 0,
    this.matches = const <PdfSearchMatch>[],
    this.helpShown = false,
  });

  final int currentPage;
  final bool toolkitOpen;
  final bool searchActive;
  final String searchQuery;
  final int matchIndex;
  final List<PdfSearchMatch> matches;
  final bool helpShown;

  PdfSearchMatch? get currentMatch =>
      matches.isNotEmpty && matchIndex < matches.length
          ? matches[matchIndex]
          : null;

  PdfViewerState copyWith({
    int? currentPage,
    bool? toolkitOpen,
    bool? searchActive,
    String? searchQuery,
    int? matchIndex,
    List<PdfSearchMatch>? matches,
    bool? helpShown,
  }) {
    return PdfViewerState(
      currentPage: currentPage ?? this.currentPage,
      toolkitOpen: toolkitOpen ?? this.toolkitOpen,
      searchActive: searchActive ?? this.searchActive,
      searchQuery: searchQuery ?? this.searchQuery,
      matchIndex: matchIndex ?? this.matchIndex,
      matches: matches ?? this.matches,
      helpShown: helpShown ?? this.helpShown,
    );
  }
}

/// Riverpod 3.x Notifier managing PDF viewer interactions and text search.
class PdfViewerNotifier extends Notifier<PdfViewerState> {
  @override
  PdfViewerState build() {
    return const PdfViewerState();
  }

  void setCurrentPage(int page) {
    if (page == state.currentPage) return;
    state = state.copyWith(currentPage: page);
  }

  void setToolkitOpen(bool open) {
    state = state.copyWith(toolkitOpen: open);
  }

  void setHelpShown(bool shown) {
    state = state.copyWith(helpShown: shown);
  }

  void setSearchActive(bool active, {String? defaultQuery}) {
    if (!active) {
      state = state.copyWith(
        searchActive: false,
        searchQuery: '',
        matchIndex: 0,
        matches: const <PdfSearchMatch>[],
      );
      return;
    }

    final String query = defaultQuery ?? state.searchQuery;
    final List<PdfSearchMatch> found = findPdfSearchMatches(
      MockPdfDocument.pages,
      query,
    );
    state = state.copyWith(
      searchActive: true,
      searchQuery: query,
      matchIndex: 0,
      matches: found,
    );
  }

  void setSearchQuery(String query) {
    final List<PdfSearchMatch> found = findPdfSearchMatches(
      MockPdfDocument.pages,
      query,
    );
    state = state.copyWith(
      searchQuery: query,
      matchIndex: 0,
      matches: found,
    );
  }

  void nextMatch() {
    if (state.matches.isEmpty) return;
    final int next = (state.matchIndex + 1) % state.matches.length;
    state = state.copyWith(matchIndex: next);
  }

  void previousMatch() {
    if (state.matches.isEmpty) return;
    final int prev =
        (state.matchIndex - 1 + state.matches.length) % state.matches.length;
    state = state.copyWith(matchIndex: prev);
  }

  void setMatchIndex(int index) {
    if (index < 0 || index >= state.matches.length) return;
    state = state.copyWith(matchIndex: index);
  }
}

final NotifierProvider<PdfViewerNotifier, PdfViewerState> pdfViewerProvider =
    NotifierProvider<PdfViewerNotifier, PdfViewerState>(
  PdfViewerNotifier.new,
);

