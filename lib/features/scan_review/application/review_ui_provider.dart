import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/crop_quad.dart';
import '../domain/scan_filter.dart';

/// Active bottom sub-mode in Review screen.
enum ReviewToolbarMode {
  none,
  crop,
  color,
}

/// In-memory UI state for Review screen sub-modes and draft edits.
class ReviewUiState {
  const ReviewUiState({
    this.mode = ReviewToolbarMode.none,
    this.applyToAll = false,
    this.draftCrop,
    this.draftFilter,
  });

  final ReviewToolbarMode mode;
  final bool applyToAll;
  final CropQuad? draftCrop;
  final ScanFilter? draftFilter;

  ReviewUiState copyWith({
    ReviewToolbarMode? mode,
    bool? applyToAll,
    CropQuad? draftCrop,
    ScanFilter? draftFilter,
    bool clearDrafts = false,
  }) {
    return ReviewUiState(
      mode: mode ?? this.mode,
      applyToAll: applyToAll ?? this.applyToAll,
      draftCrop: clearDrafts ? null : (draftCrop ?? this.draftCrop),
      draftFilter: clearDrafts ? null : (draftFilter ?? this.draftFilter),
    );
  }
}

/// Notifier managing active review sub-mode (none, crop, color) and drafts.
class ReviewUiNotifier extends Notifier<ReviewUiState> {
  @override
  ReviewUiState build() {
    return const ReviewUiState();
  }

  void setMode(ReviewToolbarMode mode) {
    state = state.copyWith(mode: mode);
  }

  void toggleApplyToAll() {
    state = state.copyWith(applyToAll: !state.applyToAll);
  }

  void setApplyToAll(bool value) {
    state = state.copyWith(applyToAll: value);
  }

  void setDraftCrop(CropQuad quad) {
    state = state.copyWith(draftCrop: quad);
  }

  void setDraftFilter(ScanFilter filter) {
    state = state.copyWith(draftFilter: filter);
  }

  void resetMode() {
    state = const ReviewUiState();
  }
}

/// Provider for [ReviewUiState].
final NotifierProvider<ReviewUiNotifier, ReviewUiState> reviewUiProvider =
    NotifierProvider<ReviewUiNotifier, ReviewUiState>(ReviewUiNotifier.new);

