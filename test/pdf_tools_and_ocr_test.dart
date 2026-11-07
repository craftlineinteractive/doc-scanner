import 'package:docscanner/app/app_router.dart';
import 'package:docscanner/app/routes.dart';
import 'package:docscanner/core/widgets/mock/mock_document_page.dart';
import 'package:docscanner/features/drawer/presentation/widgets/app_drawer.dart';
import 'package:docscanner/features/ocr/presentation/screens/ocr_result_screen.dart';
import 'package:docscanner/features/pdf_tools/data/mock_pdf_document.dart';
import 'package:docscanner/features/pdf_tools/domain/pdf_search_match.dart';
import 'package:docscanner/features/pdf_tools/presentation/screens/pdf_viewer_screen.dart';
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
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }

  void setTestViewport(WidgetTester tester) {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.resetPhysicalSize);
  }

  group('M6: PDF Tools & OCR Result Suite Tests', () {
    test('1. pure_search_matching_finds_3_matches_for_financial_and_0_for_nonsense', () {
      final List<PdfSearchMatch> matches = findPdfSearchMatches(
        MockPdfDocument.pages,
        'financial',
      );

      expect(matches.length, 3);
      expect(matches[0].pageIndex, 0); // Page 1: Financial Highlights
      expect(matches[1].pageIndex, 0); // Page 1: Financial Year 2026
      expect(matches[2].pageIndex, 2); // Page 3: ...financial growth...

      final List<PdfSearchMatch> zero = findPdfSearchMatches(
        MockPdfDocument.pages,
        'xyzrandomnonsenseword',
      );
      expect(zero.isEmpty, isTrue);
    });

    testWidgets('2. pdf_viewer_renders_and_tapping_toolkit_opens_sheet_with_14_tools', (WidgetTester tester) async {
      setTestViewport(tester);
      await tester.pumpWidget(buildApp(AppRoutes.pdfViewer));
      await tester.pumpAndSettle();

      expect(find.byType(PdfViewerScreen), findsOneWidget);
      expect(find.text('Annual_Report_2026_Q3.pdf'), findsOneWidget);
      expect(find.text('Toolkit'), findsOneWidget);

      // Tap Toolkit on bottom dock
      await tester.tap(find.text('Toolkit'));
      await tester.pumpAndSettle();

      expect(find.text('PDF Toolkit'), findsOneWidget);
      expect(find.text('14 TOOLS'), findsOneWidget);
      expect(find.text('9 actions'), findsOneWidget);

      // Check key tools
      expect(find.text('Open PDF'), findsOneWidget);
      expect(find.text('Merge Files'), findsOneWidget);
      expect(find.text('Add Gallery'), findsOneWidget);
      expect(find.text('Split PDF'), findsOneWidget);
      expect(find.text('Page Size'), findsOneWidget);
      expect(find.text('Rotate/Del'), findsOneWidget);
      expect(find.text('Add Pass'), findsOneWidget);
      expect(find.text('Unlock'), findsOneWidget);
      expect(find.text('Signature'), findsOneWidget);
      expect(find.text('To Image'), findsOneWidget);
      expect(find.text('To Text'), findsOneWidget);
      expect(find.text('To ZIP'), findsOneWidget);
      expect(find.text('Image to PDF'), findsOneWidget);
      expect(find.text('Text to PDF'), findsOneWidget);
    });

    testWidgets('3. pdf_viewer_tapping_to_text_in_toolkit_navigates_to_ocr', (WidgetTester tester) async {
      setTestViewport(tester);
      await tester.pumpWidget(buildApp('${AppRoutes.pdfViewer}?state=toolkit'));
      await tester.pumpAndSettle();

      expect(find.text('To Text'), findsOneWidget);
      await tester.tap(find.text('To Text'));
      await tester.pumpAndSettle();

      expect(find.byType(OcrResultScreen), findsOneWidget);
      expect(find.text('Extracted Text'), findsOneWidget);
      expect(find.text('99.4% OCR'), findsOneWidget);
    });

    testWidgets('4. pdf_viewer_search_cycles_and_wraps_matches', (WidgetTester tester) async {
      setTestViewport(tester);
      await tester.pumpWidget(buildApp('${AppRoutes.pdfViewer}?state=search&q=Financial'));
      await tester.pumpAndSettle();

      expect(find.text('1 / 3'), findsOneWidget);
      expect(find.textContaining('3 Matches'), findsOneWidget);

      // Down arrow -> next match (2 / 3)
      await tester.tap(find.byIcon(Symbols.keyboard_arrow_down_rounded));
      await tester.pumpAndSettle();
      expect(find.text('2 / 3'), findsOneWidget);

      // Down arrow -> 3 / 3
      await tester.tap(find.byIcon(Symbols.keyboard_arrow_down_rounded));
      await tester.pumpAndSettle();
      expect(find.text('3 / 3'), findsOneWidget);

      // Down arrow -> wraps back to 1 / 3
      await tester.tap(find.byIcon(Symbols.keyboard_arrow_down_rounded));
      await tester.pumpAndSettle();
      expect(find.text('1 / 3'), findsOneWidget);
    });

    testWidgets('5. pdf_viewer_help_dialog_opens_and_closes', (WidgetTester tester) async {
      setTestViewport(tester);
      await tester.pumpWidget(buildApp('${AppRoutes.pdfViewer}?state=help'));
      await tester.pumpAndSettle();

      expect(find.text('How to Use PDF Tools'), findsOneWidget);
      expect(find.text('View & Navigate'), findsOneWidget);
      expect(find.text('PDF Toolkit Hub'), findsOneWidget);
      expect(find.text('Convert & Export'), findsOneWidget);
      expect(find.text('Search in Document'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('256-Bit Encryption'),
        100,
        scrollable: find.byType(Scrollable).last,
      );
      expect(find.text('256-Bit Encryption'), findsOneWidget);

      // Tap Got It button
      await tester.tap(find.text('Got It, Let’s Start'));
      await tester.pumpAndSettle();

      expect(find.text('How to Use PDF Tools'), findsNothing);
    });

    testWidgets('6. ocr_result_edit_mode_toggles_and_saves_text', (WidgetTester tester) async {
      setTestViewport(tester);
      await tester.pumpWidget(buildApp(AppRoutes.ocrResult));
      await tester.pumpAndSettle();

      expect(find.text('Extracted Text'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);

      // Tap Edit
      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Done'), findsOneWidget);

      // Update text in TextField
      await tester.enterText(
        find.byType(TextField),
        'MODIFIED TEST CONTRACT\n\n1. Updated scope of services.',
      );
      await tester.pump();

      // Tap Done
      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();

      expect(find.text('Done'), findsNothing);
      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('MODIFIED TEST CONTRACT'), findsOneWidget);
    });

    testWidgets('7. ocr_result_tapping_summary_card_toggles_preview', (WidgetTester tester) async {
      setTestViewport(tester);
      await tester.pumpWidget(buildApp(AppRoutes.ocrResult));
      await tester.pumpAndSettle();

      expect(find.text('Scanned Document'), findsOneWidget);

      // Initially preview is collapsed
      await tester.tap(find.text('Scanned Document'));
      await tester.pumpAndSettle();

      expect(find.byType(MockDocumentPage), findsOneWidget);

      // Tap again to collapse
      await tester.tap(find.text('Scanned Document'));
      await tester.pumpAndSettle();
    });

    testWidgets('8. drawer_pdf_tools_entry_opens_pdf_viewer', (WidgetTester tester) async {
      setTestViewport(tester);
      await tester.pumpWidget(buildApp(AppRoutes.drawerToolsOther));
      await tester.pumpAndSettle();

      final Finder pdfToolsFinder = find.text('PDF Tools');
      final Finder drawerScrollable = find.descendant(
        of: find.byType(AppDrawer),
        matching: find.byType(Scrollable),
      );

      await tester.scrollUntilVisible(
        pdfToolsFinder,
        100,
        scrollable: drawerScrollable,
      );
      expect(pdfToolsFinder, findsOneWidget);

      await tester.tap(pdfToolsFinder);
      await tester.pumpAndSettle();

      expect(find.byType(PdfViewerScreen), findsOneWidget);
      expect(find.text('Annual_Report_2026_Q3.pdf'), findsOneWidget);
    });
  });
}
