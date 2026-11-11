import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../constants/app_durations.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_shadows.dart';

/// Signature floating dual action capsule (56px high) housing Camera scan and Plus import actions.
class DualPillFab extends StatefulWidget {
  const DualPillFab({
    super.key,
    required this.onCameraTap,
    required this.onPlusTap,
  });

  final VoidCallback onCameraTap;
  final VoidCallback onPlusTap;

  @override
  State<DualPillFab> createState() => _DualPillFabState();
}

class _DualPillFabState extends State<DualPillFab> {
  bool _isPressedCamera = false;
  bool _isPressedPlus = false;

  @override
  Widget build(BuildContext context) {
    final bool isAnyPressed = _isPressedCamera || _isPressedPlus;

    return AnimatedScale(
      scale: isAnyPressed ? 0.96 : 1.0,
      duration: AppDurations.fast,
      curve: Curves.easeOutCubic,
      child: Container(
        height: 56,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: AppRadii.roundedPill,
          boxShadow: AppShadows.level3,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: AppRadii.roundedPill,
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Left: Camera Scan
              InkWell(
                onTapDown: (_) => setState(() => _isPressedCamera = true),
                onTapUp: (_) => setState(() => _isPressedCamera = false),
                onTapCancel: () => setState(() => _isPressedCamera = false),
                onTap: widget.onCameraTap,
                child: const SizedBox(
                  width: 68,
                  height: 56,
                  child: Center(
                    child: Icon(
                      Symbols.photo_camera_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),

              // Vertical divider
              Container(
                width: 1,
                height: 24,
                color: Colors.white.withValues(alpha: 0.25),
              ),

              // Right: Plus Action
              InkWell(
                onTapDown: (_) => setState(() => _isPressedPlus = true),
                onTapUp: (_) => setState(() => _isPressedPlus = false),
                onTapCancel: () => setState(() => _isPressedPlus = false),
                onTap: widget.onPlusTap,
                child: const SizedBox(
                  width: 68,
                  height: 56,
                  child: Center(
                    child: Icon(
                      Symbols.add_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
