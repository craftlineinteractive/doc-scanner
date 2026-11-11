import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_ocr_result.dart';
import '../domain/ocr_result.dart';

/// Immutable state for OCR result viewing and live text editing.
class OcrState {
  const OcrState({
    required this.result,
    this.isEditing = false,
    this.originalPreviewOpen = false,
  });

  final OcrResult result;
  final bool isEditing;
  final bool originalPreviewOpen;

  OcrState copyWith({
    OcrResult? result,
    bool? isEditing,
    bool? originalPreviewOpen,
  }) {
    return OcrState(
      result: result ?? this.result,
      isEditing: isEditing ?? this.isEditing,
      originalPreviewOpen: originalPreviewOpen ?? this.originalPreviewOpen,
    );
  }
}

/// Riverpod 3.x Notifier managing OCR text state.
class OcrNotifier extends Notifier<OcrState> {
  @override
  OcrState build() {
    return const OcrState(result: MockOcrResult.defaultResult);
  }

  void setEditing(bool editing) {
    state = state.copyWith(isEditing: editing);
  }

  void toggleEditing() {
    state = state.copyWith(isEditing: !state.isEditing);
  }

  void updateText(String newText) {
    final OcrResult updated = OcrResult(
      title: state.result.title,
      accuracyLabel: state.result.accuracyLabel,
      pageCount: state.result.pageCount,
      language: state.result.language,
      documentTag: state.result.documentTag,
      text: newText,
    );
    state = state.copyWith(result: updated);
  }

  void toggleOriginalPreview() {
    state = state.copyWith(originalPreviewOpen: !state.originalPreviewOpen);
  }

  void setOriginalPreviewOpen(bool open) {
    state = state.copyWith(originalPreviewOpen: open);
  }
}

final NotifierProvider<OcrNotifier, OcrState> ocrProvider =
    NotifierProvider<OcrNotifier, OcrState>(OcrNotifier.new);
