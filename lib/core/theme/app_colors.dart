import 'package:flutter/material.dart';

/// Color palette reflecting the values rendered in mockup screens.
class AppColors {
  AppColors._();

  // Primary brand
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryPressed = Color(0xFF4338CA);
  static const Color primaryTint = Color(0xFFEEF0FF);

  // Camera & dark accents
  static const Color cameraAccent = Color(0xFF6366F1);
  static const Color cameraAccentLight = Color(0xFF818CF8);
  static const Color cameraBackground = Color(0xFF0F1220);
  static const Color cameraSheet = Color(0xFF1A1D2E);

  // Neutral - Light mode
  static const Color textPrimary = Color(0xFF1E2340);
  static const Color textMuted = Color(0xFF8A90A6);
  static const Color canvas = Color(0xFFF4F6FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSubdued = Color(0xFFEEF2F6);
  static const Color hairline = Color(0xFFE9ECF3);
  static const Color borderSubtle = Color(0xFFE2E8F0);

  // Neutral - Dark mode (derived from camera surfaces)
  // TODO: Dark theme for normal screens is derived from camera colors; verify when designs are provided.
  static const Color darkCanvas = Color(0xFF0F1220);
  static const Color darkSurface = Color(0xFF1A1D2E);
  static const Color darkTextPrimary = Color(0xFFE6E8F2);
  static const Color darkTextMuted = Color(0xFF9AA0B8);
  static const Color darkHairline = Color(0xFF2A2E44);

  // Status & semantic
  static const Color destructive = Color(0xFFE5484D);
  static const Color destructiveTint = Color(0xFFFEE2E2);
  static const Color gold = Color(0xFFF5B301);
  static const Color goldTint = Color(0xFFFFF6DD);
  static const Color success = Color(0xFF10B981);
  static const Color successTint = Color(0xFFECFDF5);

  // Category accents (Foreground / Pastel Container)
  static const Color categoryIndigo = Color(0xFF4F46E5);
  static const Color categoryIndigoTint = Color(0xFFEEF0FF);
  static const Color categoryOrange = Color(0xFFF97316);
  static const Color categoryOrangeTint = Color(0xFFFFF7ED);
  static const Color categoryEmerald = Color(0xFF10B981);
  static const Color categoryEmeraldTint = Color(0xFFECFDF5);
  static const Color categoryRose = Color(0xFFF43F5E);
  static const Color categoryRoseTint = Color(0xFFFFF1F2);
}

