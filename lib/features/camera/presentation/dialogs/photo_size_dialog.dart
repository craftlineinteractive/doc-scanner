import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/photo_size.dart';

/// Modal dialog for ID Photo Editor with draggable reorderable 2-column size grid.
class PhotoSizeDialog extends StatefulWidget {
  const PhotoSizeDialog({
    super.key,
    required this.initialSelectedSize,
    required this.initialSizes,
    required this.onSizeSelected,
    this.onSizesUpdated,
  });

  final PhotoSize initialSelectedSize;
  final List<PhotoSize> initialSizes;
  final ValueChanged<PhotoSize> onSizeSelected;
  final ValueChanged<List<PhotoSize>>? onSizesUpdated;

  static Future<PhotoSize?> show(
    BuildContext context, {
    required PhotoSize initialSelectedSize,
    required List<PhotoSize> initialSizes,
    required ValueChanged<PhotoSize> onSizeSelected,
    ValueChanged<List<PhotoSize>>? onSizesUpdated,
  }) {
    return showDialog<PhotoSize>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (context) => PhotoSizeDialog(
        initialSelectedSize: initialSelectedSize,
        initialSizes: initialSizes,
        onSizeSelected: onSizeSelected,
        onSizesUpdated: onSizesUpdated,
      ),
    );
  }

  @override
  State<PhotoSizeDialog> createState() => _PhotoSizeDialogState();
}

class _PhotoSizeDialogState extends State<PhotoSizeDialog> {
  late PhotoSize _selectedSize;
  late List<PhotoSize> _sizes;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.initialSelectedSize;
    _sizes = List<PhotoSize>.from(widget.initialSizes);
  }

  void _removeSize(PhotoSize size) {
    setState(() {
      _sizes.removeWhere((s) => s.id == size.id);
      if (_selectedSize.id == size.id && _sizes.isNotEmpty) {
        _selectedSize = _sizes.first;
      }
    });
    widget.onSizesUpdated?.call(_sizes);
  }

  void _addNewSize() {
    final customSize = PhotoSize(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      label: 'Custom 40 x 60 MM',
      detail: 'DPI 300',
      isCustom: true,
    );
    setState(() {
      _sizes.add(customSize);
      _selectedSize = customSize;
    });
    widget.onSizesUpdated?.call(_sizes);
  }

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      final item = _sizes.removeAt(oldIndex);
      _sizes.insert(newIndex, item);
    });
    widget.onSizesUpdated?.call(_sizes);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 520),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Header
              Text(
                'ID Photo Editor',
                style: AppTypography.headlineSm.copyWith(
                  color: const Color(0xFF1E2340),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Select photo size',
                style: AppTypography.labelSm.copyWith(
                  color: const Color(0xFF4B5563),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Long press and drag to rearrange',
                style: AppTypography.labelSm.copyWith(
                  color: const Color(0xFF8A90A6),
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // 2-Column Draggable Grid
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(_sizes.length, (index) {
                      final size = _sizes[index];
                      return DragTarget<int>(
                        onWillAcceptWithDetails: (details) => details.data != index,
                        onAcceptWithDetails: (details) => _reorder(details.data, index),
                        builder: (context, candidateData, rejectedData) {
                          return LongPressDraggable<int>(
                            data: index,
                            feedback: Material(
                              elevation: 6,
                              borderRadius: BorderRadius.circular(12),
                              child: SizedBox(
                                width: 145,
                                height: 70,
                                child: _buildSizeCard(size, isDragging: true),
                              ),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.3,
                              child: SizedBox(
                                width: 145,
                                height: 70,
                                child: _buildSizeCard(size),
                              ),
                            ),
                            child: SizedBox(
                              width: 145,
                              height: 70,
                              child: _buildSizeCard(size),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Footer Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Close',
                      style: AppTypography.labelSm.copyWith(
                        color: const Color(0xFF8A90A6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(color: AppColors.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      minimumSize: const Size(0, 36),
                    ),
                    onPressed: _addNewSize,
                    child: Text(
                      'Add New',
                      style: AppTypography.labelSm.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      minimumSize: const Size(0, 36),
                    ),
                    onPressed: () {
                      widget.onSizeSelected(_selectedSize);
                      Navigator.of(context).pop(_selectedSize);
                    },
                    child: Text(
                      'Select',
                      style: AppTypography.labelSm.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSizeCard(PhotoSize size, {bool isDragging = false}) {
    final isSelected = size.id == _selectedSize.id;

    return InkWell(
      onTap: () => setState(() => _selectedSize = size),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEEF0FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : const Color(0xFFE5E7EB),
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Stack(
          children: <Widget>[
            // Top right: remove (x)
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () => _removeSize(size),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(
                    Symbols.close_rounded,
                    size: 14,
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.7)
                        : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),

            // Left content
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    size.label,
                    style: AppTypography.labelSm.copyWith(
                      color: const Color(0xFF1E2340),
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w600,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    size.detail,
                    style: AppTypography.labelSm.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : const Color(0xFF8A90A6),
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom right person icon
            Positioned(
              bottom: 0,
              right: 0,
              child: Icon(
                Symbols.person_rounded,
                size: 16,
                color: isSelected
                    ? AppColors.primary
                    : const Color(0xFF8A90A6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
