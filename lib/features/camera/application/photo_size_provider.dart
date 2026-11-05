import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_photo_sizes.dart';
import '../domain/photo_size.dart';

/// Immutable state holding the active photo size selection and the presets list.
class PhotoSizeState {
  const PhotoSizeState({
    required this.selectedSize,
    required this.sizes,
  });

  final PhotoSize selectedSize;
  final List<PhotoSize> sizes;

  PhotoSizeState copyWith({
    PhotoSize? selectedSize,
    List<PhotoSize>? sizes,
  }) {
    return PhotoSizeState(
      selectedSize: selectedSize ?? this.selectedSize,
      sizes: sizes ?? this.sizes,
    );
  }
}

/// State notifier managing photo size presets for ID Photo Editor.
class PhotoSizeNotifier extends Notifier<PhotoSizeState> {
  @override
  PhotoSizeState build() {
    return const PhotoSizeState(
      selectedSize: MockPhotoSizes.defaultSelected,
      sizes: MockPhotoSizes.defaultSizes,
    );
  }

  void selectSize(PhotoSize size) {
    state = state.copyWith(selectedSize: size);
  }

  void setSizes(List<PhotoSize> sizes) {
    state = state.copyWith(sizes: List<PhotoSize>.from(sizes));
  }

  void removeSize(String id) {
    final updatedList = state.sizes.where((s) => s.id != id).toList();
    PhotoSize newSelected = state.selectedSize;
    if (newSelected.id == id && updatedList.isNotEmpty) {
      newSelected = updatedList.first;
    }
    state = state.copyWith(sizes: updatedList, selectedSize: newSelected);
  }

  void reorderSizes(int oldIndex, int newIndex) {
    final updatedList = List<PhotoSize>.from(state.sizes);
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = updatedList.removeAt(oldIndex);
    updatedList.insert(newIndex, item);
    state = state.copyWith(sizes: updatedList);
  }

  void addCustomSize({
    String label = 'Custom 40 x 60 MM',
    String detail = 'DPI 300',
  }) {
    final newId = 'custom_${DateTime.now().millisecondsSinceEpoch}';
    final customSize = PhotoSize(
      id: newId,
      label: label,
      detail: detail,
      isCustom: true,
    );
    final updatedList = List<PhotoSize>.from(state.sizes)..add(customSize);
    state = state.copyWith(sizes: updatedList, selectedSize: customSize);
  }
}

/// Provider exposing [PhotoSizeState].
final NotifierProvider<PhotoSizeNotifier, PhotoSizeState> photoSizeProvider =
    NotifierProvider<PhotoSizeNotifier, PhotoSizeState>(PhotoSizeNotifier.new);

