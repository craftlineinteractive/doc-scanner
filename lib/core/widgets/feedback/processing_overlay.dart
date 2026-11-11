import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

/// Translucent modal blocking overlay displaying an active progress spinner and status text.
class ProcessingOverlay extends StatelessWidget {
  const ProcessingOverlay({super.key, required this.message, this.subMessage});

  final String message;
  final String? subMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.65),
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: const BoxDecoration(
            color: AppColors.cameraSheet,
            borderRadius: AppRadii.roundedCardLarge,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Color(0x66000000),
                offset: Offset(0, 10),
                blurRadius: 25,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.cameraAccent,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                message,
                style: AppTypography.headlineSm.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              if (subMessage != null) ...<Widget>[
                const SizedBox(height: AppSpacing.xs),
                Text(
                  subMessage!,
                  style: AppTypography.bodySm.copyWith(
                    color: const Color(0xFF9AA0B4),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
