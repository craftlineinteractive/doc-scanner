import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_radii.dart';
import 'mock_document_page.dart';

/// Dark gradient background simulating a desk surface with a captured document inside the camera viewfinder.
class MockCameraBackground extends StatelessWidget {
  const MockCameraBackground({
    super.key,
    this.variant = MockDocumentVariant.invoice,
    this.documentScale = 0.75,
  });

  final MockDocumentVariant variant;
  final double documentScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.cameraBackground,
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1.2,
          colors: <Color>[
            Color(0xFF1E1610), // Warm desk glow from mockups
            AppColors.cameraBackground,
          ],
        ),
      ),
      child: Center(
        child: FractionallySizedBox(
          widthFactor: documentScale,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x66000000),
                  offset: Offset(0, 12),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
              borderRadius: AppRadii.roundedSm,
            ),
            child: MockDocumentPage(
              variant: variant,
              showBorder: false,
            ),
          ),
        ),
      ),
    );
  }
}

