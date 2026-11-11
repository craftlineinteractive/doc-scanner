import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';

/// Bottom OCR preview card with extracted text and export action chips.
class PostScanOcrPanel extends StatelessWidget {
  const PostScanOcrPanel({
    super.key,
    required this.extractedText,
    required this.onClose,
    required this.onCopyAll,
    required this.onExportTxt,
    required this.onTranslate,
    required this.onSearch,
  });

  final String extractedText;
  final VoidCallback onClose;
  final VoidCallback onCopyAll;
  final VoidCallback onExportTxt;
  final VoidCallback onTranslate;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Extracted Text Preview',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '84 words • 98% accuracy',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Symbols.close_rounded, size: 18),
                onPressed: onClose,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.canvas,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.hairline),
            ),
            constraints: const BoxConstraints(maxHeight: 110),
            child: SingleChildScrollView(
              child: Text(
                extractedText,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  height: 1.4,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              _PanelChip(
                icon: Symbols.content_copy_rounded,
                label: 'Copy All',
                isPrimary: true,
                onTap: onCopyAll,
              ),
              const SizedBox(width: 8),
              _PanelChip(
                icon: Symbols.description_rounded,
                label: 'TXT',
                onTap: onExportTxt,
              ),
              const SizedBox(width: 8),
              _PanelChip(
                icon: Symbols.translate_rounded,
                label: 'Translate',
                onTap: onTranslate,
              ),
              const SizedBox(width: 8),
              _PanelChip(
                icon: Symbols.search_rounded,
                label: 'Search',
                onTap: onSearch,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PanelChip extends StatelessWidget {
  const _PanelChip({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: isPrimary ? AppColors.primary : AppColors.canvas,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 13,
                  color: isPrimary ? Colors.white : AppColors.textPrimary,
                ),
                const SizedBox(width: 3),
                Flexible(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isPrimary ? Colors.white : AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
