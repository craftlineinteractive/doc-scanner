import 'package:docscanner/core/theme/app_theme.dart';
import 'package:docscanner/core/widgets/chips/days_left_chip.dart';
import 'package:docscanner/core/widgets/dialogs/confirm_dialog.dart';
import 'package:docscanner/features/trash/application/trash_providers.dart';
import 'package:docscanner/features/trash/data/mock_trash.dart';
import 'package:docscanner/features/trash/data/mock_trash_repository.dart';
import 'package:docscanner/features/trash/presentation/screens/trash_screen.dart';
import 'package:docscanner/features/trash/presentation/sheets/trash_item_options_sheet.dart';
import 'package:docscanner/features/trash/presentation/widgets/trash_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildTrashApp({
  String initialState = 'list',
}) {
  return ProviderScope(
    overrides: [
      trashRepositoryProvider.overrideWithValue(
        MockTrashRepository(items: List.from(mockTrashItems)),
      ),
    ],
    child: MaterialApp(
      theme: AppTheme.light,
      home: TrashScreen(initialState: initialState),
    ),
  );
}

void main() {
  group('M7: Trash Suite Tests', () {
    testWidgets('1. trash_renders_folders_and_documents_sections',
        (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildTrashApp());
      await tester.pumpAndSettle();

      expect(find.text('Trash'), findsOneWidget);
      expect(
        find.text('Items in Trash are deleted automatically after 30 days.'),
        findsOneWidget,
      );
      expect(find.text('FOLDERS (1)'), findsOneWidget);
      expect(find.text('DOCUMENTS (6)'), findsOneWidget);
      expect(find.text('Old Client Files'), findsOneWidget);
      expect(find.text('Doc Scanner 10 Oct 2026 7-49 pm'), findsOneWidget);
      expect(find.text('kunjbhai'), findsOneWidget);
      expect(find.text('pravinaben'), findsOneWidget);
    });

    testWidgets('2. trash_days_left_chip_coloring', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildTrashApp());
      await tester.pumpAndSettle();

      // Scroll down to locate the critical 2 days left chip
      await tester.scrollUntilVisible(
        find.text('Scan_Receipt_Oct'),
        200,
        scrollable: find.byType(Scrollable),
      );
      await tester.pumpAndSettle();

      final Finder twoDaysFinder = find.widgetWithText(DaysLeftChip, '2 days left');
      expect(twoDaysFinder, findsOneWidget);

      final Finder twentyNineFinder =
          find.widgetWithText(DaysLeftChip, '29 days left').first;
      expect(twentyNineFinder, findsOneWidget);
    });

    testWidgets('3. trash_restore_and_undo_and_missing_folder', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildTrashApp());
      await tester.pumpAndSettle();

      // Tap options icon on the first document
      final Finder firstDocCard = find.widgetWithText(
        TrashCard,
        'Doc Scanner 10 Oct 2026 7-49 pm',
      );
      expect(firstDocCard, findsOneWidget);

      final Finder optionsButton = find.descendant(
        of: firstDocCard,
        matching: find.byType(IconButton),
      );
      await tester.tap(optionsButton);
      await tester.pumpAndSettle();

      expect(find.byType(TrashItemOptionsSheet), findsOneWidget);
      expect(find.text('Restore'), findsOneWidget);

      // Tap restore
      await tester.tap(find.text('Restore'));
      await tester.pumpAndSettle();

      expect(find.text('Restored to Home'), findsOneWidget);
      expect(find.text('Undo'), findsOneWidget);
      expect(find.text('DOCUMENTS (5)'), findsOneWidget);

      // Tap Undo
      await tester.tap(find.text('Undo'));
      await tester.pumpAndSettle();

      expect(find.text('DOCUMENTS (6)'), findsOneWidget);
      expect(find.text('Doc Scanner 10 Oct 2026 7-49 pm'), findsOneWidget);

      // Now restore pravinaben (has originalFolderMissing = true)
      final Finder pravinabenCard = find.widgetWithText(
        TrashCard,
        'pravinaben',
      );
      final Finder pravinaOptions = find.descendant(
        of: pravinabenCard,
        matching: find.byType(IconButton),
      );
      await tester.tap(pravinaOptions);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Restore'));
      await tester.pumpAndSettle();

      expect(
        find.text('Original folder no longer exists. Restored to Home.'),
        findsOneWidget,
      );
    });

    testWidgets('4. trash_selection_mode_and_delete_forever', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildTrashApp());
      await tester.pumpAndSettle();

      // Long press first doc to start select
      await tester.longPress(find.text('Doc Scanner 10 Oct 2026 7-49 pm'));
      await tester.pumpAndSettle();

      expect(find.text('1 selected'), findsOneWidget);

      // Tap second doc to add to selection
      await tester.tap(find.text('kunjbhai'));
      await tester.pumpAndSettle();

      expect(find.text('2 selected'), findsOneWidget);

      // Tap Delete forever in bottom bar
      await tester.tap(find.text('Delete forever'));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialog), findsOneWidget);
      expect(find.text('Delete forever?'), findsOneWidget);
      expect(
        find.text(
          "These items will be permanently deleted. This can't be undone.",
        ),
        findsOneWidget,
      );

      // Confirm delete
      await tester.tap(find.widgetWithText(TextButton, 'Delete'));
      await tester.pumpAndSettle();

      expect(find.text('DOCUMENTS (4)'), findsOneWidget);
      expect(find.text('Doc Scanner 10 Oct 2026 7-49 pm'), findsNothing);
      expect(find.text('kunjbhai'), findsNothing);
    });

    testWidgets('5. trash_empty_trash_action', (tester) async {
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      await tester.pumpWidget(_buildTrashApp());
      await tester.pumpAndSettle();

      // Open top menu
      final Finder topMoreButton = find.byType(PopupMenuButton<String>);
      await tester.tap(topMoreButton);
      await tester.pumpAndSettle();

      expect(find.text('Empty trash'), findsOneWidget);

      // Tap Empty trash
      await tester.tap(find.text('Empty trash'));
      await tester.pumpAndSettle();

      expect(find.byType(ConfirmDialog), findsOneWidget);
      expect(find.text('Empty trash?'), findsOneWidget);

      // Confirm Empty
      await tester.tap(find.widgetWithText(TextButton, 'Delete'));
      await tester.pumpAndSettle();

      expect(find.text('Trash is empty'), findsOneWidget);
      expect(
        find.text('Deleted documents appear here for 30 days.'),
        findsOneWidget,
      );
      expect(find.text('FOLDERS (1)'), findsNothing);
    });
  });
}
