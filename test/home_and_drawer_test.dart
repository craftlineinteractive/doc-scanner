import 'package:docscanner/core/constants/app_strings.dart';
import 'package:docscanner/core/theme/app_theme.dart';
import 'package:docscanner/core/widgets/cards/document_grid_card.dart';
import 'package:docscanner/core/widgets/cards/document_list_card.dart';
import 'package:docscanner/core/widgets/cards/folder_tile.dart';
import 'package:docscanner/core/widgets/navigation/app_top_bar.dart';
import 'package:docscanner/features/drawer/application/drawer_providers.dart';
import 'package:docscanner/features/drawer/presentation/widgets/app_drawer.dart';
import 'package:docscanner/features/home/application/home_providers.dart';
import 'package:docscanner/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';

void main() {
  setUp(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Home shows 3 folder tiles and 7 document cards with mock data', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
      ),
    );
    await tester.pump();

    expect(find.byType(FolderTile), findsNWidgets(3));
    expect(find.text('Client Files'), findsOneWidget);
    expect(find.text('Property Docs'), findsOneWidget);
    expect(find.text('Personal IDs'), findsOneWidget);

    expect(find.byType(DocumentListCard), findsNWidgets(7));
    expect(find.text('sunilkumar_prajapati'), findsOneWidget);
  });

  testWidgets('Tapping the plus half of DualPillFab opens Add Document sheet', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
      ),
    );
    await tester.pump();

    // Tap plus icon on DualPillFab
    await tester.tap(find.byIcon(Symbols.add_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Add Document'), findsOneWidget);
    expect(find.text('From Gallery'), findsOneWidget);
    expect(find.text('PDF as Image'), findsOneWidget);
    expect(find.text('Import Documents'), findsOneWidget);
  });

  testWidgets('View Mode toggle switches the list to a grid', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
      ),
    );
    await tester.pump();

    expect(find.byType(DocumentListCard), findsNWidgets(7));
    expect(find.byType(DocumentGridCard), findsNothing);

    // Open overflow menu by targeting the top bar more button
    final Finder topBarMoreBtn = find.descendant(
      of: find.byType(AppTopBar),
      matching: find.byIcon(Symbols.more_vert_rounded),
    );
    await tester.tap(topBarMoreBtn);
    await tester.pumpAndSettle();

    // Tap View Mode to toggle to Grid
    await tester.tap(find.text('View Mode'));
    await tester.pumpAndSettle();

    expect(find.byType(DocumentGridCard), findsNWidgets(7));
    expect(find.byType(DocumentListCard), findsNothing);
  });

  testWidgets('Drawer shows user name and sync status when signed in', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            drawer: const AppDrawer(),
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Prince Patel'), findsOneWidget);
    expect(find.text('patelprince2598@gmail.com'), findsOneWidget);
    expect(find.text('Synced'), findsOneWidget);
  });

  testWidgets('Drawer shows Sign in with Google when signed out', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          drawerUserProvider.overrideWith(SignedOutDrawerUserNotifier.new),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            drawer: const AppDrawer(),
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Back up your documents'), findsOneWidget);
    expect(find.text(AppStrings.signInWithGoogle), findsOneWidget);
  });

  testWidgets(
    'Empty repository shows Scan your first document onboarding view',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            homeRepositoryProvider.overrideWith(
              EmptyHomeRepositoryNotifier.new,
            ),
          ],
          child: MaterialApp(theme: AppTheme.light, home: const HomeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.scanFirstDoc), findsOneWidget);
      expect(find.text('Tap camera to scan'), findsOneWidget);
      expect(find.text('Tap + to import files'), findsOneWidget);
      expect(find.byType(DocumentListCard), findsNothing);
      expect(find.byType(FolderTile), findsNothing);
    },
  );
}
