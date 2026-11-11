import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';

/// App bar for the resting PDF viewer matching Frame 1.
class PdfTopBar extends StatelessWidget implements PreferredSizeWidget {
  const PdfTopBar({
    super.key,
    required this.fileName,
    required this.onBack,
    required this.onSearchTap,
    required this.onHelpTap,
  });

  final String fileName;
  final VoidCallback onBack;
  final VoidCallback onSearchTap;
  final VoidCallback onHelpTap;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(Symbols.arrow_back_rounded),
            color: AppColors.textPrimary,
            onPressed: onBack,
            tooltip: 'Back',
          ),
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Symbols.search_rounded),
            color: AppColors.textPrimary,
            onPressed: onSearchTap,
            tooltip: 'Search document',
          ),
          IconButton(
            icon: const Icon(Symbols.help_outline_rounded),
            color: AppColors.textPrimary,
            onPressed: onHelpTap,
            tooltip: 'Toolkit Help',
          ),
        ],
      ),
    );
  }
}
