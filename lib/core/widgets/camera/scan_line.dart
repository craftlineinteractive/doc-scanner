import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../theme/app_colors.dart';

/// Laser beam scanning bar animated vertically across the camera viewfinder frame.
class ScanLine extends StatelessWidget {
  const ScanLine({
    super.key,
    this.color = AppColors.cameraAccent,
    this.travelDistance = 240.0,
    this.duration = const Duration(milliseconds: 1800),
  });

  final Color color;
  final double travelDistance;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Container(
          height: 2.5,
          decoration: BoxDecoration(
            color: color,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.withValues(alpha: 0.8),
                offset: const Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        )
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .moveY(
          begin: 0,
          end: travelDistance,
          duration: duration,
          curve: Curves.easeInOut,
        );
  }
}
