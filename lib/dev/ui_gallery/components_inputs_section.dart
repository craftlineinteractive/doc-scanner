import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/widgets/inputs/app_search_field.dart';
import '../../core/widgets/inputs/app_switch.dart';
import '../../core/widgets/inputs/app_text_field.dart';
import '../../core/widgets/inputs/radio_tile.dart';
import '../../core/widgets/inputs/segmented_pill.dart';
import '../../core/widgets/inputs/settings_section.dart';
import '../../core/widgets/inputs/settings_tile.dart';

/// Section showcasing inputs, switches, radio tiles, segmented choice pills, and settings components.
class ComponentsInputsSection extends StatefulWidget {
  const ComponentsInputsSection({super.key});

  @override
  State<ComponentsInputsSection> createState() =>
      _ComponentsInputsSectionState();
}

class _ComponentsInputsSectionState extends State<ComponentsInputsSection> {
  bool _switchVal = true;
  String _radioVal = 'A4';
  String _formatVal = 'PDF';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Inputs & Controls', style: AppTypography.headlineSm),
        const SizedBox(height: AppSpacing.md),
        AppSearchField(onFilterTap: () {}),
        const SizedBox(height: AppSpacing.md),
        const AppTextField(
          label: 'Document Title',
          hintText: 'e.g. Doc Scanner 10 Oct 2026',
        ),
        const SizedBox(height: AppSpacing.md),
        AppSwitch(
          value: _switchVal,
          onChanged: (val) => setState(() => _switchVal = val),
          title: 'Show crop screen after capture',
          subtitle: 'Always review boundary points before saving',
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Text(
                'Format Preset:',
                style: AppTypography.labelMd,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            SegmentedPill<String>(
              items: const <String>['PDF', 'JPG', 'TXT'],
              selectedItem: _formatVal,
              onSelected: (val) => setState(() => _formatVal = val),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text('Radio Options:', style: AppTypography.labelMd),
        RadioTile<String>(
          value: 'A4',
          groupValue: _radioVal,
          onChanged: (val) => setState(() => _radioVal = val!),
          title: 'A4 Standard Paper',
          subtitle: '210 x 297 mm',
        ),
        RadioTile<String>(
          value: 'Letter',
          groupValue: _radioVal,
          onChanged: (val) => setState(() => _radioVal = val!),
          title: 'US Letter Format',
          subtitle: '8.5 x 11 inches',
        ),
        const SizedBox(height: AppSpacing.md),
        SettingsSection(
          title: 'Section Header Preview',
          children: <Widget>[
            const SettingsTile(
              icon: Icon(Symbols.backup_rounded),
              title: 'Auto Local Backup',
              subtitle: 'Protect your documents locally',
            ),
            SettingsTile(
              icon: const Icon(Symbols.dark_mode_rounded),
              title: 'Theme Preference',
              valueText: 'System',
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
