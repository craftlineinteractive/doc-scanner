import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/crop_shape.dart';

/// Modal bottom sheet for choosing crop aspect ratio shapes (Free, Original, A4, Letter, Square).
class CropShapeSheet extends StatelessWidget {
  const CropShapeSheet({
    super.key,
    required this.currentShape,
    required this.onShapeSelected,
  });

  final CropShape currentShape;
  final ValueChanged<CropShape> onShapeSelected;

  static Future<CropShape?> show(
    BuildContext context, {
    required CropShape currentShape,
    required ValueChanged<CropShape> onShapeSelected,
  }) {
    return showModalBottomSheet<CropShape>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext ctx) => CropShapeSheet(
        currentShape: currentShape,
        onShapeSelected: onShapeSelected,
      ),
    );
  }

  IconData _iconForShape(CropShape shape) {
    switch (shape) {
      case CropShape.free:
        return Symbols.crop_rounded;
      case CropShape.original:
        return Symbols.aspect_ratio_rounded;
      case CropShape.a4:
        return Symbols.crop_portrait_rounded;
      case CropShape.letter:
        return Symbols.crop_7_5_rounded;
      case CropShape.square:
        return Symbols.crop_square_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Title
            const Text(
              'Crop shape',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E2340),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 12),

            // Radio options
            ...CropShape.values.map((shape) {
              final bool isSelected = shape == currentShape;

              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: InkWell(
                  onTap: () {
                    onShapeSelected(shape);
                    Navigator.of(context).pop(shape);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFEEF0FF)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFC7D2FE)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              _iconForShape(shape),
                              size: 20,
                              color: isSelected
                                  ? AppColors.primary
                                  : const Color(0xFF8A90A6),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              shape.label,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: isSelected
                                    ? AppColors.primary
                                    : const Color(0xFF1E2340),
                              ),
                            ),
                          ],
                        ),
                        // Radio circle
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : const Color(0xFFD1D5DB),
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: isSelected
                              ? Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                )
                              : null,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

