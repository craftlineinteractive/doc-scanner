import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';

/// 9-tool horizontal scroll bottom bar for Post-Scan Viewer.
class PostScanMainToolbar extends StatelessWidget {
  const PostScanMainToolbar({
    super.key,
    required this.isEditActive,
    required this.onEditTap,
    required this.onOpenPdfTap,
    required this.onShareTap,
    required this.onRetakeTap,
    required this.onPrintTap,
    required this.onCopyTextTap,
    required this.onImageToTap,
    required this.onRotateTap,
    required this.onMoreTap,
  });

  final bool isEditActive;
  final VoidCallback onEditTap;
  final VoidCallback onOpenPdfTap;
  final VoidCallback onShareTap;
  final VoidCallback onRetakeTap;
  final VoidCallback onPrintTap;
  final VoidCallback onCopyTextTap;
  final VoidCallback onImageToTap;
  final VoidCallback onRotateTap;
  final VoidCallback onMoreTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.hairline)),
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: <Widget>[
          _ToolbarItem(
            icon: Symbols.edit_rounded,
            label: 'Edit',
            isActive: isEditActive,
            onTap: onEditTap,
          ),
          _ToolbarItem(
            icon: Symbols.picture_as_pdf_rounded,
            label: 'Open PDF',
            onTap: onOpenPdfTap,
          ),
          _ToolbarItem(
            icon: Symbols.share_rounded,
            label: 'Share',
            onTap: onShareTap,
          ),
          _ToolbarItem(
            icon: Symbols.photo_camera_rounded,
            label: 'Retake',
            onTap: onRetakeTap,
          ),
          _ToolbarItem(
            icon: Symbols.print_rounded,
            label: 'Print',
            onTap: onPrintTap,
          ),
          _ToolbarItem(
            icon: Symbols.document_scanner_rounded,
            label: 'Copy Text',
            onTap: onCopyTextTap,
          ),
          _ToolbarItem(
            icon: Symbols.image_rounded,
            label: 'Image To',
            onTap: onImageToTap,
          ),
          _ToolbarItem(
            icon: Symbols.rotate_right_rounded,
            label: 'Rotate',
            onTap: onRotateTap,
          ),
          _ToolbarItem(
            icon: Symbols.more_horiz_rounded,
            label: 'More',
            onTap: onMoreTap,
          ),
        ],
      ),
    );
  }
}

class _ToolbarItem extends StatelessWidget {
  const _ToolbarItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final Color foreground =
        isActive ? AppColors.primary : AppColors.textPrimary;
    final Color? background = isActive ? AppColors.primaryTint : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
      child: Material(
        color: background ?? Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 62,
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon, size: 22, color: foreground),
                const SizedBox(height: 3),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight:
                        isActive ? FontWeight.w700 : FontWeight.w500,
                    color: foreground,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

