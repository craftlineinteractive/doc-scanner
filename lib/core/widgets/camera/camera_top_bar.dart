import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_colors.dart';
import '../buttons/icon_circle_button.dart';

/// Flash states available for camera capture.
enum CameraFlashMode { off, on, auto }

/// Translucent camera header bar offering flash cycling, grid alignment, camera flip, and settings actions.
class CameraTopBar extends StatelessWidget implements PreferredSizeWidget {
  const CameraTopBar({
    super.key,
    this.onBack,
    this.flashMode = CameraFlashMode.off,
    this.onFlashCycle,
    this.isGridEnabled = false,
    this.onGridToggle,
    this.onFlipCamera,
    this.onSettingsTap,
    this.isSettingsOpen = false,
  });

  final VoidCallback? onBack;
  final CameraFlashMode flashMode;
  final VoidCallback? onFlashCycle;
  final bool isGridEnabled;
  final VoidCallback? onGridToggle;
  final VoidCallback? onFlipCamera;
  final VoidCallback? onSettingsTap;
  final bool isSettingsOpen;

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  IconData get _flashIcon {
    switch (flashMode) {
      case CameraFlashMode.off:
        return Symbols.flash_off_rounded;
      case CameraFlashMode.on:
        return Symbols.flash_on_rounded;
      case CameraFlashMode.auto:
        return Symbols.flash_auto_rounded;
    }
  }

  Color get _flashColor {
    switch (flashMode) {
      case CameraFlashMode.off:
        return Colors.white70;
      case CameraFlashMode.on:
        return AppColors.cameraAccent;
      case CameraFlashMode.auto:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.5),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconCircleButton(
                icon: const Icon(Symbols.arrow_back_rounded),
                iconColor: Colors.white,
                onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                tooltip: 'Back',
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconCircleButton(
                    icon: Icon(_flashIcon),
                    iconColor: _flashColor,
                    onPressed: onFlashCycle,
                    tooltip: 'Flash (${flashMode.name})',
                  ),
                  IconCircleButton(
                    icon: Icon(
                      isGridEnabled
                          ? Symbols.grid_on_rounded
                          : Symbols.grid_off_rounded,
                    ),
                    iconColor: isGridEnabled
                        ? AppColors.cameraAccent
                        : Colors.white60,
                    onPressed: onGridToggle,
                    tooltip: 'Grid',
                  ),
                  IconCircleButton(
                    icon: const Icon(Symbols.flip_camera_android_rounded),
                    iconColor: Colors.white,
                    onPressed: onFlipCamera,
                    tooltip: 'Flip',
                  ),
                  IconCircleButton(
                    icon: const Icon(Symbols.settings_rounded),
                    iconColor: isSettingsOpen
                        ? AppColors.cameraAccent
                        : Colors.white,
                    onPressed: onSettingsTap,
                    tooltip: 'Settings',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
