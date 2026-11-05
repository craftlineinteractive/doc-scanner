import 'package:flutter/material.dart';
import '../../constants/app_durations.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../../features/camera/application/camera_mode.dart';

export '../../../features/camera/application/camera_mode.dart';

/// Horizontal mode selector strip positioned immediately above the camera capture controls.
class CameraModeSelector extends StatefulWidget {
  const CameraModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeSelected,
    this.modes = CameraMode.values,
  });

  final CameraMode selectedMode;
  final ValueChanged<CameraMode> onModeSelected;
  final List<CameraMode> modes;

  @override
  State<CameraModeSelector> createState() => _CameraModeSelectorState();
}

class _CameraModeSelectorState extends State<CameraModeSelector> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToSelected());
  }

  @override
  void didUpdateWidget(covariant CameraModeSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedMode != widget.selectedMode) {
      _scrollToSelected();
    }
  }

  void _scrollToSelected() {
    if (!_scrollController.hasClients) return;
    final index = widget.modes.indexOf(widget.selectedMode);
    if (index == -1) return;

    // Approximate width per pill ~90dp
    const estimatedItemWidth = 90.0;
    final targetOffset = (index * estimatedItemWidth) - 100.0;
    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: AppDurations.normal,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: widget.modes.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: AppSpacing.sm),
        itemBuilder: (BuildContext context, int index) {
          final CameraMode mode = widget.modes[index];
          final bool isSelected = mode == widget.selectedMode;

          return GestureDetector(
            onTap: () => widget.onModeSelected(mode),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: AppDurations.fast,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.cameraAccent.withValues(alpha: 0.22)
                    : Colors.white.withValues(alpha: 0.06),
                borderRadius: AppRadii.roundedPill,
                border: Border.all(
                  color: isSelected
                      ? AppColors.cameraAccent.withValues(alpha: 0.5)
                      : Colors.transparent,
                  width: 1.2,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                mode.label,
                style: AppTypography.labelSm.copyWith(
                  color: isSelected ? Colors.white : const Color(0xFF9AA0B4),
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
