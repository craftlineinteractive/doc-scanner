import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radii.dart';
import 'app_spacing.dart';
import 'app_typography.dart';
import 'doc_colors.dart';

/// Application theme configurations for light, dark, and specialized camera viewports.
class AppTheme {
  AppTheme._();

  /// Light theme matching the primary mockup designs.
  static ThemeData get light {
    final ColorScheme colorScheme = const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryTint,
      onPrimaryContainer: AppColors.primary,
      secondary: AppColors.categoryEmerald,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.categoryEmeraldTint,
      onSecondaryContainer: AppColors.categoryEmerald,
      tertiary: AppColors.gold,
      onTertiary: Colors.white,
      tertiaryContainer: AppColors.goldTint,
      onTertiaryContainer: Color(0xFF783200),
      error: AppColors.destructive,
      onError: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      outline: AppColors.textMuted,
      outlineVariant: AppColors.hairline,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      scaffoldBg: AppColors.canvas,
      textColor: AppColors.textPrimary,
      mutedTextColor: AppColors.textMuted,
      surfaceColor: AppColors.surface,
      borderColor: AppColors.hairline,
      docColors: DocColors.light,
    );
  }

  /// Dark theme derived from camera UI tokens.
  /// TODO: Dark theme for normal screens is NOT designed in mockups.
  /// Derived from camera colours (bg #0F1220, surface #1A1D2E, text #E6E8F2, muted #9AA0B8, primary #6366F1).
  static ThemeData get dark {
    final ColorScheme colorScheme = const ColorScheme.dark(
      primary: AppColors.cameraAccent,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF282B4A),
      onPrimaryContainer: AppColors.cameraAccentLight,
      secondary: AppColors.categoryEmerald,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFF083222),
      onSecondaryContainer: Color(0xFF4EDE93),
      tertiary: AppColors.gold,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFF382E10),
      onTertiaryContainer: AppColors.gold,
      error: AppColors.destructive,
      onError: Colors.white,
      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,
      outline: AppColors.darkTextMuted,
      outlineVariant: AppColors.darkHairline,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      scaffoldBg: AppColors.darkCanvas,
      textColor: AppColors.darkTextPrimary,
      mutedTextColor: AppColors.darkTextMuted,
      surfaceColor: AppColors.darkSurface,
      borderColor: AppColors.darkHairline,
      docColors: DocColors.dark,
    );
  }

  /// Specialized camera dark theme used by viewfinder and adjust screens.
  static ThemeData get camera {
    final ColorScheme colorScheme = const ColorScheme.dark(
      primary: AppColors.cameraAccent,
      onPrimary: Colors.white,
      primaryContainer: AppColors.cameraSheet,
      onPrimaryContainer: AppColors.cameraAccentLight,
      secondary: AppColors.categoryEmerald,
      onSecondary: Colors.white,
      error: AppColors.destructive,
      onError: Colors.white,
      surface: AppColors.cameraSheet,
      onSurface: Colors.white,
      outline: AppColors.textMuted,
      outlineVariant: AppColors.darkHairline,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      scaffoldBg: AppColors.cameraBackground,
      textColor: Colors.white,
      mutedTextColor: const Color(0xFF9AA0B4),
      surfaceColor: AppColors.cameraSheet,
      borderColor: const Color(0xFF2A2E44),
      docColors: DocColors.dark,
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color scaffoldBg,
    required Color textColor,
    required Color mutedTextColor,
    required Color surfaceColor,
    required Color borderColor,
    required DocColors docColors,
  }) {
    final TextTheme textTheme = AppTypography.createTextTheme(
      textColor,
      mutedTextColor,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBg,
      fontFamily: AppTypography.fontFamily,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[docColors],

      // App bar
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textColor,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: AppTypography.headlineMd.copyWith(color: textColor),
        iconTheme: IconThemeData(color: textColor, size: 24),
      ),

      // Card
      cardTheme: CardThemeData(
        color: surfaceColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadii.roundedCard,
          side: BorderSide.none,
        ),
        margin: EdgeInsets.zero,
      ),

      // Buttons (Height: 52px, Radius: 12px)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.4),
          disabledForegroundColor: Colors.white70,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.roundedInput,
          ),
          textStyle: AppTypography.headlineSm.copyWith(
            color: colorScheme.onPrimary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.roundedInput,
          ),
          textStyle: AppTypography.headlineSm.copyWith(
            color: colorScheme.onPrimary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          foregroundColor: textColor,
          side: BorderSide(color: borderColor),
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.roundedInput,
          ),
          textStyle: AppTypography.headlineSm.copyWith(color: textColor),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadii.roundedInput,
          ),
          textStyle: AppTypography.headlineSm.copyWith(
            color: colorScheme.primary,
          ),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        ),
      ),

      // Text input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        hintStyle: AppTypography.bodyMd.copyWith(color: mutedTextColor),
        labelStyle: AppTypography.bodyMd.copyWith(color: textColor),
        border: OutlineInputBorder(
          borderRadius: AppRadii.roundedInput,
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadii.roundedInput,
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadii.roundedInput,
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: AppRadii.roundedInput,
          borderSide: BorderSide(color: AppColors.destructive),
        ),
      ),

      // Chips
      chipTheme: ChipThemeData(
        backgroundColor: docColors.surfaceSubdued,
        labelStyle: AppTypography.labelSm.copyWith(color: textColor),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        shape: const StadiumBorder(),
        side: BorderSide.none,
      ),

      // Bottom Sheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surfaceColor,
        modalBackgroundColor: surfaceColor,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadii.sheetRadius,
        ),
        dragHandleColor: mutedTextColor.withValues(alpha: 0.5),
        dragHandleSize: const Size(36, 4),
        showDragHandle: true,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: surfaceColor,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadii.roundedCardLarge,
        ),
        titleTextStyle: AppTypography.headlineMd.copyWith(color: textColor),
        contentTextStyle: AppTypography.bodyMd.copyWith(color: textColor),
      ),

      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return mutedTextColor;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return docColors.surfaceSubdued;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),

      // SnackBar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTypography.bodyMd.copyWith(color: Colors.white),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadii.roundedInput,
        ),
        actionTextColor: AppColors.gold,
      ),

      // Divider
      dividerTheme: DividerThemeData(
        color: borderColor,
        thickness: 1,
        space: 1,
      ),
    );
  }
}

