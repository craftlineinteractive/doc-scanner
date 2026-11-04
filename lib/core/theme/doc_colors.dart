import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ThemeExtension providing custom brand tokens that don't fit default ColorScheme.
class DocColors extends ThemeExtension<DocColors> {
  const DocColors({
    required this.primaryTint,
    required this.gold,
    required this.goldTint,
    required this.success,
    required this.successTint,
    required this.destructive,
    required this.destructiveTint,
    required this.categoryIndigo,
    required this.categoryIndigoTint,
    required this.categoryOrange,
    required this.categoryOrangeTint,
    required this.categoryEmerald,
    required this.categoryEmeraldTint,
    required this.categoryRose,
    required this.categoryRoseTint,
    required this.cameraBackground,
    required this.cameraSheet,
    required this.cameraAccent,
    required this.hairline,
    required this.surfaceSubdued,
  });

  final Color primaryTint;
  final Color gold;
  final Color goldTint;
  final Color success;
  final Color successTint;
  final Color destructive;
  final Color destructiveTint;
  final Color categoryIndigo;
  final Color categoryIndigoTint;
  final Color categoryOrange;
  final Color categoryOrangeTint;
  final Color categoryEmerald;
  final Color categoryEmeraldTint;
  final Color categoryRose;
  final Color categoryRoseTint;
  final Color cameraBackground;
  final Color cameraSheet;
  final Color cameraAccent;
  final Color hairline;
  final Color surfaceSubdued;

  static const DocColors light = DocColors(
    primaryTint: AppColors.primaryTint,
    gold: AppColors.gold,
    goldTint: AppColors.goldTint,
    success: AppColors.success,
    successTint: AppColors.successTint,
    destructive: AppColors.destructive,
    destructiveTint: AppColors.destructiveTint,
    categoryIndigo: AppColors.categoryIndigo,
    categoryIndigoTint: AppColors.categoryIndigoTint,
    categoryOrange: AppColors.categoryOrange,
    categoryOrangeTint: AppColors.categoryOrangeTint,
    categoryEmerald: AppColors.categoryEmerald,
    categoryEmeraldTint: AppColors.categoryEmeraldTint,
    categoryRose: AppColors.categoryRose,
    categoryRoseTint: AppColors.categoryRoseTint,
    cameraBackground: AppColors.cameraBackground,
    cameraSheet: AppColors.cameraSheet,
    cameraAccent: AppColors.cameraAccent,
    hairline: AppColors.hairline,
    surfaceSubdued: AppColors.surfaceSubdued,
  );

  static const DocColors dark = DocColors(
    primaryTint: Color(0xFF282B4A),
    gold: AppColors.gold,
    goldTint: Color(0xFF382E10),
    success: AppColors.success,
    successTint: Color(0xFF063826),
    destructive: AppColors.destructive,
    destructiveTint: Color(0xFF451518),
    categoryIndigo: AppColors.cameraAccent,
    categoryIndigoTint: Color(0xFF232644),
    categoryOrange: AppColors.categoryOrange,
    categoryOrangeTint: Color(0xFF3A1C06),
    categoryEmerald: AppColors.categoryEmerald,
    categoryEmeraldTint: Color(0xFF083222),
    categoryRose: AppColors.categoryRose,
    categoryRoseTint: Color(0xFF3C0E16),
    cameraBackground: AppColors.cameraBackground,
    cameraSheet: AppColors.cameraSheet,
    cameraAccent: AppColors.cameraAccent,
    hairline: AppColors.darkHairline,
    surfaceSubdued: Color(0xFF1E2235),
  );

  @override
  DocColors copyWith({
    Color? primaryTint,
    Color? gold,
    Color? goldTint,
    Color? success,
    Color? successTint,
    Color? destructive,
    Color? destructiveTint,
    Color? categoryIndigo,
    Color? categoryIndigoTint,
    Color? categoryOrange,
    Color? categoryOrangeTint,
    Color? categoryEmerald,
    Color? categoryEmeraldTint,
    Color? categoryRose,
    Color? categoryRoseTint,
    Color? cameraBackground,
    Color? cameraSheet,
    Color? cameraAccent,
    Color? hairline,
    Color? surfaceSubdued,
  }) {
    return DocColors(
      primaryTint: primaryTint ?? this.primaryTint,
      gold: gold ?? this.gold,
      goldTint: goldTint ?? this.goldTint,
      success: success ?? this.success,
      successTint: successTint ?? this.successTint,
      destructive: destructive ?? this.destructive,
      destructiveTint: destructiveTint ?? this.destructiveTint,
      categoryIndigo: categoryIndigo ?? this.categoryIndigo,
      categoryIndigoTint: categoryIndigoTint ?? this.categoryIndigoTint,
      categoryOrange: categoryOrange ?? this.categoryOrange,
      categoryOrangeTint: categoryOrangeTint ?? this.categoryOrangeTint,
      categoryEmerald: categoryEmerald ?? this.categoryEmerald,
      categoryEmeraldTint: categoryEmeraldTint ?? this.categoryEmeraldTint,
      categoryRose: categoryRose ?? this.categoryRose,
      categoryRoseTint: categoryRoseTint ?? this.categoryRoseTint,
      cameraBackground: cameraBackground ?? this.cameraBackground,
      cameraSheet: cameraSheet ?? this.cameraSheet,
      cameraAccent: cameraAccent ?? this.cameraAccent,
      hairline: hairline ?? this.hairline,
      surfaceSubdued: surfaceSubdued ?? this.surfaceSubdued,
    );
  }

  @override
  DocColors lerp(ThemeExtension<DocColors>? other, double t) {
    if (other is! DocColors) return this;
    return DocColors(
      primaryTint: Color.lerp(primaryTint, other.primaryTint, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      goldTint: Color.lerp(goldTint, other.goldTint, t)!,
      success: Color.lerp(success, other.success, t)!,
      successTint: Color.lerp(successTint, other.successTint, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      destructiveTint: Color.lerp(destructiveTint, other.destructiveTint, t)!,
      categoryIndigo: Color.lerp(categoryIndigo, other.categoryIndigo, t)!,
      categoryIndigoTint:
          Color.lerp(categoryIndigoTint, other.categoryIndigoTint, t)!,
      categoryOrange: Color.lerp(categoryOrange, other.categoryOrange, t)!,
      categoryOrangeTint:
          Color.lerp(categoryOrangeTint, other.categoryOrangeTint, t)!,
      categoryEmerald: Color.lerp(categoryEmerald, other.categoryEmerald, t)!,
      categoryEmeraldTint:
          Color.lerp(categoryEmeraldTint, other.categoryEmeraldTint, t)!,
      categoryRose: Color.lerp(categoryRose, other.categoryRose, t)!,
      categoryRoseTint:
          Color.lerp(categoryRoseTint, other.categoryRoseTint, t)!,
      cameraBackground:
          Color.lerp(cameraBackground, other.cameraBackground, t)!,
      cameraSheet: Color.lerp(cameraSheet, other.cameraSheet, t)!,
      cameraAccent: Color.lerp(cameraAccent, other.cameraAccent, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      surfaceSubdued: Color.lerp(surfaceSubdued, other.surfaceSubdued, t)!,
    );
  }
}

extension DocColorsExtension on BuildContext {
  DocColors get docColors =>
      Theme.of(this).extension<DocColors>() ?? DocColors.light;
}

