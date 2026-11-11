import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';
import '../mock/mock_document_page.dart';

/// Thumbnail picker tile for scan filter presets (Auto Enhance, Vivid Light, Grayscale, etc.).
class FilterPresetThumb extends StatelessWidget {
  const FilterPresetThumb({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
    this.preview,
  });

  final String name;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget? preview;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Container(
                width: 72,
                height: 96,
                decoration: BoxDecoration(
                  borderRadius: AppRadii.roundedInput,
                  border: Border.all(
                    color: isSelected ? AppColors.primary : docColors.hairline,
                    width: isSelected ? 2.5 : 1.0,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child:
                    preview ??
                    const MockDocumentPage(
                      variant: MockDocumentVariant.receipt,
                      showBorder: false,
                    ),
              ),
              if (isSelected)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Symbols.check_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            width: 76,
            child: Text(
              name,
              style: AppTypography.labelSm.copyWith(
                color: isSelected
                    ? AppColors.primary
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
