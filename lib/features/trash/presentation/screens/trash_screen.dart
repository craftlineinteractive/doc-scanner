import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dialogs/confirm_dialog.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/navigation/back_title_bar.dart';
import '../../application/trash_providers.dart';
import '../../domain/trash_item.dart';
import '../sheets/trash_item_options_sheet.dart';
import '../widgets/trash_card.dart';
import '../widgets/trash_empty_state.dart';
import '../widgets/trash_info_banner.dart';
import '../widgets/trash_selection_bottom_bar.dart';

/// Screen presenting deleted documents and folders with batch restore and cleanup.
class TrashScreen extends ConsumerStatefulWidget {
  const TrashScreen({
    super.key,
    this.initialState = 'list',
  });

  final String initialState;

  @override
  ConsumerState<TrashScreen> createState() => _TrashScreenState();
}

class _TrashScreenState extends ConsumerState<TrashScreen> {
  final GlobalKey _menuKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _applyInitialState());
  }

  void _applyInitialState() {
    final TrashNotifier notifier = ref.read(trashProvider.notifier);

    switch (widget.initialState) {
      case 'empty':
        notifier.emptyTrash();
        break;
      case 'selecting':
        notifier.toggleSelect('doc_1');
        notifier.toggleSelect('doc_2');
        break;
      case 'menu':
        _openTopMenu();
        break;
      case 'options':
        final List<TrashItem> items = ref.read(trashProvider).items;
        if (items.isNotEmpty) {
          _showItemOptions(items.firstWhere((i) => !i.isFolder, orElse: () => items.first));
        }
        break;
      case 'deleteDialog':
        _showDeleteForeverDialog(<String>{'doc_1'});
        break;
      case 'toast':
        _showRestoredToast(hasMissingFolder: false);
        break;
      case 'toastMissingFolder':
        _showRestoredToast(hasMissingFolder: true);
        break;
      default:
        break;
    }
  }

  void _openTopMenu() {
    final dynamic state = _menuKey.currentState;
    if (state != null && state is PopupMenuButtonState) {
      state.showButtonMenu();
    }
  }

  void _showItemOptions(TrashItem item) {
    TrashItemOptionsSheet.show(
      context,
      item: item,
      onRestore: () => _restoreSingleItem(item),
      onDeleteForever: () => _showDeleteForeverDialog(<String>{item.id}),
    );
  }

  void _restoreSingleItem(TrashItem item) {
    final TrashItem? restored = ref.read(trashProvider.notifier).restore(item.id);
    if (restored != null) {
      _showRestoredToast(hasMissingFolder: restored.originalFolderMissing);
    }
  }

  void _restoreSelected() {
    final TrashState state = ref.read(trashProvider);
    final Set<String> ids = Set<String>.from(state.selectedIds);
    bool missingFolder = false;

    for (final String id in ids) {
      final TrashItem? restored = ref.read(trashProvider.notifier).restore(id);
      if (restored != null && restored.originalFolderMissing) {
        missingFolder = true;
      }
    }
    _showRestoredToast(hasMissingFolder: missingFolder);
  }

  void _restoreAll() {
    final List<TrashItem> restored = ref.read(trashProvider.notifier).restoreAll();
    final bool missingFolder = restored.any((item) => item.originalFolderMissing);
    _showRestoredToast(hasMissingFolder: missingFolder);
  }

  void _showRestoredToast({required bool hasMissingFolder}) {
    showAppSnackbar(
      context: context,
      message: hasMissingFolder
          ? 'Original folder no longer exists. Restored to Home.'
          : 'Restored to Home',
      onUndo: () => ref.read(trashProvider.notifier).undoRestore(),
    );
  }

  Future<void> _showDeleteForeverDialog(Set<String> targetIds) async {
    final bool multi = targetIds.length > 1;
    final bool? confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Delete forever?',
      message: multi
          ? "These items will be permanently deleted. This can't be undone."
          : "This document will be permanently deleted. This can't be undone.",
      confirmLabel: 'Delete',
      isDestructive: true,
    );

    if (confirmed == true) {
      ref.read(trashProvider.notifier).deleteForever(targetIds);
    }
  }

  Future<void> _showEmptyTrashDialog() async {
    final bool? confirmed = await ConfirmDialog.show(
      context: context,
      title: 'Empty trash?',
      message: "All items will be permanently deleted. This can't be undone.",
      confirmLabel: 'Delete',
      isDestructive: true,
    );

    if (confirmed == true) {
      ref.read(trashProvider.notifier).emptyTrash();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TrashState state = ref.watch(trashProvider);
    final TrashNotifier notifier = ref.read(trashProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: state.isSelecting
          ? _buildSelectionAppBar(state, notifier)
          : _buildStandardAppBar(state, notifier),
      body: state.isEmpty
          ? const TrashEmptyState()
          : _buildTrashList(state, notifier),
      bottomNavigationBar: state.isSelecting
          ? TrashSelectionBottomBar(
              selectedCount: state.selectedIds.length,
              onRestore: _restoreSelected,
              onDeleteForever: () =>
                  _showDeleteForeverDialog(state.selectedIds),
            )
          : null,
    );
  }

  PreferredSizeWidget _buildStandardAppBar(
    TrashState state,
    TrashNotifier notifier,
  ) {
    return BackTitleBar(
      title: 'Trash',
      actions: <Widget>[
        if (state.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Symbols.more_vert_rounded,
              color: Color(0xFFCBD5E1),
              size: 20,
            ),
          )
        else
          PopupMenuButton<String>(
            key: _menuKey,
            icon: const Icon(
              Symbols.more_vert_rounded,
              color: AppColors.textPrimary,
              size: 20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            onSelected: (String action) {
              if (action == 'select') {
                if (state.items.isNotEmpty) {
                  notifier.startSelect(state.items.first.id);
                }
              } else if (action == 'restore_all') {
                _restoreAll();
              } else if (action == 'empty_trash') {
                _showEmptyTrashDialog();
              }
            },
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'select',
                child: Row(
                  children: <Widget>[
                    Icon(Symbols.checklist_rounded, size: 18, color: AppColors.textMuted),
                    SizedBox(width: 12),
                    Text('Select', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const PopupMenuDivider(height: 1),
              const PopupMenuItem<String>(
                value: 'restore_all',
                child: Row(
                  children: <Widget>[
                    Icon(Symbols.restore_from_trash_rounded, size: 18, color: AppColors.textMuted),
                    SizedBox(width: 12),
                    Text('Restore all', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const PopupMenuDivider(height: 1),
              const PopupMenuItem<String>(
                value: 'empty_trash',
                child: Row(
                  children: <Widget>[
                    Icon(Symbols.delete_forever_rounded, size: 18, color: AppColors.destructive),
                    SizedBox(width: 12),
                    Text(
                      'Empty trash',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.destructive,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }

  PreferredSizeWidget _buildSelectionAppBar(
    TrashState state,
    TrashNotifier notifier,
  ) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        icon: const Icon(Symbols.close_rounded, color: AppColors.textPrimary),
        onPressed: notifier.clearSelection,
      ),
      title: Text(
        '${state.selectedIds.length} selected',
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Symbols.select_all_rounded,
            color: AppColors.primary,
          ),
          tooltip: 'Select all',
          onPressed: notifier.selectAll,
        ),
      ],
    );
  }

  Widget _buildTrashList(TrashState state, TrashNotifier notifier) {
    final List<TrashItem> folders =
        state.items.where((i) => i.isFolder).toList();
    final List<TrashItem> docs =
        state.items.where((i) => !i.isFolder).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: <Widget>[
        const TrashInfoBanner(),
        const SizedBox(height: 14),

        if (folders.isNotEmpty) ...<Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              'FOLDERS (${folders.length})',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ...folders.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TrashCard(
                item: item,
                isSelecting: state.isSelecting,
                isSelected: state.selectedIds.contains(item.id),
                onTap: () {
                  if (state.isSelecting) {
                    notifier.toggleSelect(item.id);
                  } else {
                    _showItemOptions(item);
                  }
                },
                onLongPress: () => notifier.startSelect(item.id),
                onOptionsTap: () => _showItemOptions(item),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],

        if (docs.isNotEmpty) ...<Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(
              'DOCUMENTS (${docs.length})',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
                letterSpacing: 0.8,
              ),
            ),
          ),
          ...docs.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TrashCard(
                item: item,
                isSelecting: state.isSelecting,
                isSelected: state.selectedIds.contains(item.id),
                onTap: () {
                  if (state.isSelecting) {
                    notifier.toggleSelect(item.id);
                  } else {
                    _showItemOptions(item);
                  }
                },
                onLongPress: () => notifier.startSelect(item.id),
                onOptionsTap: () => _showItemOptions(item),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

