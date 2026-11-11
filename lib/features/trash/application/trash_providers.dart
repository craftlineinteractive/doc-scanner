import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_trash_repository.dart';
import '../domain/trash_item.dart';
import '../domain/trash_repository.dart';

/// Provider for the TrashRepository dependency.
final Provider<TrashRepository> trashRepositoryProvider =
    Provider<TrashRepository>((ref) => const MockTrashRepository());

/// State class for the Trash feature.
class TrashState {
  const TrashState({
    required this.items,
    this.selectedIds = const <String>{},
    this.isSelecting = false,
    this.lastRestored = const <TrashItem>[],
    this.lastRestoredIndices = const <String, int>{},
  });

  final List<TrashItem> items;
  final Set<String> selectedIds;
  final bool isSelecting;
  final List<TrashItem> lastRestored;
  final Map<String, int> lastRestoredIndices;

  int get folderCount => items.where((item) => item.isFolder).length;
  int get documentCount => items.where((item) => !item.isFolder).length;
  bool get isEmpty => items.isEmpty;

  TrashState copyWith({
    List<TrashItem>? items,
    Set<String>? selectedIds,
    bool? isSelecting,
    List<TrashItem>? lastRestored,
    Map<String, int>? lastRestoredIndices,
  }) {
    return TrashState(
      items: items ?? this.items,
      selectedIds: selectedIds ?? this.selectedIds,
      isSelecting: isSelecting ?? this.isSelecting,
      lastRestored: lastRestored ?? this.lastRestored,
      lastRestoredIndices: lastRestoredIndices ?? this.lastRestoredIndices,
    );
  }
}

/// Riverpod 3.x Notifier managing trash items, batch selection, and restorations.
class TrashNotifier extends Notifier<TrashState> {
  @override
  TrashState build() {
    final TrashRepository repo = ref.watch(trashRepositoryProvider);
    return TrashState(items: repo.getTrashItems());
  }

  /// Restores a single item and returns it for toast dispatching.
  TrashItem? restore(String id) {
    final int index = state.items.indexWhere((item) => item.id == id);
    if (index == -1) return null;
    final TrashItem item = state.items[index];

    final List<TrashItem> nextItems = List<TrashItem>.from(state.items)
      ..removeAt(index);
    final Set<String> nextSelected = Set<String>.from(state.selectedIds)
      ..remove(id);

    state = state.copyWith(
      items: nextItems,
      selectedIds: nextSelected,
      isSelecting: nextSelected.isNotEmpty && state.isSelecting,
      lastRestored: <TrashItem>[item],
      lastRestoredIndices: <String, int>{id: index},
    );
    return item;
  }

  /// Restores all items in trash.
  List<TrashItem> restoreAll() {
    final List<TrashItem> all = List<TrashItem>.from(state.items);
    final Map<String, int> indices = <String, int>{
      for (int i = 0; i < all.length; i++) all[i].id: i,
    };

    state = state.copyWith(
      items: const <TrashItem>[],
      selectedIds: const <String>{},
      isSelecting: false,
      lastRestored: all,
      lastRestoredIndices: indices,
    );
    return all;
  }

  /// Re-inserts the last restored item(s) back into their prior index positions.
  void undoRestore() {
    if (state.lastRestored.isEmpty) return;

    final List<TrashItem> restoredItems = List<TrashItem>.from(state.items);
    for (final TrashItem item in state.lastRestored) {
      final int targetIndex = state.lastRestoredIndices[item.id] ?? 0;
      final int clampedIndex = targetIndex.clamp(0, restoredItems.length);
      restoredItems.insert(clampedIndex, item);
    }

    state = state.copyWith(
      items: restoredItems,
      lastRestored: const <TrashItem>[],
      lastRestoredIndices: const <String, int>{},
    );
  }

  /// Permanently removes the items with the provided IDs.
  void deleteForever(Set<String> ids) {
    final List<TrashItem> remaining = state.items
        .where((item) => !ids.contains(item.id))
        .toList();
    final Set<String> nextSelected = Set<String>.from(state.selectedIds)
      ..removeAll(ids);

    state = state.copyWith(
      items: remaining,
      selectedIds: nextSelected,
      isSelecting: nextSelected.isNotEmpty && state.isSelecting,
    );
  }

  /// Permanently empties all items from the trash.
  void emptyTrash() {
    state = state.copyWith(
      items: const <TrashItem>[],
      selectedIds: const <String>{},
      isSelecting: false,
    );
  }

  /// Toggles selection of an item.
  void toggleSelect(String id) {
    final Set<String> nextSelected = Set<String>.from(state.selectedIds);
    if (nextSelected.contains(id)) {
      nextSelected.remove(id);
    } else {
      nextSelected.add(id);
    }

    state = state.copyWith(
      selectedIds: nextSelected,
      isSelecting: nextSelected.isNotEmpty,
    );
  }

  /// Enters selection mode with the target item selected.
  void startSelect(String id) {
    state = state.copyWith(selectedIds: <String>{id}, isSelecting: true);
  }

  /// Selects all available items in the trash.
  void selectAll() {
    final Set<String> allIds = state.items.map((e) => e.id).toSet();
    state = state.copyWith(selectedIds: allIds, isSelecting: true);
  }

  /// Clears active selection and leaves selection mode.
  void clearSelection() {
    state = state.copyWith(selectedIds: const <String>{}, isSelecting: false);
  }
}

/// Provider for trash state and mutations.
final NotifierProvider<TrashNotifier, TrashState> trashProvider =
    NotifierProvider<TrashNotifier, TrashState>(TrashNotifier.new);
