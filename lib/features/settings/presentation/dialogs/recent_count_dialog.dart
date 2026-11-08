import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/doc_colors.dart';
import '../../../../core/widgets/buttons/text_action_button.dart';
import '../../../../core/widgets/dialogs/app_dialog.dart';
import '../../../../core/widgets/inputs/radio_tile.dart';

/// Modal dialog allowing users to pick how many recent documents are displayed on Home.
class RecentCountDialog extends StatefulWidget {
  const RecentCountDialog({
    super.key,
    required this.initialValue,
  });

  final int initialValue;

  static const List<int> options = <int>[10, 25, 50, 100];

  static Future<int?> show(BuildContext context, int initialValue) {
    return showDialog<int>(
      context: context,
      builder: (context) => RecentCountDialog(initialValue: initialValue),
    );
  }

  @override
  State<RecentCountDialog> createState() => _RecentCountDialogState();
}

class _RecentCountDialogState extends State<RecentCountDialog> {
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return AppDialog(
      title: 'Recent documents on home',
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
              'COUNT',
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
        children: RecentCountDialog.options.map((int count) {
          return RadioTile<int>(
            value: count,
            groupValue: _selected,
            onChanged: (int? val) {
              if (val != null) {
                setState(() => _selected = val);
              }
            },
            title: count.toString(),
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
