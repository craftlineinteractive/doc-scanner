import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../domain/scan_filter.dart';

/// Control panels for Adjust screen: filter dropdown, 3 tools, crop toggle, and action buttons.
class AdjustControls extends StatelessWidget {
  const AdjustControls({
    super.key,
    required this.currentFilter,
    required this.showCropAfterCapture,
    required this.onOpenFilters,
    required this.onRotate,
    required this.onOpenCropShape,
    required this.onOpenDocName,
    required this.onToggleCropAfterCapture,
    required this.onRetake,
    required this.onContinue,
  });

  final ScanFilter currentFilter;
  final bool showCropAfterCapture;
  final VoidCallback onOpenFilters;
  final VoidCallback onRotate;
  final VoidCallback onOpenCropShape;
  final VoidCallback onOpenDocName;
  final ValueChanged<bool> onToggleCropAfterCapture;
  final VoidCallback onRetake;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Filter selection row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'FILTER',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8A90A6),
                  letterSpacing: 0.8,
                ),
              ),
              InkWell(
                onTap: onOpenFilters,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        currentFilter.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white70,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Tools row (Rotate, Crop, Doc Name)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _ToolItem(
                    icon: Icons.rotate_right_rounded,
                    label: 'Rotate',
                    onTap: onRotate,
                  ),
                ),
                Expanded(
                  child: _ToolItem(
                    icon: Icons.crop_rounded,
                    label: 'Crop',
                    onTap: onOpenCropShape,
                  ),
                ),
                Expanded(
                  child: _ToolItem(
                    icon: Icons.edit_note_rounded,
                    label: 'Doc Name',
                    onTap: onOpenDocName,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Show crop screen after every capture toggle row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Row(
                children: <Widget>[
                  Icon(
                    Icons.settings_outlined,
                    size: 16,
                    color: Color(0xFF8A90A6),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Show crop screen after every capture',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8A90A6),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Transform.scale(
                scale: 0.8,
                child: Switch(
                  value: showCropAfterCapture,
                  onChanged: onToggleCropAfterCapture,
                  activeTrackColor: AppColors.primary,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.white24,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Retake & Continue action buttons
          Row(
            children: <Widget>[
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: OutlinedButton(
                    onPressed: onRetake,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Retake',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: onContinue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: AppColors.primary.withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _ToolItem extends StatelessWidget {
  const _ToolItem({
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
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 3),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
