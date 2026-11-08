import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/trash_item.dart';

/// Bottom sheet presenting quick actions for a single trash item.
class TrashItemOptionsSheet extends StatelessWidget {
  const TrashItemOptionsSheet({
    super.key,
    required this.item,
    required this.onRestore,
    required this.onDeleteForever,
  });

  final TrashItem item;
  final VoidCallback onRestore;
  final VoidCallback onDeleteForever;

  static Future<void> show(
    BuildContext context, {
    required TrashItem item,
    required VoidCallback onRestore,
    required VoidCallback onDeleteForever,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => TrashItemOptionsSheet(
        item: item,
        onRestore: onRestore,
        onDeleteForever: onDeleteForever,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'ITEM OPTIONS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.hairline),
            ListTile(
              leading: const Icon(
                Symbols.restore_from_trash_rounded,
                color: AppColors.primary,
                size: 22,
              ),
              title: const Text(
                'Restore',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                onRestore();
              },
            ),
            const Divider(height: 1, color: AppColors.hairline),
            ListTile(
              leading: const Icon(
                Symbols.delete_forever_rounded,
                color: AppColors.destructive,
                size: 22,
              ),
              title: const Text(
                'Delete forever',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.destructive,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                onDeleteForever();
              },
            ),
          ],
        ),
      ),
    );
  }
}

