import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/chips/days_left_chip.dart';
import '../../../../core/widgets/mock/mock_document_page.dart';
import '../../domain/trash_item.dart';

/// Card row rendering either a deleted folder or document in the Trash list.
class TrashCard extends StatelessWidget {
  const TrashCard({
    super.key,
    required this.item,
    this.isSelecting = false,
    this.isSelected = false,
    required this.onTap,
    this.onLongPress,
    this.onOptionsTap,
  });

  final TrashItem item;
  final bool isSelecting;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onOptionsTap;

  @override
  Widget build(BuildContext context) {
    final BoxDecoration decoration = isSelected
        ? BoxDecoration(
            color: const Color(0xFFF8F9FF),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary, width: 2),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(79, 70, 229, 0.08),
                offset: Offset(0, 2),
                blurRadius: 12,
              ),
            ],
          )
        : BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.hairline),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color.fromRGBO(30, 35, 64, 0.04),
                offset: Offset(0, 2),
                blurRadius: 8,
              ),
            ],
          );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: decoration,
          child: Row(
            children: <Widget>[
              if (isSelecting) ...<Widget>[
                _SelectionIndicator(isSelected: isSelected),
                const SizedBox(width: 12),
              ],
              _buildThumbnail(),
              const SizedBox(width: 12),
              Expanded(
                child: isSelecting
                    ? _buildSelectingMetadata()
                    : _buildDefaultMetadata(),
              ),
              if (!isSelecting && onOptionsTap != null)
                IconButton(
                  icon: const Icon(
                    Symbols.more_vert_rounded,
                    size: 18,
                    color: AppColors.textMuted,
                  ),
                  onPressed: onOptionsTap,
                  tooltip: 'Options',
                  splashRadius: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    if (item.isFolder) {
      return Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primaryTint,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Icon(
            Symbols.folder_rounded,
            color: AppColors.primary,
            size: 28,
          ),
        ),
      );
    }

    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.hairline),
      ),
      padding: const EdgeInsets.all(4),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          MockDocumentPage(variant: item.variant, showBorder: false),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white.withValues(alpha: 0.85),
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                item.typeBadge,
                style: const TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                  letterSpacing: 0.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultMetadata() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          item.isFolder
              ? 'Folder, ${item.itemCount ?? 0} items'
              : item.deletedLabel,
          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 4,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            if (!item.isFolder && item.pageCount != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${item.pageCount} ${item.pageCount == 1 ? "page" : "pages"}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                ),
              )
            else if (item.isFolder)
              Text(
                item.deletedLabel,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            DaysLeftChip(daysRemaining: item.daysLeft),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectingMetadata() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          item.title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          item.isFolder
              ? 'Folder, ${item.itemCount ?? 0} items'
              : '${item.shortDeletedLabel}${item.pageCount != null ? " • ${item.pageCount} ${item.pageCount == 1 ? "page" : "pages"}" : ""}',
          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        DaysLeftChip(daysRemaining: item.daysLeft),
      ],
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(Symbols.check_rounded, size: 14, color: Colors.white),
        ),
      );
    }

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFCBD5E1), width: 2),
      ),
    );
  }
}
