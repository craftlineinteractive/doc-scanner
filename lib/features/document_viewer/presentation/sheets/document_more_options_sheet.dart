import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../domain/saved_document.dart';
import 'document_details_sheet.dart';

/// Bottom sheet displaying 7 document actions matching Frame 05.
class DocumentMoreOptionsSheet extends StatelessWidget {
  const DocumentMoreOptionsSheet({
    super.key,
    required this.document,
    required this.onRename,
    required this.onFavoriteToggle,
  });

  final SavedDocument document;
  final VoidCallback onRename;
  final VoidCallback onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Drag handle
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.hairline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primaryTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Symbols.description_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        document.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${document.pageCount} Pages • ${document.sizeMb.toStringAsFixed(1)} MB • ${document.scannedLabel}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.hairline, height: 1),

          // Action rows
          _ActionRow(
            icon: Symbols.edit_rounded,
            label: 'Rename Document',
            onTap: onRename,
          ),
          _ActionRow(
            icon: Symbols.drive_file_move_rounded,
            label: 'Move to Folder',
            onTap: () {
              Navigator.of(context).pop();
              showAppSnackbar(
                context: context,
                message: 'Moved to Folder: Documents',
              );
            },
          ),
          _ActionRow(
            icon: document.isFavorite
                ? Symbols.star_rounded
                : Symbols.star_outline_rounded,
            iconColor: document.isFavorite ? AppColors.gold : null,
            label: document.isFavorite
                ? 'Remove from Favorites'
                : 'Add to Favorites',
            onTap: onFavoriteToggle,
          ),
          _ActionRow(
            icon: Symbols.auto_stories_rounded,
            label: 'Manual Adjust / Reorder Pages',
            onTap: () {
              Navigator.of(context).pop();
              context.push(AppRoutes.arrangePages);
            },
          ),
          _ActionRow(
            icon: Symbols.image_rounded,
            label: 'Image To (JPEG / PNG)',
            onTap: () {
              Navigator.of(context).pop();
              showAppSnackbar(
                context: context,
                message: 'Exported all pages to Gallery',
              );
            },
          ),
          _ActionRow(
            icon: Symbols.info_rounded,
            label: 'Document Details & Info',
            onTap: () {
              Navigator.of(context).pop();
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (BuildContext ctx) =>
                    DocumentDetailsSheet(document: document),
              );
            },
          ),
          _ActionRow(
            icon: Symbols.delete_rounded,
            iconColor: AppColors.destructive,
            labelColor: AppColors.destructive,
            label: 'Delete Document',
            onTap: () {
              Navigator.of(context).pop();
              showAppSnackbar(
                context: context,
                message: 'Document moved to Trash',
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 20,
              color: iconColor ?? AppColors.textPrimary,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: labelColor ?? AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(
              Symbols.chevron_right_rounded,
              size: 18,
              color: AppColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

