import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography hierarchy using Inter from Google Fonts.
/// Line heights and weights conform strictly to DESIGN.md.
class AppTypography {
  AppTypography._();

  static const String fontFamily = 'Inter';

  // 28px / 700 (line-height: 34px, tracking: -0.02em)
  static final TextStyle headlineXl = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 34 / 28,
    letterSpacing: -0.56,
  );

  // 22px / 600 (line-height: 28px, tracking: -0.015em)
  static final TextStyle headlineLg = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 28 / 22,
    letterSpacing: -0.33,
  );

  // 18px / 600 (line-height: 24px, tracking: -0.01em)
  static final TextStyle headlineMd = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 24 / 18,
    letterSpacing: -0.18,
  );

  // 16px / 600 (line-height: 22px, tracking: 0em)
  static final TextStyle headlineSm = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 22 / 16,
    letterSpacing: 0.0,
  );

  // 15px / 400 (line-height: 22px, tracking: 0em)
  static final TextStyle bodyLg = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 22 / 15,
    letterSpacing: 0.0,
  );

  // 14px / 400 (line-height: 20px, tracking: 0em)
  static final TextStyle bodyMd = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    letterSpacing: 0.0,
  );

  // 12px / 400 (line-height: 16px, tracking: 0.01em)
  static final TextStyle bodySm = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 16 / 12,
    letterSpacing: 0.12,
  );

  // 13px / 500 (line-height: 18px, tracking: 0.01em)
  static final TextStyle labelMd = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 18 / 13,
    letterSpacing: 0.13,
  );

  // 11px / 600 (line-height: 14px, tracking: 0.03em, uppercase style)
  static final TextStyle labelSm = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 14 / 11,
    letterSpacing: 0.33,
  );

  /// Generates a complete Material 3 TextTheme bound to the specified primary text color.
  static TextTheme createTextTheme(Color textColor, Color mutedColor) {
    return TextTheme(
      headlineLarge: headlineXl.copyWith(color: textColor),
      headlineMedium: headlineLg.copyWith(color: textColor),
      headlineSmall: headlineMd.copyWith(color: textColor),
      titleLarge: headlineMd.copyWith(color: textColor),
      titleMedium: headlineSm.copyWith(color: textColor),
      titleSmall: labelMd.copyWith(color: textColor),
      bodyLarge: bodyLg.copyWith(color: textColor),
      bodyMedium: bodyMd.copyWith(color: textColor),
      bodySmall: bodySm.copyWith(color: mutedColor),
      labelLarge: labelMd.copyWith(color: textColor),
      labelMedium: labelSm.copyWith(color: mutedColor),
      labelSmall: labelSm.copyWith(color: mutedColor),
    );
  }
}
