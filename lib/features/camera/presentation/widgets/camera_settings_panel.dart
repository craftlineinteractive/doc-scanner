import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/camera/setting_tile.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../application/camera_settings_provider.dart';
import '../sheets/scan_quality_sheet.dart';

/// Overlay settings panel displaying 10 camera configuration tiles in a 3-column grid.
class CameraSettingsPanel extends ConsumerWidget {
  const CameraSettingsPanel({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(cameraSettingsProvider);
    final notifier = ref.read(cameraSettingsProvider.notifier);

    return Material(
      color: Colors.black.withValues(alpha: 0.92),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // 10 Tiles Grid
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: GridView.count(
                      crossAxisCount: 3,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 8,
                      childAspectRatio: 0.95,
                      children: <Widget>[
                        // Tile 1: Capture Sound
                        SettingTile(
                          icon: Symbols.volume_up_rounded,
                          label: 'Capture Sound',
                          value: settings.captureSound ? 'On' : 'Off',
                          isActive: settings.captureSound,
                          onTap: notifier.toggleCaptureSound,
                        ),

                        // Tile 2: Focus Sound
                        SettingTile(
                          icon: Symbols.center_focus_strong_rounded,
                          label: 'Focus Sound',
                          value: settings.focusSound ? 'On' : 'Off',
                          isActive: settings.focusSound,
                          onTap: notifier.toggleFocusSound,
                        ),

                        // Tile 3: Auto Crop
                        SettingTile(
                          icon: Symbols.crop_rounded,
                          label: 'Auto Crop',
                          value: settings.autoCrop ? 'On' : 'Off',
                          isActive: settings.autoCrop,
                          onTap: notifier.toggleAutoCrop,
                        ),

                        // Tile 4: Color Filter
                        SettingTile(
                          icon: Symbols.filter_vintage_rounded,
                          label: 'Color Filter',
                          value: settings.colorFilter,
                          isActive: false,
                          onTap: () {
                            showAppSnackbar(
                              context: context,
                              message: 'Color filters are chosen in the editor',
                            );
                          },
                        ),

                        // Tile 5: Image Rotation
                        SettingTile(
                          icon: Symbols.screen_rotation_rounded,
                          label: 'Image Rotation',
                          value: settings.imageRotation,
                          isActive: false,
                          onTap: notifier.cycleImageRotation,
                        ),

                        // Tile 6: Settings
                        SettingTile(
                          icon: Symbols.settings_rounded,
                          label: 'Settings',
                          value: '—',
                          isActive: false,
                          onTap: () {
                            onClose();
                            context.push(AppRoutes.settings);
                          },
                        ),

                        // Tile 7: Home Screen
                        SettingTile(
                          icon: Symbols.home_rounded,
                          label: 'Home Screen',
                          value: '—',
                          isActive: false,
                          onTap: () {
                            showAppSnackbar(
                              context: context,
                              message: 'Set camera as home is coming later',
                            );
                          },
                        ),

                        // Tile 8: Spirit Level
                        SettingTile(
                          icon: Symbols.tune_rounded,
                          label: 'Spirit Level',
                          value: settings.spiritLevel ? 'On' : 'Off',
                          isActive: settings.spiritLevel,
                          onTap: notifier.toggleSpiritLevel,
                        ),

                        // Tile 9: Scan Quality
                        SettingTile(
                          icon: Symbols.high_quality_rounded,
                          label: 'Scan Quality',
                          value: settings.scanQuality.label,
                          isActive: false,
                          onTap: () {
                            ScanQualitySheet.show(
                              context,
                              initialQuality: settings.scanQuality,
                              onSelected: notifier.setScanQuality,
                            );
                          },
                        ),

                        // Tile 10: Auto Capture Time
                        SettingTile(
                          icon: Symbols.timer_rounded,
                          label: 'Auto Capture\nTime',
                          value: settings.autoCaptureSeconds == 0
                              ? 'Off'
                              : '${settings.autoCaptureSeconds} sec',
                          isActive: false,
                          onTap: notifier.cycleAutoCaptureSeconds,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Close Button on bottom right
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    minimumSize: const Size(100, 48),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                  ),
                  onPressed: onClose,
                  child: Text(
                    'Close',
                    style: AppTypography.labelMd.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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
