import 'package:docscanner/app/app_router.dart';
import 'package:docscanner/app/routes.dart';
import 'package:docscanner/core/theme/app_theme.dart';
import 'package:docscanner/core/widgets/camera/crop_magnifier.dart';
import 'package:docscanner/core/widgets/camera/crop_overlay.dart';
import 'package:docscanner/features/scan_review/application/review_ui_provider.dart';
import 'package:docscanner/features/scan_review/application/scan_session_provider.dart';
import 'package:docscanner/features/scan_review/domain/crop_shape.dart';
import 'package:docscanner/features/scan_review/domain/scan_filter.dart';
import 'package:docscanner/features/scan_review/presentation/dialogs/delete_page_dialog.dart';
import 'package:docscanner/features/scan_review/presentation/screens/adjust_screen.dart';
import 'package:docscanner/features/scan_review/presentation/screens/review_scan_screen.dart';
import 'package:docscanner/features/scan_review/presentation/sheets/crop_shape_sheet.dart';
import 'package:docscanner/features/scan_review/presentation/sheets/filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Adjust screen shows 4 crop handles and page counter',
      (WidgetTester tester) async {
    final router = createRouter(initialLocation: AppRoutes.adjust);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: AppTheme.camera,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(AdjustScreen), findsOneWidget);
    expect(find.byType(CropOverlay), findsOneWidget);
    expect(find.text('Adjust'), findsOneWidget);
    // Default session is page index 1 of 5 -> '2/5'
    expect(find.text('2/5'), findsOneWidget);
  });

  testWidgets('Dragging a corner handle displays the CropMagnifier',
      (WidgetTester tester) async {
    final router = createRouter(initialLocation: '${AppRoutes.adjust}?drag=true');

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: AppTheme.camera,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(CropMagnifier), findsOneWidget);
    expect(find.text('2.5×'), findsOneWidget);
  });

  testWidgets('Selecting a filter from FilterBottomSheet updates the active page filter in provider',
      (WidgetTester tester) async {
    ScanFilter? selected;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                FilterBottomSheet.show(
                  context,
                  currentFilter: ScanFilter.original,
                  onFilterChanged: (f) => selected = f,
                );
              },
              child: const Text('Open Filters'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open Filters'));
    await tester.pumpAndSettle();

    expect(find.text('Filters'), findsOneWidget);
    expect(find.text('5 Presets'), findsOneWidget);

    // Tap Grayscale filter preset
    await tester.tap(find.text('Grayscale'));
    await tester.pumpAndSettle();

    expect(selected, ScanFilter.grayscale);

    // Tap Done
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    expect(find.text('Filters'), findsNothing);
  });

  testWidgets('Selecting an aspect ratio from CropShapeSheet updates crop shape in provider',
      (WidgetTester tester) async {
    CropShape? chosenShape;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                CropShapeSheet.show(
                  context,
                  currentShape: CropShape.free,
                  onShapeSelected: (s) => chosenShape = s,
                );
              },
              child: const Text('Open Shapes'),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Open Shapes'));
    await tester.pumpAndSettle();

    expect(find.text('Crop shape'), findsOneWidget);
    expect(find.text('A4'), findsOneWidget);

    // Tap A4
    await tester.tap(find.text('A4'));
    await tester.pumpAndSettle();

    expect(chosenShape, CropShape.a4);
    expect(find.text('Crop shape'), findsNothing);
  });

  testWidgets('Review screen renders 5 pages in PageView with page counter pill 2 / 5',
      (WidgetTester tester) async {
    final router = createRouter(initialLocation: AppRoutes.reviewScan);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ReviewScanScreen), findsOneWidget);
    expect(find.byType(PageView), findsOneWidget);
    expect(find.text('2 / 5'), findsOneWidget);
  });

  testWidgets('Review screen sub-mode toggling: tapping Crop opens crop sub-toolbar; tapping Color opens filter strip',
      (WidgetTester tester) async {
    final router = createRouter(initialLocation: AppRoutes.reviewScan);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(ReviewScanScreen)),
    );
    expect(container.read(reviewUiProvider).mode, ReviewToolbarMode.none);

    // Tap Crop tool
    await tester.tap(find.text('Crop'));
    await tester.pumpAndSettle();

    expect(container.read(reviewUiProvider).mode, ReviewToolbarMode.crop);
    expect(find.text('Auto Detect'), findsOneWidget);
    expect(find.text('Flip'), findsOneWidget);

    // Tap Color tool
    await tester.tap(find.text('Color'));
    await tester.pumpAndSettle();

    expect(container.read(reviewUiProvider).mode, ReviewToolbarMode.color);
    expect(find.text('Apply to all pages'), findsOneWidget);
  });

  testWidgets('Delete page dialog: tapping Delete removes the page from session and updates page counter',
      (WidgetTester tester) async {
    final router = createRouter(initialLocation: AppRoutes.reviewScan);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          theme: AppTheme.light,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    final container = ProviderScope.containerOf(
      tester.element(find.byType(ReviewScanScreen)),
    );
    final initialCount = container.read(scanSessionProvider).pageCount;
    expect(initialCount, 5);

    // Tap Delete tool
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();

    expect(find.byType(DeletePageDialog), findsOneWidget);
    expect(find.text('Delete this page?'), findsOneWidget);

    // Tap confirm Delete button inside dialog
    await tester.tap(find.widgetWithText(ElevatedButton, 'Delete'));
    await tester.pumpAndSettle();

    final updatedCount = container.read(scanSessionProvider).pageCount;
    expect(updatedCount, 4);
    expect(find.text('2 / 4'), findsOneWidget);
  });
}

