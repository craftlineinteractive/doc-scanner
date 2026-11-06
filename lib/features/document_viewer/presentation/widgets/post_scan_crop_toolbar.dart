import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../scan_review/domain/crop_shape.dart';

/// 3rd-tier elevated crop toolbar with aspect ratios, auto detect, flip, and apply.
class PostScanCropToolbar extends StatelessWidget {
  const PostScanCropToolbar({
    super.key,
    required this.selectedShape,
    required this.onShapeSelected,
    required this.onAutoDetect,
    required this.onFlip,
    required this.onCancel,
    required this.onApply,
  });

  final CropShape selectedShape;
  final ValueChanged<CropShape> onShapeSelected;
  final VoidCallback onAutoDetect;
  final VoidCallback onFlip;
  final VoidCallback onCancel;
  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.hairline)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _AspectPill(
                  label: 'Free',
                  isSelected: selectedShape == CropShape.free,
                  onTap: () => onShapeSelected(CropShape.free),
                ),
                _AspectPill(
                  label: 'Original',
                  isSelected: selectedShape == CropShape.original,
                  onTap: () => onShapeSelected(CropShape.original),
                ),
                _AspectPill(
                  label: 'A4',
                  isSelected: selectedShape == CropShape.a4,
                  onTap: () => onShapeSelected(CropShape.a4),
                ),
                _ActionChip(
                  icon: Symbols.auto_fix_high_rounded,
                  label: 'Auto',
                  onTap: onAutoDetect,
                ),
                _ActionChip(
                  icon: Symbols.flip_rounded,
                  label: 'Flip',
                  onTap: onFlip,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Symbols.close_rounded, color: AppColors.textMuted),
            onPressed: onCancel,
          ),
          IconButton(
            icon: const Icon(Symbols.check_rounded, color: AppColors.primary),
            onPressed: onApply,
          ),
        ],
      ),
    );
  }
}

class _AspectPill extends StatelessWidget {
  const _AspectPill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryTint : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            child: Row(
              children: <Widget>[
                Icon(icon, size: 14, color: AppColors.textPrimary),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
