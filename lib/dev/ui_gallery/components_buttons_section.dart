import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/buttons/dual_pill_fab.dart';
import '../../core/widgets/buttons/labelled_dual_pill_fab.dart';
import '../../core/widgets/buttons/icon_circle_button.dart';
import '../../core/widgets/buttons/primary_button.dart';
import '../../core/widgets/buttons/secondary_button.dart';
import '../../core/widgets/buttons/shutter_button.dart';
import '../../core/widgets/buttons/text_action_button.dart';
import '../../core/widgets/buttons/tool_button.dart';
import '../../core/widgets/feedback/app_snackbar.dart';

/// Section showcasing all button primitives in their varied states.
class ComponentsButtonsSection extends StatefulWidget {
  const ComponentsButtonsSection({super.key});

  @override
  State<ComponentsButtonsSection> createState() =>
      _ComponentsButtonsSectionState();
}

class _ComponentsButtonsSectionState extends State<ComponentsButtonsSection> {
  bool _toolSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Buttons & Actions', style: AppTypography.headlineSm),
        const SizedBox(height: AppSpacing.md),
        PrimaryButton(
          label: 'Primary Button',
          icon: const Icon(Symbols.bolt_rounded),
          onPressed: () => showAppSnackbar(
            context: context,
            message: 'Primary button tapped!',
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        const PrimaryButton(
          label: 'Loading...',
          isLoading: true,
        ),
        const SizedBox(height: AppSpacing.sm),
        SecondaryButton(
          label: 'Secondary Outlined',
          icon: const Icon(Symbols.tune_rounded),
          onPressed: () => showAppSnackbar(
            context: context,
            message: 'Secondary button tapped!',
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            TextActionButton(
              label: 'Text Action',
              icon: const Icon(Symbols.open_in_new_rounded),
              onPressed: () {},
            ),
            TextActionButton(
              label: 'Destructive Action',
              isDestructive: true,
              icon: const Icon(Symbols.delete_rounded),
              onPressed: () {},
            ),
            IconCircleButton(
              icon: const Icon(Symbols.search_rounded),
              onPressed: () {},
              tooltip: 'Search',
            ),
            ToolButton(
              icon: const Icon(Symbols.crop_rounded),
              label: 'Crop',
              isSelected: _toolSelected,
              onPressed: () =>
                  setState(() => _toolSelected = !_toolSelected),
            ),
            ToolButton(
              icon: const Icon(Symbols.palette_rounded),
              label: 'Filter',
              isSelected: !_toolSelected,
              onPressed: () =>
                  setState(() => _toolSelected = !_toolSelected),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Capture & Floating Buttons', style: AppTypography.labelMd),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ShutterButton(
              onTap: () => showAppSnackbar(
                context: context,
                message: 'Shutter pressed!',
              ),
            ),
            DualPillFab(
              onCameraTap: () => showAppSnackbar(
                context: context,
                message: 'Camera scan tapped!',
              ),
              onPlusTap: () => showAppSnackbar(
                context: context,
                message: 'Import plus tapped!',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: LabelledDualPillFab(
            onScanPageTap: () => showAppSnackbar(
              context: context,
              message: 'Scan Page tapped!',
            ),
            onImportTap: () => showAppSnackbar(
              context: context,
              message: 'Import tapped!',
            ),
          ),
        ),
      ],
    );
  }
}
