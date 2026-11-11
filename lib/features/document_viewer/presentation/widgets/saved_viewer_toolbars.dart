import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/viewer_tool_tier.dart';

/// Main 6-tool bottom bar for Saved Document Viewer matching Frame 1.
class SavedViewerMainToolbar extends StatelessWidget {
  const SavedViewerMainToolbar({
    super.key,
    required this.currentTier,
    required this.onEditTap,
    required this.onEditAllTap,
    required this.onOpenPdfTap,
    required this.onShareTap,
    required this.onSaveTap,
    required this.onRetakeTap,
  });

  final ViewerToolTier currentTier;
  final VoidCallback onEditTap;
  final VoidCallback onEditAllTap;
  final VoidCallback onOpenPdfTap;
  final VoidCallback onShareTap;
  final VoidCallback onSaveTap;
  final VoidCallback onRetakeTap;

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
          _SavedToolItem(
            icon: Symbols.edit_rounded,
            label: 'Edit',
            isActive:
                currentTier == ViewerToolTier.edit ||
                currentTier == ViewerToolTier.crop,
            onTap: onEditTap,
          ),
          _SavedToolItem(
            icon: Symbols.edit_document_rounded,
            label: 'Edit All',
            onTap: onEditAllTap,
          ),
          _SavedToolItem(
            icon: Symbols.picture_as_pdf_rounded,
            label: 'Open PDF',
            isActive: currentTier == ViewerToolTier.pdf,
            onTap: onOpenPdfTap,
          ),
          _SavedToolItem(
            icon: Symbols.share_rounded,
            label: 'Share',
            onTap: onShareTap,
          ),
          _SavedToolItem(
            icon: Symbols.download_rounded,
            label: 'Save',
            onTap: onSaveTap,
          ),
          _SavedToolItem(
            icon: Symbols.photo_camera_rounded,
            label: 'Retake',
            onTap: onRetakeTap,
          ),
        ],
      ),
    );
  }
}

class _SavedToolItem extends StatelessWidget {
  const _SavedToolItem({
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
    final Color foreground = isActive
        ? AppColors.primary
        : AppColors.textPrimary;
    final Color? background = isActive ? AppColors.primaryTint : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
      child: Material(
        color: background ?? Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: 60,
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
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
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

/// PDF sub-tool row for Saved Document Viewer Frame 5.
class SavedViewerPdfSubToolbar extends StatelessWidget {
  const SavedViewerPdfSubToolbar({
    super.key,
    required this.onCompress,
    required this.onWatermark,
    required this.onFitType,
    required this.onPageSize,
    required this.onOrientation,
    required this.onMore,
  });

  final VoidCallback onCompress;
  final VoidCallback onWatermark;
  final VoidCallback onFitType;
  final VoidCallback onPageSize;
  final VoidCallback onOrientation;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        border: Border(top: BorderSide(color: AppColors.hairline)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: <Widget>[
          _PdfToolAction(
            icon: Symbols.compress_rounded,
            label: 'Compress',
            onTap: onCompress,
          ),
          _PdfToolAction(
            icon: Symbols.branding_watermark_rounded,
            label: 'Watermark',
            onTap: onWatermark,
          ),
          _PdfToolAction(
            icon: Symbols.fit_screen_rounded,
            label: 'Fit Type',
            onTap: onFitType,
          ),
          _PdfToolAction(
            icon: Symbols.aspect_ratio_rounded,
            label: 'Page Size',
            onTap: onPageSize,
          ),
          _PdfToolAction(
            icon: Symbols.screen_rotation_rounded,
            label: 'Orientation',
            onTap: onOrientation,
          ),
          _PdfToolAction(
            icon: Symbols.more_horiz_rounded,
            label: 'More',
            onTap: onMore,
          ),
        ],
      ),
    );
  }
}

class _PdfToolAction extends StatelessWidget {
  const _PdfToolAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 20, color: AppColors.textPrimary),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
