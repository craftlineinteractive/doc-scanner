import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';

/// Transformed in-document search top bar matching Frame 3.
class PdfSearchBar extends StatefulWidget implements PreferredSizeWidget {
  const PdfSearchBar({
    super.key,
    required this.initialQuery,
    required this.totalMatches,
    required this.currentMatchIndex,
    required this.onQueryChanged,
    required this.onPreviousMatch,
    required this.onNextMatch,
    required this.onClose,
  });

  final String initialQuery;
  final int totalMatches;
  final int currentMatchIndex;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onPreviousMatch;
  final VoidCallback onNextMatch;
  final VoidCallback onClose;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  State<PdfSearchBar> createState() => _PdfSearchBarState();
}

class _PdfSearchBarState extends State<PdfSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void didUpdateWidget(covariant PdfSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialQuery != oldWidget.initialQuery &&
        widget.initialQuery != _controller.text) {
      _controller.text = widget.initialQuery;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String counterText = widget.totalMatches > 0
        ? '${widget.currentMatchIndex + 1} / ${widget.totalMatches}'
        : '0 / 0';

    return Container(
      height: 60,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Symbols.arrow_back_rounded),
            color: AppColors.textPrimary,
            onPressed: widget.onClose,
            tooltip: 'Leave search',
          ),

          // Search Input Well
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.canvas,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  const Icon(
                    Symbols.search_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      autofocus: widget.initialQuery.isEmpty,
                      onChanged: widget.onQueryChanged,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Search...',
                      ),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  if (_controller.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Symbols.close_rounded, size: 16),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        _controller.clear();
                        widget.onQueryChanged('');
                      },
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 6),

          // Match Counter Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primaryTint,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              counterText,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 2),

          // Up and Down Steppers
          IconButton(
            icon: const Icon(Symbols.keyboard_arrow_up_rounded, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            onPressed: widget.totalMatches > 0 ? widget.onPreviousMatch : null,
            tooltip: 'Previous match',
          ),
          IconButton(
            icon: const Icon(Symbols.keyboard_arrow_down_rounded, size: 20),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
            onPressed: widget.totalMatches > 0 ? widget.onNextMatch : null,
            tooltip: 'Next match',
          ),
        ],
      ),
    );
  }
}
