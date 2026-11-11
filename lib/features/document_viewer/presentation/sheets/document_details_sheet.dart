import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/saved_document.dart';

/// Modal bottom sheet showing complete document metadata and file properties.
class DocumentDetailsSheet extends StatelessWidget {
  const DocumentDetailsSheet({super.key, required this.document});

  final SavedDocument document;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Drag handle
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.hairline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Document Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Symbols.close_rounded, size: 20),
                  onPressed: () => Navigator.of(context).pop(),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(color: AppColors.hairline, height: 1),
          const SizedBox(height: 8),

          // Info rows
          _DetailTile(
            label: 'Document Title',
            value: document.title,
            icon: Symbols.title_rounded,
          ),
          _DetailTile(
            label: 'Pages Count',
            value: '${document.pageCount} Pages',
            icon: Symbols.file_copy_rounded,
          ),
          _DetailTile(
            label: 'Estimated Size',
            value: '${document.sizeMb.toStringAsFixed(1)} MB',
            icon: Symbols.analytics_rounded,
          ),
          _DetailTile(
            label: 'Folder Location',
            value: document.folderName,
            icon: Symbols.folder_rounded,
          ),
          _DetailTile(
            label: 'Resolution',
            value: '${document.dpi} DPI (High Quality)',
            icon: Symbols.high_quality_rounded,
          ),
          _DetailTile(
            label: 'Storage Path',
            value: document.storagePath,
            icon: Symbols.sd_card_rounded,
          ),
          _DetailTile(
            label: 'Cloud Status',
            value: document.isSynced ? 'Synced to Cloud' : 'Device Local Only',
            icon: Symbols.cloud_done_rounded,
          ),
        ],
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 20, color: AppColors.textMuted),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
