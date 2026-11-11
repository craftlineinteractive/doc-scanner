import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/chips/filter_preset_thumb.dart';
import '../../../../core/widgets/mock/mock_document_page.dart';
import '../../domain/scan_filter.dart';

/// Modal bottom sheet for choosing scan filter presets with live updates and thumbnail strip.
class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
    required this.initialFilter,
    required this.onFilterChanged,
  });

  final ScanFilter initialFilter;
  final ValueChanged<ScanFilter> onFilterChanged;

  static Future<ScanFilter?> show(
    BuildContext context, {
    required ScanFilter currentFilter,
    required ValueChanged<ScanFilter> onFilterChanged,
  }) {
    return showModalBottomSheet<ScanFilter>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext ctx) => FilterBottomSheet(
        initialFilter: currentFilter,
        onFilterChanged: onFilterChanged,
      ),
    );
  }

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late ScanFilter _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header: "Filters" and "5 Presets"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  'Filters',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E2340),
                    letterSpacing: -0.3,
                  ),
                ),
                Text(
                  '${ScanFilter.values.length} Presets',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8A90A6),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Horizontal strip of 5 filter presets
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ScanFilter.values.map((filter) {
                  final bool isSelected = filter == _selected;
                  Widget? previewWidget;

                  final filterMatrix = filter.colorFilter;
                  if (filterMatrix != null) {
                    previewWidget = ColorFiltered(
                      colorFilter: filterMatrix,
                      child: const MockDocumentPage(
                        variant: MockDocumentVariant.receipt,
                        showBorder: false,
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FilterPresetThumb(
                      name: filter.label,
                      isSelected: isSelected,
                      preview: previewWidget,
                      onTap: () {
                        setState(() => _selected = filter);
                        widget.onFilterChanged(filter);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Done action button
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(_selected),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shadowColor: AppColors.primary.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
