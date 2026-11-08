import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';

/// Floating bottom action bar displayed when multi-selection mode is active in Trash.
class TrashSelectionBottomBar extends StatelessWidget {
  const TrashSelectionBottomBar({
    super.key,
    required this.selectedCount,
    required this.onRestore,
    required this.onDeleteForever,
  });

  final int selectedCount;
  final VoidCallback onRestore;
  final VoidCallback onDeleteForever;

  @override
  Widget build(BuildContext context) {
    final bool hasSelection = selectedCount > 0;

    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            offset: Offset(0, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: <Widget>[
            Expanded(
              child: InkWell(
                onTap: hasSelection ? onRestore : null,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Symbols.restore_from_trash_rounded,
                        color: hasSelection
                            ? AppColors.primary
                            : AppColors.textMuted.withValues(alpha: 0.5),
                        size: 20,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Restore',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: hasSelection
                              ? AppColors.primary
                              : AppColors.textMuted.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 32,
              color: AppColors.hairline,
            ),
            Expanded(
              child: InkWell(
                onTap: hasSelection ? onDeleteForever : null,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Symbols.delete_forever_rounded,
                        color: hasSelection
                            ? AppColors.destructive
                            : AppColors.textMuted.withValues(alpha: 0.5),
                        size: 20,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Delete forever',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: hasSelection
                              ? AppColors.destructive
                              : AppColors.textMuted.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

