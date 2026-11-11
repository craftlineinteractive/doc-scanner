import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/app_radii.dart';
import '../../theme/doc_colors.dart';

/// Animated skeleton loading placeholder with custom width, height, and corner radius.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppRadii.roundedInput,
  });

  final double width;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final DocColors docColors = context.docColors;

    return Shimmer.fromColors(
      baseColor: docColors.surfaceSubdued,
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: docColors.surfaceSubdued,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
