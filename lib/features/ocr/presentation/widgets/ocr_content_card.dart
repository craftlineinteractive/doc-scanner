import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';

/// Content card rendering recognized text with interactive edit/done toggle.
class OcrContentCard extends StatefulWidget {
  const OcrContentCard({
    super.key,
    required this.text,
    required this.isEditing,
    required this.onToggleEdit,
    required this.onSaveText,
  });

  final String text;
  final bool isEditing;
  final VoidCallback onToggleEdit;
  final ValueChanged<String> onSaveText;

  @override
  State<OcrContentCard> createState() => _OcrContentCardState();
}

class _OcrContentCardState extends State<OcrContentCard> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void didUpdateWidget(covariant OcrContentCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text && widget.text != _controller.text) {
      _controller.text = widget.text;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> paragraphs = widget.text.split('\n\n');

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.hairline),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Header row with Edit / Done action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Expanded(
                child: Text(
                  'RECOGNIZED TEXT CONTENT',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textMuted,
                    letterSpacing: 0.8,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  if (widget.isEditing) {
                    widget.onSaveText(_controller.text);
                  }
                  widget.onToggleEdit();
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        widget.isEditing
                            ? Symbols.check_rounded
                            : Symbols.edit_rounded,
                        size: 15,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.isEditing ? 'Done' : 'Edit',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Body text (Read view or Multiline editable TextField)
          Expanded(
            child: widget.isEditing
                ? TextField(
                    controller: _controller,
                    autofocus: true,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.6,
                      color: AppColors.textPrimary,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (paragraphs.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Text(
                              paragraphs.first,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ...paragraphs.skip(1).map(
                              (String p) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Text(
                                  p,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    height: 1.6,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

