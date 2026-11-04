import 'package:flutter/material.dart';
import '../../constants/app_durations.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_typography.dart';
import '../../theme/doc_colors.dart';

/// Segmented choice pill for format switching (e.g. PDF | JPG) or view modes.
class SegmentedPill<T> extends StatelessWidget {
  const SegmentedPill({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    this.itemLabels,
  });

  final List<T> items;
  final T selectedItem;
  final ValueChanged<T> onSelected;
  final Map<T, String>? itemLabels;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: docColors.surfaceSubdued,
        borderRadius: AppRadii.roundedPill,
        border: Border.all(color: docColors.hairline),
      ),
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: items.map((T item) {
          final bool isSelected = item == selectedItem;
          final String label = itemLabels?[item] ?? item.toString();

          return GestureDetector(
            onTap: () => onSelected(item),
            child: AnimatedContainer(
              duration: AppDurations.fast,
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.transparent,
                borderRadius: AppRadii.roundedPill,
                boxShadow: isSelected
                    ? const <BoxShadow>[
                        BoxShadow(
                          color: Color.fromRGBO(79, 70, 229, 0.25),
                          offset: Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ]
                    : null,
              ),
              child: Text(
                label,
                style: AppTypography.labelSm.copyWith(
                  color: isSelected ? Colors.white : AppColors.textMuted,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
