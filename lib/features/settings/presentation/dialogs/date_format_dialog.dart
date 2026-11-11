import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/doc_colors.dart';
import '../../../../core/widgets/buttons/text_action_button.dart';
import '../../../../core/widgets/dialogs/app_dialog.dart';
import '../../../../core/widgets/inputs/radio_tile.dart';
import '../../domain/app_settings.dart';

/// Modal dialog allowing users to pick the system date and time display format.
class DateFormatDialog extends StatefulWidget {
  const DateFormatDialog({super.key, required this.initialValue});

  final SettingsDateTimeFormat initialValue;

  static Future<SettingsDateTimeFormat?> show(
    BuildContext context,
    SettingsDateTimeFormat initialValue,
  ) {
    return showDialog<SettingsDateTimeFormat>(
      context: context,
      builder: (context) => DateFormatDialog(initialValue: initialValue),
    );
  }

  @override
  State<DateFormatDialog> createState() => _DateFormatDialogState();
}

class _DateFormatDialogState extends State<DateFormatDialog> {
  late SettingsDateTimeFormat _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return AppDialog(
      title: 'Date and time format',
      icon: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: docColors.primaryTint,
              borderRadius: AppRadii.roundedInput,
            ),
            child: Text(
              'FORMAT',
              style: AppTypography.labelSm.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: 10,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: SettingsDateTimeFormat.values.map((
          SettingsDateTimeFormat format,
        ) {
          return RadioTile<SettingsDateTimeFormat>(
            value: format,
            groupValue: _selected,
            onChanged: (SettingsDateTimeFormat? val) {
              if (val != null) {
                setState(() => _selected = val);
              }
            },
            title: format.label,
          );
        }).toList(),
      ),
      actions: <Widget>[
        TextActionButton(
          label: 'Cancel',
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextActionButton(
          label: 'OK',
          onPressed: () => Navigator.of(context).pop(_selected),
        ),
      ],
    );
  }
}
