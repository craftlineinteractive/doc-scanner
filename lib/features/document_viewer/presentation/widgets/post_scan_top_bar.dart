import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';

/// Top bar for Post-Scan Viewer supporting normal, crop, and OCR modes.
class PostScanTopBar extends StatelessWidget implements PreferredSizeWidget {
  const PostScanTopBar({
    super.key,
    required this.title,
    required this.currentPage,
    required this.totalPages,
    required this.isCropMode,
    required this.isOcrActive,
    required this.isFavorite,
    required this.onBack,
    required this.onTitleTap,
    required this.onFavoriteToggle,
    required this.onMoreTap,
    required this.onCropApply,
    required this.onCropCancel,
  });

  final String title;
  final int currentPage;
  final int totalPages;
  final bool isCropMode;
  final bool isOcrActive;
  final bool isFavorite;
  final VoidCallback onBack;
  final VoidCallback onTitleTap;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onMoreTap;
  final VoidCallback onCropApply;
  final VoidCallback onCropCancel;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    if (isCropMode) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Symbols.close_rounded, color: AppColors.textPrimary),
          onPressed: onCropCancel,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Crop & Perspective',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.cameraDetection,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Auto Edge Detection ON',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Symbols.check_rounded, color: AppColors.primary),
            onPressed: onCropApply,
          ),
        ],
      );
    }

    if (isOcrActive) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_rounded, color: AppColors.textPrimary),
          onPressed: onBack,
        ),
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.successTint,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Symbols.verified_rounded, size: 16, color: AppColors.success),
              SizedBox(width: 4),
              Flexible(
                child: Text(
                  'OCR Extracted • 98% accuracy',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'More options',
            icon: const Icon(Symbols.more_vert_rounded, color: AppColors.textPrimary),
            onPressed: onMoreTap,
          ),
        ],
      );
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Symbols.arrow_back_rounded, color: AppColors.textPrimary),
        onPressed: onBack,
      ),
      titleSpacing: 0,
      title: InkWell(
        onTap: onTitleTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Symbols.edit_rounded,
                size: 14,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: AppColors.canvas,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$currentPage / $totalPages',
            style: const TextStyle(
              color: AppColors.textMuted,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: Icon(
            isFavorite ? Symbols.star_rounded : Symbols.star_outline_rounded,
            color: isFavorite ? AppColors.gold : AppColors.textMuted,
          ),
          onPressed: onFavoriteToggle,
        ),
        IconButton(
          tooltip: 'More options',
          icon: const Icon(Symbols.more_vert_rounded, color: AppColors.textPrimary),
          onPressed: onMoreTap,
        ),
      ],
    );
  }
}

