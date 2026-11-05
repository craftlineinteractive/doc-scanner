import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/mock/mock_document_page.dart';
import '../domain/crop_quad.dart';
import '../domain/crop_shape.dart';
import '../domain/scan_filter.dart';
import '../domain/scan_page.dart';

/// Immutable in-memory state of an active document capture session.
class ScanSessionState {
  const ScanSessionState({
    required this.pages,
    this.currentIndex = 1,
    this.docName = 'Doc Scanner 10 Oct 2026 7-49 pm',
    this.showCropAfterCapture = true,
  });

  final List<ScanPage> pages;
  final int currentIndex;
  final String docName;
  final bool showCropAfterCapture;

  ScanPage? get currentPage =>
      (currentIndex >= 0 && currentIndex < pages.length)
          ? pages[currentIndex]
          : null;

  int get pageCount => pages.length;

  ScanSessionState copyWith({
    List<ScanPage>? pages,
    int? currentIndex,
    String? docName,
    bool? showCropAfterCapture,
  }) {
    return ScanSessionState(
      pages: pages ?? this.pages,
      currentIndex: currentIndex ?? this.currentIndex,
      docName: docName ?? this.docName,
      showCropAfterCapture: showCropAfterCapture ?? this.showCropAfterCapture,
    );
  }

  static List<ScanPage> createDefaultMockPages() {
    return <ScanPage>[
      ScanPage(
        id: 'page_1',
        variant: MockDocumentVariant.invoice,
        filter: ScanFilter.vividLight,
        crop: CropQuad.mockAdjust(),
      ),
      ScanPage(
        id: 'page_2',
        variant: MockDocumentVariant.contract,
        filter: ScanFilter.vividLight,
        crop: CropQuad.mockAdjust(),
      ),
      ScanPage(
        id: 'page_3',
        variant: MockDocumentVariant.receipt,
        filter: ScanFilter.vividLight,
        crop: CropQuad.mockAdjust(),
      ),
      ScanPage(
        id: 'page_4',
        variant: MockDocumentVariant.idCard,
        filter: ScanFilter.vividLight,
        crop: CropQuad.mockAdjust(),
      ),
      ScanPage(
        id: 'page_5',
        variant: MockDocumentVariant.invoice,
        filter: ScanFilter.vividLight,
        crop: CropQuad.mockAdjust(),
      ),
    ];
  }
}

/// State notifier managing active multi-page document review state.
class ScanSessionNotifier extends Notifier<ScanSessionState> {
  @override
  ScanSessionState build() {
    return ScanSessionState(
      pages: ScanSessionState.createDefaultMockPages(),
      currentIndex: 1, // Focus on Page 2 ("2 / 5") as shown in mockup
      docName: 'Doc Scanner 10 Oct 2026 7-49 pm',
      showCropAfterCapture: true,
    );
  }

  void setFilter(int index, ScanFilter filter) {
    if (index < 0 || index >= state.pages.length) return;
    final updated = List<ScanPage>.from(state.pages);
    updated[index] = updated[index].copyWith(filter: filter);
    state = state.copyWith(pages: updated);
  }

  void applyFilterToAll(ScanFilter filter) {
    final updated = state.pages
        .map((page) => page.copyWith(filter: filter))
        .toList();
    state = state.copyWith(pages: updated);
  }

  void rotate(int index, {bool clockwise = true}) {
    if (index < 0 || index >= state.pages.length) return;
    final updated = List<ScanPage>.from(state.pages);
    final currentTurns = updated[index].rotationQuarterTurns;
    final nextTurns = clockwise
        ? (currentTurns + 1) % 4
        : (currentTurns + 3) % 4;
    updated[index] = updated[index].copyWith(rotationQuarterTurns: nextTurns);
    state = state.copyWith(pages: updated);
  }

  void setCrop(int index, CropQuad quad) {
    if (index < 0 || index >= state.pages.length) return;
    final updated = List<ScanPage>.from(state.pages);
    updated[index] = updated[index].copyWith(crop: quad);
    state = state.copyWith(pages: updated);
  }

  void setShape(int index, CropShape shape) {
    if (index < 0 || index >= state.pages.length) return;
    final updated = List<ScanPage>.from(state.pages);
    final ratio = shape.aspectRatio;
    final newCrop = (ratio != null)
        ? CropQuad.fromAspectRatio(ratio)
        : CropQuad.mockAdjust();
    updated[index] = updated[index].copyWith(shape: shape, crop: newCrop);
    state = state.copyWith(pages: updated);
  }

  void autoDetect(int index) {
    if (index < 0 || index >= state.pages.length) return;
    final updated = List<ScanPage>.from(state.pages);
    updated[index] = updated[index].copyWith(crop: CropQuad.inset(0.05));
    state = state.copyWith(pages: updated);
  }

  void flip(int index) {
    if (index < 0 || index >= state.pages.length) return;
    final updated = List<ScanPage>.from(state.pages);
    updated[index] =
        updated[index].copyWith(isFlipped: !updated[index].isFlipped);
    state = state.copyWith(pages: updated);
  }

  void deletePage(int index) {
    if (index < 0 || index >= state.pages.length) return;
    final updated = List<ScanPage>.from(state.pages)..removeAt(index);
    int nextIndex = state.currentIndex;
    if (nextIndex >= updated.length) {
      nextIndex = updated.length - 1;
    }
    state = state.copyWith(
      pages: updated,
      currentIndex: nextIndex < 0 ? 0 : nextIndex,
    );
  }

  void movePage(int from, int to) {
    if (from < 0 || from >= state.pages.length) return;
    if (to < 0 || to >= state.pages.length) return;
    final updated = List<ScanPage>.from(state.pages);
    final item = updated.removeAt(from);
    updated.insert(to, item);
    state = state.copyWith(pages: updated);
  }

  void addMockPage() {
    final nextNumber = state.pages.length + 1;
    final newPage = ScanPage(
      id: 'page_$nextNumber',
      variant: MockDocumentVariant.invoice,
      filter: ScanFilter.vividLight,
      crop: CropQuad.mockAdjust(),
    );
    state = state.copyWith(pages: List<ScanPage>.from(state.pages)..add(newPage));
  }

  void rename(String name) {
    state = state.copyWith(docName: name.trim());
  }

  void goTo(int index) {
    if (index < 0 || index >= state.pages.length) return;
    state = state.copyWith(currentIndex: index);
  }

  void setShowCropAfterCapture(bool value) {
    state = state.copyWith(showCropAfterCapture: value);
  }

  void reset() {
    state = ScanSessionState(
      pages: ScanSessionState.createDefaultMockPages(),
      currentIndex: 1,
      docName: 'Doc Scanner 10 Oct 2026 7-49 pm',
      showCropAfterCapture: true,
    );
  }
}

/// Provider exposing [ScanSessionState].
final NotifierProvider<ScanSessionNotifier, ScanSessionState>
    scanSessionProvider =
    NotifierProvider<ScanSessionNotifier, ScanSessionState>(
        ScanSessionNotifier.new);

