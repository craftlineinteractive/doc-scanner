import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/buttons/text_action_button.dart';
import '../../../../core/widgets/dialogs/app_dialog.dart';
import '../../../../core/widgets/inputs/app_text_field.dart';

/// Modal dialog for editing the automated document naming template.
class NameFormatDialog extends StatefulWidget {
  const NameFormatDialog({
    super.key,
    required this.initialValue,
  });

  final String initialValue;

  static Future<String?> show(BuildContext context, String initialValue) {
    return showDialog<String>(
      context: context,
      builder: (context) => NameFormatDialog(initialValue: initialValue),
    );
  }

  @override
  State<NameFormatDialog> createState() => _NameFormatDialogState();
}

class _NameFormatDialogState extends State<NameFormatDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: 'New Document Name Format',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTextField(
            controller: _controller,
            hintText: 'e.g. Doc Scanner {date} {time}',
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Use {date} and {time}',
            style: AppTypography.bodySm.copyWith(
              color: AppColors.textMuted,
              fontSize: 12,
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextActionButton(
          label: AppStrings.cancel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextActionButton(
          label: AppStrings.save,
          onPressed: () {
            final String text = _controller.text.trim();
            if (text.isNotEmpty) {
              Navigator.of(context).pop(text);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
