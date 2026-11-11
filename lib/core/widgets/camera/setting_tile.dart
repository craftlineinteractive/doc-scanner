import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

/// Interactive tile in the camera settings panel grid.
class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.isActive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? value;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = isActive ? AppColors.cameraAccent : Colors.white;
    final valueColor = isActive
        ? AppColors.cameraAccentLight
        : const Color(0xFFD1D5DB);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 80,
          minHeight: 64,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 24,
                color: iconColor,
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  label,
                  style: AppTypography.labelSm.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value ?? '—',
                style: AppTypography.labelSm.copyWith(
                  color: value == null || value == '—'
                      ? Colors.transparent
                      : valueColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
