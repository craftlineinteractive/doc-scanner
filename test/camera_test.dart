import 'package:docscanner/app/app_router.dart';
import 'package:docscanner/app/routes.dart';
import 'package:docscanner/core/theme/app_theme.dart';
import 'package:docscanner/core/widgets/buttons/shutter_button.dart';
import 'package:docscanner/core/widgets/camera/setting_tile.dart';
import 'package:docscanner/features/camera/application/camera_mode.dart';
import 'package:docscanner/features/camera/application/camera_mode_provider.dart';
import 'package:docscanner/features/camera/application/camera_settings.dart';
import 'package:docscanner/features/camera/application/camera_settings_provider.dart';
import 'package:docscanner/features/camera/application/flash_mode.dart';
import 'package:docscanner/features/camera/application/flash_provider.dart';
import 'package:docscanner/features/camera/data/mock_photo_sizes.dart';
import 'package:docscanner/features/camera/domain/photo_size.dart';
import 'package:docscanner/features/camera/presentation/dialogs/photo_size_dialog.dart';
import 'package:docscanner/features/camera/presentation/screens/camera_screen.dart';
import 'package:docscanner/features/camera/presentation/sheets/scan_quality_sheet.dart';
import 'package:docscanner/features/camera/presentation/widgets/camera_settings_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget buildCameraScreen() {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.light,
        home: const CameraScreen(),
      ),
    );
  }

  testWidgets('Tapping a mode chip in camera mode selector changes the selected mode',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildCameraScreen());
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(tester.element(find.byType(CameraScreen)));
    expect(container.read(cameraModeProvider), CameraMode.document);

    // Find and tap Photo mode chip
    final photoChip = find.text('Photo');
    expect(photoChip, findsOneWidget);
    await tester.tap(photoChip);
    await tester.pumpAndSettle();

    expect(container.read(cameraModeProvider), CameraMode.photo);
  });

  testWidgets('Flash button cycles Off -> On -> Auto -> Off',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildCameraScreen());
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(tester.element(find.byType(CameraScreen)));

    // Default flash is off
    expect(container.read(flashModeProvider), FlashMode.off);
    expect(find.byIcon(Symbols.flash_off_rounded), findsOneWidget);

    // Tap flash button once -> On
    await tester.tap(find.byIcon(Symbols.flash_off_rounded));
    await tester.pumpAndSettle();
    expect(container.read(flashModeProvider), FlashMode.on);
    expect(find.byIcon(Symbols.flash_on_rounded), findsOneWidget);

    // Tap flash button second time -> Auto
    await tester.tap(find.byIcon(Symbols.flash_on_rounded));
    await tester.pumpAndSettle();
    expect(container.read(flashModeProvider), FlashMode.auto);
    expect(find.byIcon(Symbols.flash_auto_rounded), findsOneWidget);

    // Tap flash button third time -> Off
    await tester.tap(find.byIcon(Symbols.flash_auto_rounded));
    await tester.pumpAndSettle();
    expect(container.read(flashModeProvider), FlashMode.off);
    expect(find.byIcon(Symbols.flash_off_rounded), findsOneWidget);
  });

  testWidgets('Settings panel: tapping Capture Sound toggles On / Off',
      (WidgetTester tester) async {
    await tester.pumpWidget(buildCameraScreen());
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(tester.element(find.byType(CameraScreen)));

    // Open settings panel via gear icon
    await tester.tap(find.byIcon(Symbols.settings_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(CameraSettingsPanel), findsOneWidget);
    expect(container.read(cameraSettingsProvider).captureSound, isTrue);

    // Tap Capture Sound tile
    await tester.tap(find.widgetWithText(SettingTile, 'Capture Sound'));
    await tester.pumpAndSettle();

    expect(container.read(cameraSettingsProvider).captureSound, isFalse);
  });

  testWidgets('Scan Quality sheet: selecting Max and pressing Done updates the quality tile value',
      (WidgetTester tester) async {
    ScanQuality selected = ScanQuality.high;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  ScanQualitySheet.show(
                    context,
                    initialQuality: selected,
                    onSelected: (quality) {
                      selected = quality;
                    },
                  );
                },
                child: const Text('Open Quality Sheet'),
              );
            },
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Open bottom sheet
    await tester.tap(find.text('Open Quality Sheet'));
    await tester.pumpAndSettle();

    expect(find.text('Scan Quality'), findsOneWidget);
    expect(find.text('Max'), findsOneWidget);

    // Select Max
    await tester.tap(find.text('Max'));
    await tester.pumpAndSettle();

    // Tap Done
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(selected, ScanQuality.max);
  });

  testWidgets('Photo size dialog: selecting a chip updates the selected size in provider; tapping x removes the chip',
      (WidgetTester tester) async {
    PhotoSize currentSelected = MockPhotoSizes.defaultSelected;
    List<PhotoSize> currentSizes = List<PhotoSize>.from(MockPhotoSizes.defaultSizes);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: PhotoSizeDialog(
            initialSelectedSize: currentSelected,
            initialSizes: currentSizes,
            onSizeSelected: (size) => currentSelected = size,
            onSizesUpdated: (sizes) => currentSizes = sizes,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ID Photo Editor'), findsOneWidget);
    expect(find.text('35 x 45 MM'), findsOneWidget);

    // Tap 35 x 45 MM card and press Select
    await tester.tap(find.text('35 x 45 MM'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Select'));
    await tester.pumpAndSettle();

    expect(currentSelected.label, '35 x 45 MM');
  });

  testWidgets('Shutter press in Document mode navigates to adjust route',
      (WidgetTester tester) async {
    final router = createRouter(initialLocation: AppRoutes.camera);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Find and tap the shutter button
    final shutter = find.byType(ShutterButton);
    expect(shutter, findsOneWidget);
    await tester.tap(shutter);
    await tester.pumpAndSettle();

    // Verify adjust screen is opened
    expect(find.text('Adjust / Crop Screen'), findsAtLeastNWidgets(1));
  });

  testWidgets('In QR mode, there is no shutter button',
      (WidgetTester tester) async {
    final router = createRouter(initialLocation: '${AppRoutes.camera}?mode=qrScanner');

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router,
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ShutterButton), findsNothing);
    expect(find.text('Auto Detect'), findsOneWidget);
  });
}
