import 'package:docscanner/core/theme/app_colors.dart';
import 'package:docscanner/core/theme/app_theme.dart';
import 'package:docscanner/core/theme/doc_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppTheme Sanity Tests', () {
    test('Light theme builds correctly with required tokens', () {
      final ThemeData lightTheme = AppTheme.light;

      expect(lightTheme.colorScheme.primary, equals(AppColors.primary));
      expect(
        lightTheme.scaffoldBackgroundColor,
        equals(AppColors.canvas),
      );

      final DocColors? docColors = lightTheme.extension<DocColors>();
      expect(docColors, isNotNull);
      expect(docColors!.primaryTint, equals(AppColors.primaryTint));
      expect(docColors.gold, equals(AppColors.gold));
      expect(docColors.destructive, equals(AppColors.destructive));

      // Component themes verification
      expect(
        lightTheme.elevatedButtonTheme.style?.minimumSize?.resolve(<WidgetState>{}),
        equals(const Size.fromHeight(52)),
      );
      expect(lightTheme.bottomSheetTheme.showDragHandle, isTrue);
      expect(lightTheme.snackBarTheme.behavior, equals(SnackBarBehavior.floating));
    });

    test('Dark theme builds correctly with derived camera tokens', () {
      final ThemeData darkTheme = AppTheme.dark;

      expect(darkTheme.colorScheme.primary, equals(AppColors.cameraAccent));
      expect(
        darkTheme.scaffoldBackgroundColor,
        equals(AppColors.darkCanvas),
      );

      final DocColors? docColors = darkTheme.extension<DocColors>();
      expect(docColors, isNotNull);
      expect(docColors!.cameraBackground, equals(AppColors.cameraBackground));
      expect(docColors.cameraSheet, equals(AppColors.cameraSheet));
    });

    test('Camera dark theme builds correctly for viewfinder screens', () {
      final ThemeData cameraTheme = AppTheme.camera;

      expect(cameraTheme.colorScheme.primary, equals(AppColors.cameraAccent));
      expect(
        cameraTheme.scaffoldBackgroundColor,
        equals(AppColors.cameraBackground),
      );
      expect(
        cameraTheme.extension<DocColors>(),
        isNotNull,
      );
    });
  });
}
