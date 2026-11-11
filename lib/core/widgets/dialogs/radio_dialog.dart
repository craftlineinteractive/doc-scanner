import 'package:flutter/material.dart';
import '../../constants/app_strings.dart';
import '../buttons/text_action_button.dart';
import '../inputs/radio_tile.dart';
import 'app_dialog.dart';

/// Single-choice selection dialog utilizing RadioTile list options.
class RadioDialog<T> extends StatefulWidget {
  const RadioDialog({
    super.key,
    required this.title,
    required this.options,
    required this.initialValue,
    this.optionLabels,
    this.optionSubtitles,
    this.confirmLabel = 'OK',
    this.cancelLabel = AppStrings.cancel,
  });

  final String title;
  final List<T> options;
  final T initialValue;
  final Map<T, String>? optionLabels;
  final Map<T, String>? optionSubtitles;
  final String confirmLabel;
  final String cancelLabel;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required List<T> options,
    required T initialValue,
    Map<T, String>? optionLabels,
    Map<T, String>? optionSubtitles,
    String confirmLabel = 'OK',
    String cancelLabel = AppStrings.cancel,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) => RadioDialog<T>(
        title: title,
        options: options,
        initialValue: initialValue,
        optionLabels: optionLabels,
        optionSubtitles: optionSubtitles,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
      ),
    );
  }

  @override
  State<RadioDialog<T>> createState() => _RadioDialogState<T>();
}

class _RadioDialogState<T> extends State<RadioDialog<T>> {
  late T _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: widget.title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: widget.options.map((T option) {
          final String label =
              widget.optionLabels?[option] ?? option.toString();
          final String? subtitle = widget.optionSubtitles?[option];

          return RadioTile<T>(
            value: option,
            groupValue: _selected,
            onChanged: (T? val) {
              if (val != null) {
                setState(() => _selected = val);
              }
            },
            title: label,
            subtitle: subtitle,
          );
        }).toList(),
      ),
      actions: <Widget>[
        TextActionButton(
          label: widget.cancelLabel,
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextActionButton(
          label: widget.confirmLabel,
          onPressed: () => Navigator.of(context).pop(_selected),
        ),
      ],
    );
  }
}
