import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../application/review_ui_provider.dart';

/// Main bottom action bar for Scan Review offering 6 editing tools and document finalize action.
class ReviewBottomBar extends StatelessWidget {
  const ReviewBottomBar({
    super.key,
    required this.activeMode,
    required this.onTapCrop,
    required this.onTapColor,
    required this.onTapRotate,
    required this.onTapArrange,
    required this.onTapRetake,
    required this.onTapDelete,
    required this.onTapSave,
  });

  final ReviewToolbarMode activeMode;
  final VoidCallback onTapCrop;
  final VoidCallback onTapColor;
  final VoidCallback onTapRotate;
  final VoidCallback onTapArrange;
  final VoidCallback onTapRetake;
  final VoidCallback onTapDelete;
  final VoidCallback onTapSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFE2E5EE).withValues(alpha: 0.8),
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: <Widget>[
          // 6 Evenly Spaced Tools
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: _ReviewToolButton(
                    icon: Icons.crop_rounded,
                    label: 'Crop',
                    isSelected: activeMode == ReviewToolbarMode.crop,
                    onTap: onTapCrop,
                  ),
                ),
                Expanded(
                  child: _ReviewToolButton(
                    icon: Icons.palette_outlined,
                    label: 'Color',
                    isSelected: activeMode == ReviewToolbarMode.color,
                    onTap: onTapColor,
                  ),
                ),
                Expanded(
                  child: _ReviewToolButton(
                    icon: Icons.rotate_right_rounded,
                    label: 'Rotate',
                    onTap: onTapRotate,
                  ),
                ),
                Expanded(
                  child: _ReviewToolButton(
                    icon: Icons.grid_view_rounded,
                    label: 'Arrange',
                    onTap: onTapArrange,
                  ),
                ),
                Expanded(
                  child: _ReviewToolButton(
                    icon: Icons.camera_alt_outlined,
                    label: 'Retake',
                    onTap: onTapRetake,
                  ),
                ),
                Expanded(
                  child: _ReviewToolButton(
                    icon: Icons.delete_outline_rounded,
                    label: 'Delete',
                    isDestructive: true,
                    onTap: onTapDelete,
                  ),
                ),
              ],
            ),
          ),

          // Vertical divider
          Container(
            width: 1,
            height: 32,
            color: const Color(0xFFE2E5EE),
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),

          // Save / Finalize Button (48x48)
          SizedBox(
            width: 48,
            height: 48,
            child: ElevatedButton(
              onPressed: onTapSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                elevation: 2,
                shadowColor: AppColors.primary.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Icon(
                Icons.check_rounded,
                size: 24,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReviewToolButton extends StatelessWidget {
  const _ReviewToolButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color(0xFF1E2340);
    Color iconColor = const Color(0xFF1E2340);

    if (isDestructive) {
      textColor = const Color(0xFFE5484D);
      iconColor = const Color(0xFFE5484D);
    } else if (isSelected) {
      textColor = AppColors.primary;
      iconColor = AppColors.primary;
    }

    return Semantics(
      button: true,
      label: label,
      selected: isSelected,
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFEEF0FF) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: 20, color: iconColor),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
