import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/chips/filter_preset_thumb.dart';
import '../../../../core/widgets/mock/mock_document_page.dart';
import '../../domain/scan_filter.dart';

/// Secondary action toolbar displayed when Color sub-mode is active in Scan Review.
class ReviewColorBar extends StatelessWidget {
  const ReviewColorBar({
    super.key,
    required this.selectedFilter,
    required this.applyToAll,
    required this.onSelectFilter,
    required this.onToggleApplyToAll,
  });

  final ScanFilter selectedFilter;
  final bool applyToAll;
  final ValueChanged<ScanFilter> onSelectFilter;
  final VoidCallback onToggleApplyToAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        border: const Border(top: BorderSide(color: Color(0xFFE2E5EE))),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1E2340).withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Horizontal preset strip
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ScanFilter.values.map((filter) {
                final bool isSelected = filter == selectedFilter;
                Widget? previewWidget;

                final matrix = filter.colorFilter;
                if (matrix != null) {
                  previewWidget = ColorFiltered(
                    colorFilter: matrix,
                    child: const MockDocumentPage(
                      variant: MockDocumentVariant.receipt,
                      showBorder: false,
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: FilterPresetThumb(
                    name: filter.label,
                    isSelected: isSelected,
                    preview: previewWidget,
                    onTap: () => onSelectFilter(filter),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),

          // Apply to all pages row
          InkWell(
            onTap: onToggleApplyToAll,
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: applyToAll
                            ? AppColors.primary
                            : const Color(0xFF8A90A6),
                        width: 1.5,
                      ),
                      color: applyToAll ? AppColors.primary : Colors.transparent,
                    ),
                    alignment: Alignment.center,
                    child: applyToAll
                        ? const Icon(
                            Icons.check_rounded,
                            size: 12,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Apply to all pages',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: applyToAll
                          ? AppColors.primary
                          : const Color(0xFF1E2340),
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
