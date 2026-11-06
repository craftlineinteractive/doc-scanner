import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';

/// 2nd-tier editing sub-toolbar (Crop, Filter, Rotate, Erase, Sign, Watermark, Close).
class PostScanEditToolbar extends StatelessWidget {
  const PostScanEditToolbar({
    super.key,
    required this.onCropTap,
    required this.onFilterTap,
    required this.onRotateTap,
    required this.onEraseTap,
    required this.onSignTap,
    required this.onWatermarkTap,
    required this.onCloseTap,
  });

  final VoidCallback onCropTap;
  final VoidCallback onFilterTap;
  final VoidCallback onRotateTap;
  final VoidCallback onEraseTap;
  final VoidCallback onSignTap;
  final VoidCallback onWatermarkTap;
  final VoidCallback onCloseTap;

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
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: <Widget>[
                _SubToolItem(
                  icon: Symbols.crop_rounded,
                  label: 'Crop',
                  onTap: onCropTap,
                ),
                _SubToolItem(
                  icon: Symbols.auto_fix_high_rounded,
                  label: 'Filter',
                  onTap: onFilterTap,
                ),
                _SubToolItem(
                  icon: Symbols.rotate_right_rounded,
                  label: 'Rotate',
                  onTap: onRotateTap,
                ),
                _SubToolItem(
                  icon: Symbols.ink_eraser_rounded,
                  label: 'Erase',
                  onTap: onEraseTap,
                ),
                _SubToolItem(
                  icon: Symbols.draw_rounded,
                  label: 'Sign',
                  onTap: onSignTap,
                ),
                _SubToolItem(
                  icon: Symbols.branding_watermark_rounded,
                  label: 'Watermark',
                  onTap: onWatermarkTap,
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Symbols.close_rounded, color: AppColors.textMuted),
            onPressed: onCloseTap,
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _SubToolItem extends StatelessWidget {
  const _SubToolItem({
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

