import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radii.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/buttons/secondary_button.dart';
import '../../core/widgets/camera/camera_mode_selector.dart';
import '../../core/widgets/camera/camera_top_bar.dart';
import '../../core/widgets/camera/corner_brackets_overlay.dart';
import '../../core/widgets/camera/crop_magnifier.dart';
import '../../core/widgets/camera/crop_overlay.dart';
import '../../core/widgets/camera/scan_line.dart';
import '../../core/widgets/camera/setting_tile.dart';
import '../../core/widgets/dialogs/confirm_dialog.dart';
import '../../core/widgets/dialogs/radio_dialog.dart';
import '../../core/widgets/feedback/empty_state.dart';
import '../../core/widgets/feedback/shimmer_box.dart';
import '../../core/widgets/mock/mock_camera_background.dart';
import '../../core/widgets/sheets/app_bottom_sheet.dart';

/// Section showcasing Camera overlays, viewfinders, crop controls, and feedback dialogs.
class ComponentsCameraSection extends StatefulWidget {
  const ComponentsCameraSection({super.key});

  @override
  State<ComponentsCameraSection> createState() =>
      _ComponentsCameraSectionState();
}

class _ComponentsCameraSectionState extends State<ComponentsCameraSection> {
  CameraMode _selectedMode = CameraMode.document;
  CameraFlashMode _flashMode = CameraFlashMode.auto;
  bool _grid = true;
  bool _isDraggingCrop = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Camera Chrome & Overlays', style: AppTypography.headlineSm),
        const SizedBox(height: AppSpacing.md),
        CameraTopBar(
          flashMode: _flashMode,
          onFlashCycle: () {
            setState(() {
              _flashMode =
                  CameraFlashMode.values[(_flashMode.index + 1) %
                      CameraFlashMode.values.length];
            });
          },
          isGridEnabled: _grid,
          onGridToggle: () => setState(() => _grid = !_grid),
          onSettingsTap: () {},
        ),
        const SizedBox(height: AppSpacing.md),
        CameraModeSelector(
          selectedMode: _selectedMode,
          onModeSelected: (mode) => setState(() => _selectedMode = mode),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Viewfinder & Interactive Crop Preview',
          style: AppTypography.labelMd,
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          height: 280,
          decoration: const BoxDecoration(
            color: AppColors.cameraBackground,
            borderRadius: AppRadii.roundedCard,
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              const MockCameraBackground(),
              const CornerBracketsOverlay(padding: 24),
              const Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: ScanLine(travelDistance: 190),
                ),
              ),
              CropOverlay(
                onDragStateChanged: (pos, dragging) {
                  setState(() => _isDraggingCrop = dragging);
                },
              ),
              if (_isDraggingCrop)
                const Positioned(top: 16, right: 16, child: CropMagnifier()),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Feedback & Skeletons', style: AppTypography.labelMd),
        const SizedBox(height: AppSpacing.sm),
        const Row(
          children: <Widget>[
            ShimmerBox(width: 80, height: 80),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ShimmerBox(width: double.infinity, height: 16),
                  SizedBox(height: 8),
                  ShimmerBox(width: 140, height: 12),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Camera Setting Tiles', style: AppTypography.labelMd),
        const SizedBox(height: AppSpacing.sm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SettingTile(
                icon: Icons.volume_up_rounded,
                label: 'Capture Sound',
                value: 'On',
                isActive: true,
              ),
              SettingTile(
                icon: Icons.tune_rounded,
                label: 'Spirit Level',
                value: 'Off',
                isActive: false,
              ),
              SettingTile(
                icon: Icons.high_quality_rounded,
                label: 'Scan Quality',
                value: 'High',
                isActive: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Modal Trigger Demos', style: AppTypography.labelMd),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.sm,
          children: <Widget>[
            SecondaryButton(
              label: 'Open Bottom Sheet',
              onPressed: () {
                AppBottomSheet.show<void>(
                  context: context,
                  title: 'Demo Bottom Sheet',
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
                    child: Text('This is a test bottom sheet.'),
                  ),
                );
              },
            ),
            SecondaryButton(
              label: 'Open Confirm Dialog',
              onPressed: () {
                ConfirmDialog.show(
                  context: context,
                  title: 'Delete Item?',
                  message: 'This document will be moved to Trash.',
                );
              },
            ),
            SecondaryButton(
              label: 'Open Radio Dialog',
              onPressed: () {
                RadioDialog.show<String>(
                  context: context,
                  title: 'Select Quality',
                  options: const <String>['Standard', 'High', 'Original'],
                  initialValue: 'High',
                );
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const EmptyState(
          title: 'Empty State Demo',
          description: 'No scanned documents yet in this category.',
        ),
      ],
    );
  }
}
