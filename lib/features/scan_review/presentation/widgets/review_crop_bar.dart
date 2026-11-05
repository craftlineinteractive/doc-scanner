import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Secondary action toolbar displayed when Crop sub-mode is active in Scan Review.
class ReviewCropBar extends StatelessWidget {
  const ReviewCropBar({
    super.key,
    required this.onFreeCrop,
    required this.onAutoDetect,
    required this.onFlip,
    required this.onCancel,
    required this.onConfirm,
  });

  final VoidCallback onFreeCrop;
  final VoidCallback onAutoDetect;
  final VoidCallback onFlip;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE2E5EE)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              _SubToolItem(
                icon: Icons.crop_rounded,
                label: 'Free',
                isSelected: true,
                onTap: onFreeCrop,
              ),
              const SizedBox(width: 24),
              _SubToolItem(
                icon: Icons.auto_awesome_rounded,
                label: 'Auto Detect',
                isSelected: false,
                onTap: onAutoDetect,
              ),
              const SizedBox(width: 24),
              _SubToolItem(
                icon: Icons.flip_rounded,
                label: 'Flip',
                isSelected: false,
                onTap: onFlip,
              ),
            ],
          ),
          Row(
            children: <Widget>[
              InkWell(
                onTap: onCancel,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE2E5EE)),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: Color(0xFF8A90A6),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: onConfirm,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubToolItem extends StatelessWidget {
  const _SubToolItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? AppColors.primary : const Color(0xFF1E2340);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 20, color: color),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
