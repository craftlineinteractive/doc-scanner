import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../scan_review/domain/crop_quad.dart';
import '../../scan_review/domain/scan_filter.dart';
import '../data/mock_saved_documents.dart';
import '../domain/saved_document.dart';
import '../domain/viewer_page.dart';
import '../domain/viewer_tool_tier.dart';

/// Provider for current page index in the viewer.
final NotifierProvider<CurrentPageIndexNotifier, int>
    currentPageIndexProvider =
    NotifierProvider<CurrentPageIndexNotifier, int>(
  CurrentPageIndexNotifier.new,
);

class CurrentPageIndexNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void setPage(int index) => state = index;
}

/// Provider for currently active tool tier in the viewer.
final NotifierProvider<ViewerToolTierNotifier, ViewerToolTier>
    viewerToolTierProvider =
    NotifierProvider<ViewerToolTierNotifier, ViewerToolTier>(
  ViewerToolTierNotifier.new,
);

class ViewerToolTierNotifier extends Notifier<ViewerToolTier> {
  @override
  ViewerToolTier build() => ViewerToolTier.main;

  void setTier(ViewerToolTier tier) => state = tier;
}

/// Provider for OCR panel visibility in Post-Scan Viewer.
final NotifierProvider<OcrPanelOpenNotifier, bool>
    ocrPanelOpenProvider =
    NotifierProvider<OcrPanelOpenNotifier, bool>(
  OcrPanelOpenNotifier.new,
);

class OcrPanelOpenNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void setOpen(bool open) => state = open;
}

/// Provider managing the repository of saved documents.
final NotifierProvider<SavedDocumentsNotifier, Map<String, SavedDocument>>
    savedDocumentsProvider =
    NotifierProvider<SavedDocumentsNotifier, Map<String, SavedDocument>>(
  SavedDocumentsNotifier.new,
);

class SavedDocumentsNotifier extends Notifier<Map<String, SavedDocument>> {
  @override
  Map<String, SavedDocument> build() {
    return <String, SavedDocument>{
      MockSavedDocuments.postScanDoc.id: MockSavedDocuments.postScanDoc,
      MockSavedDocuments.savedViewerDoc.id: MockSavedDocuments.savedViewerDoc,
      MockSavedDocuments.multiPageDoc.id: MockSavedDocuments.multiPageDoc,
    };
  }

  SavedDocument getDocument(String id) {
    return state[id] ?? MockSavedDocuments.getDocumentById(id);
  }

  void rename(String id, String newTitle) {
    if (newTitle.trim().isEmpty) return;
    final SavedDocument doc = getDocument(id);
    state = <String, SavedDocument>{
      ...state,
      id: doc.copyWith(title: newTitle.trim()),
    };
  }

  void toggleFavorite(String id) {
    final SavedDocument doc = getDocument(id);
    state = <String, SavedDocument>{
      ...state,
      id: doc.copyWith(isFavorite: !doc.isFavorite),
    };
  }

  void rotatePage(String id, int pageIndex) {
    final SavedDocument doc = getDocument(id);
    if (pageIndex < 0 || pageIndex >= doc.pages.length) return;
    final List<ViewerPage> updated = List<ViewerPage>.from(doc.pages);
    final ViewerPage target = updated[pageIndex];
    updated[pageIndex] = target.copyWith(
      rotationQuarterTurns: (target.rotationQuarterTurns + 1) % 4,
    );
    state = <String, SavedDocument>{
      ...state,
      id: doc.copyWith(pages: updated),
    };
  }

  void flipPage(String id, int pageIndex) {
    final SavedDocument doc = getDocument(id);
    if (pageIndex < 0 || pageIndex >= doc.pages.length) return;
    final List<ViewerPage> updated = List<ViewerPage>.from(doc.pages);
    final ViewerPage target = updated[pageIndex];
    updated[pageIndex] = target.copyWith(isFlipped: !target.isFlipped);
    state = <String, SavedDocument>{
      ...state,
      id: doc.copyWith(pages: updated),
    };
  }

  void setPageCrop(String id, int pageIndex, CropQuad crop) {
    final SavedDocument doc = getDocument(id);
    if (pageIndex < 0 || pageIndex >= doc.pages.length) return;
    final List<ViewerPage> updated = List<ViewerPage>.from(doc.pages);
    updated[pageIndex] = updated[pageIndex].copyWith(crop: crop);
    state = <String, SavedDocument>{
      ...state,
      id: doc.copyWith(pages: updated),
    };
  }

  void setPageFilter(String id, int pageIndex, ScanFilter filter) {
    final SavedDocument doc = getDocument(id);
    if (pageIndex < 0 || pageIndex >= doc.pages.length) return;
    final List<ViewerPage> updated = List<ViewerPage>.from(doc.pages);
    updated[pageIndex] = updated[pageIndex].copyWith(
      filter: filter,
      filterLabel: filter.label,
    );
    state = <String, SavedDocument>{
      ...state,
      id: doc.copyWith(pages: updated),
    };
  }

  void deletePage(String id, int pageIndex) {
    final SavedDocument doc = getDocument(id);
    if (pageIndex < 0 || pageIndex >= doc.pages.length || doc.pages.length <= 1) {
      return;
    }
    final List<ViewerPage> updated = List<ViewerPage>.from(doc.pages)
      ..removeAt(pageIndex);
    state = <String, SavedDocument>{
      ...state,
      id: doc.copyWith(pages: updated),
    };
  }

  void reorderPages(String id, int oldIndex, int newIndex) {
    final SavedDocument doc = getDocument(id);
    if (oldIndex < 0 || oldIndex >= doc.pages.length) return;
    if (newIndex < 0 || newIndex >= doc.pages.length) return;
    final List<ViewerPage> updated = List<ViewerPage>.from(doc.pages);
    final ViewerPage page = updated.removeAt(oldIndex);
    updated.insert(newIndex, page);
    state = <String, SavedDocument>{
      ...state,
      id: doc.copyWith(pages: updated),
    };
  }
}
