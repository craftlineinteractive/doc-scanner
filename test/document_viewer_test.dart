import 'package:docscanner/app/app_router.dart';
import 'package:docscanner/app/routes.dart';
import 'package:docscanner/core/widgets/buttons/labelled_dual_pill_fab.dart';
import 'package:docscanner/core/widgets/camera/crop_overlay.dart';
import 'package:docscanner/features/document_viewer/presentation/dialogs/edit_version_dialog.dart';
import 'package:docscanner/features/document_viewer/presentation/screens/page_manager_screen.dart';
import 'package:docscanner/features/document_viewer/presentation/screens/post_scan_viewer_screen.dart';
import 'package:docscanner/features/document_viewer/presentation/screens/saved_document_viewer_screen.dart';
import 'package:docscanner/features/document_viewer/presentation/sheets/document_more_options_sheet.dart';
import 'package:docscanner/features/document_viewer/presentation/sheets/pdf_more_options_sheet.dart';
import 'package:docscanner/features/document_viewer/presentation/widgets/page_manager_search_view.dart';
import 'package:docscanner/features/document_viewer/presentation/widgets/post_scan_ocr_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget buildApp(String initialLocation) {
    final router = createRouter(initialLocation: initialLocation);
    return ProviderScope(child: MaterialApp.router(routerConfig: router));
  }

  void setTestViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.resetPhysicalSize);
  }

  group('M5: Document Viewers Suite Tests', () {
    testWidgets(
      '1. post_scan_viewer_renders_page_count_and_title with 9 tools',
      (WidgetTester tester) async {
        setTestViewport(tester);
        await tester.pumpWidget(buildApp(AppRoutes.postScanViewer));
        await tester.pumpAndSettle();

        expect(find.byType(PostScanViewerScreen), findsOneWidget);
        expect(find.text('Doc Scanner 10 Oct 2026 12-02'), findsOneWidget);
        expect(find.text('1 / 3'), findsOneWidget);

        // Verify bottom toolbar contains tools
        expect(find.text('Edit'), findsOneWidget);
        expect(find.text('Open PDF'), findsOneWidget);
        expect(find.text('Share'), findsOneWidget);
        expect(find.text('Retake'), findsOneWidget);
        expect(find.text('Print'), findsOneWidget);
        expect(find.text('Copy Text'), findsOneWidget);
      },
    );

    testWidgets(
      '2. post_scan_viewer_edit_tier_toggling opens sub-tools and banner',
      (WidgetTester tester) async {
        setTestViewport(tester);
        await tester.pumpWidget(buildApp(AppRoutes.postScanViewer));
        await tester.pumpAndSettle();

        // Tap Edit tool
        await tester.tap(find.text('Edit'));
        await tester.pumpAndSettle();

        // Verify editing mode banner appears
        expect(
          find.text('Editing Mode Enabled • Touch page to position annotation'),
          findsOneWidget,
        );

        // Verify sub-tools: Crop, Filter, Rotate, Erase, Sign
        expect(find.text('Crop'), findsOneWidget);
        expect(find.text('Filter'), findsOneWidget);
        expect(find.text('Rotate'), findsOneWidget);
        expect(find.text('Erase'), findsOneWidget);
        expect(find.text('Sign'), findsOneWidget);

        // Tap Close (x) icon to revert
        await tester.tap(find.byIcon(Symbols.close_rounded).first);
        await tester.pumpAndSettle();

        expect(
          find.text('Editing Mode Enabled • Touch page to position annotation'),
          findsNothing,
        );
      },
    );

    testWidgets(
      '3. post_scan_viewer_crop_tier_toggling opens 3rd-tier elevated crop bar',
      (WidgetTester tester) async {
        setTestViewport(tester);
        await tester.pumpWidget(
          buildApp('${AppRoutes.postScanViewer}?tier=edit'),
        );
        await tester.pumpAndSettle();

        // Tap Crop in sub-tool row
        await tester.tap(find.text('Crop'));
        await tester.pumpAndSettle();

        // Check top bar in crop mode
        expect(find.text('Crop & Perspective'), findsOneWidget);
        expect(find.text('Auto Edge Detection ON'), findsOneWidget);

        // Aspect pills and crop overlay
        expect(find.text('Free'), findsOneWidget);
        expect(find.text('Original'), findsOneWidget);
        expect(find.text('A4'), findsOneWidget);
        expect(find.byType(CropOverlay), findsOneWidget);
      },
    );

    testWidgets(
      '4. post_scan_viewer_ocr_panel_toggling shows preview and copy toast',
      (WidgetTester tester) async {
        setTestViewport(tester);
        await tester.pumpWidget(buildApp(AppRoutes.postScanViewer));
        await tester.pumpAndSettle();

        // Tap Copy Text to toggle OCR panel
        await tester.tap(find.text('Copy Text'));
        await tester.pumpAndSettle();

        expect(find.byType(PostScanOcrPanel), findsOneWidget);
        expect(find.text('Extracted Text Preview'), findsOneWidget);
        expect(find.text('84 words • 98% accuracy'), findsOneWidget);
        expect(find.text('Copy All'), findsOneWidget);
        expect(find.text('TXT'), findsOneWidget);
        expect(find.text('Translate'), findsOneWidget);

        // Tap Copy All
        await tester.tap(find.text('Copy All'));
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 200));

        expect(find.text('Copied to Clipboard! Ready'), findsOneWidget);
      },
    );

    testWidgets(
      '5. post_scan_viewer_more_options_sheet shows 7 rows and renames doc',
      (WidgetTester tester) async {
        setTestViewport(tester);
        await tester.pumpWidget(buildApp(AppRoutes.postScanViewer));
        await tester.pumpAndSettle();

        // Tap More options icon in top bar
        await tester.tap(find.byTooltip('More options'));
        await tester.pumpAndSettle();

        expect(find.byType(DocumentMoreOptionsSheet), findsOneWidget);
        expect(find.text('Rename Document'), findsOneWidget);
        expect(find.text('Move to Folder'), findsOneWidget);
        expect(find.text('Manual Adjust / Reorder Pages'), findsOneWidget);
        expect(find.text('Image To (JPEG / PNG)'), findsOneWidget);
        expect(find.text('Document Details & Info'), findsOneWidget);
        expect(find.text('Delete Document'), findsOneWidget);

        // Tap Rename Document
        await tester.tap(find.text('Rename Document'));
        await tester.pumpAndSettle();

        expect(find.text('Document name'), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);

        // Enter new title and save
        await tester.enterText(find.byType(TextField), 'Tax Invoice 2026');
        await tester.tap(find.text('Save'));
        await tester.pumpAndSettle();

        expect(find.text('Tax Invoice 2026'), findsOneWidget);
      },
    );

    testWidgets(
      '6. saved_viewer_renders_and_shows_edit_dialog with radio choices',
      (WidgetTester tester) async {
        setTestViewport(tester);
        await tester.pumpWidget(buildApp('${AppRoutes.savedViewer}?frame=2'));
        await tester.pumpAndSettle();

        expect(find.byType(SavedDocumentViewerScreen), findsOneWidget);
        expect(find.byType(EditVersionDialog), findsOneWidget);
        expect(find.text('Which version do you want to edit?'), findsOneWidget);
        expect(find.text('Original document'), findsOneWidget);
        expect(find.text('Last edited document'), findsOneWidget);

        // Tap Continue
        await tester.tap(find.text('Continue'));
        await tester.pumpAndSettle();

        expect(find.byType(EditVersionDialog), findsNothing);
        expect(find.text('Crop'), findsOneWidget);
        expect(find.text('Filter'), findsOneWidget);
      },
    );

    testWidgets(
      '7. saved_viewer_pdf_sub_row_and_sheet toggles PDF tools and sheet',
      (WidgetTester tester) async {
        setTestViewport(tester);
        await tester.pumpWidget(buildApp('${AppRoutes.savedViewer}?frame=5'));
        await tester.pumpAndSettle();

        expect(find.byType(PdfMoreOptionsSheet), findsOneWidget);
        expect(find.text('More PDF options'), findsOneWidget);
        expect(find.text('Header and footer'), findsOneWidget);
        expect(find.text('Open with...'), findsOneWidget);
        expect(find.text('PDF background color'), findsOneWidget);
        expect(find.text('Resize'), findsOneWidget);

        // Dismiss sheet
        await tester.tap(find.byIcon(Symbols.close_rounded).first);
        await tester.pumpAndSettle();

        expect(find.text('Compress'), findsOneWidget);
        expect(find.text('Fit Type'), findsOneWidget);
        expect(find.text('Page Size'), findsOneWidget);
      },
    );

    testWidgets(
      '8. page_manager_renders_grid_and_opens_saved_viewer and searches',
      (WidgetTester tester) async {
        setTestViewport(tester);
        await tester.pumpWidget(buildApp(AppRoutes.pageManager));
        await tester.pumpAndSettle();

        expect(find.byType(PageManagerScreen), findsOneWidget);
        expect(find.text('Doc Scanner 10 Oct 2026 12-02'), findsOneWidget);
        expect(find.text('Cloud Synced'), findsOneWidget);
        expect(find.text('Page 1'), findsOneWidget);
        expect(find.text('Page 2'), findsOneWidget);
        expect(find.text('Page 3'), findsOneWidget);
        expect(find.text('Page 4'), findsOneWidget);
        expect(find.byType(LabelledDualPillFab), findsOneWidget);
        expect(find.text('Scan Page'), findsOneWidget);
        expect(find.text('Import'), findsOneWidget);

        // Switch to search view by tapping search icon
        await tester.tap(find.byTooltip('Search document'));
        await tester.pumpAndSettle();

        expect(find.text('2 occurrences in 2 pages'), findsOneWidget);
        expect(find.text('Page 1 Match'), findsOneWidget);
        expect(find.text('Page 3 Match'), findsOneWidget);

        // Tap Jump to line
        await tester.tap(find.text('Jump to line').first);
        await tester.pumpAndSettle();

        expect(find.byType(SavedDocumentViewerScreen), findsOneWidget);
      },
    );

    testWidgets('9. page_manager_search_direct_route_renders_results', (
      WidgetTester tester,
    ) async {
      setTestViewport(tester);
      await tester.pumpWidget(
        buildApp('${AppRoutes.pageManager}?state=search&q=Invoice'),
      );
      await tester.pumpAndSettle();

      expect(find.byType(PageManagerSearchView), findsOneWidget);
      expect(find.text('PDF Ready (1.8 MB)'), findsOneWidget);
      expect(find.text('Page 1 Match'), findsOneWidget);
      expect(find.text('Page 3 Match'), findsOneWidget);
    });
  });
}
