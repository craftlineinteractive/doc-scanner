import 'package:docscanner/app/app.dart';
import 'package:docscanner/core/theme/app_theme.dart';
import 'package:docscanner/features/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildSettingsApp({
  String? initialScroll,
  String? initialDialog,
  bool showHintOnStart = false,
}) {
  return ProviderScope(
    child: Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        final ThemeMode mode = ref.watch(themeModeProvider);
        return MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          home: SettingsScreen(
            initialScroll: initialScroll,
            initialDialog: initialDialog,
            showHintOnStart: showHintOnStart,
          ),
        );
      },
    ),
  );
}

void main() {
  group('M8 Settings Tests', () {
    testWidgets('All section labels render and version caption reads 1.0.0',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildSettingsApp());
      await tester.pumpAndSettle();

      expect(find.text('BACKUP & SYNC'), findsOneWidget);
      expect(find.text('APPEARANCE & HOME'), findsOneWidget);

      for (final String section in <String>[
        'PDF',
        'DOCUMENT',
        'OCR',
        'CAMERA',
        'APP',
        'ABOUT',
        'Doc Scanner version 1.0.0',
      ]) {
        await tester.scrollUntilVisible(
          find.text(section),
          150,
          scrollable: find.byType(Scrollable).first,
        );
        expect(find.text(section), findsOneWidget);
      }
    });

    testWidgets(
        'Tags off disables Favourite Documents and shows hint; turning Tags on enables it',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildSettingsApp());
      await tester.pumpAndSettle();

      // Tap Favourite Documents while Tags is off
      await tester.tap(find.text('Favourite Documents'));
      await tester.pumpAndSettle();

      expect(
        find.text('Turn on Tags to use Favourite Documents'),
        findsOneWidget,
      );

      // Now toggle Tags switch on
      await tester.tap(find.text('Tags'));
      await tester.pumpAndSettle();

      // Tapping Favourite Documents now toggles it without showing error hint
      await tester.tap(find.text('Favourite Documents'));
      await tester.pumpAndSettle();

      // Verify Favourite Documents switch state changed
      final Finder favSwitch = find.descendant(
        of: find.ancestor(
          of: find.text('Favourite Documents'),
          matching: find.byType(Row),
        ).first,
        matching: find.byType(Switch),
      );
      expect((tester.widget(favSwitch) as Switch).value, isTrue);

      // Turning Tags back off automatically resets Favourite Documents
      await tester.tap(find.text('Tags'));
      await tester.pumpAndSettle();

      expect((tester.widget(favSwitch) as Switch).value, isFalse);
    });

    testWidgets('Theme dialog: choosing Dark and OK changes app theme mode',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildSettingsApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Theme'));
      await tester.pumpAndSettle();

      expect(find.text('System default'), findsOneWidget);
      expect(find.text('Light'), findsNWidgets(2)); // tile value + radio
      expect(find.text('Dark'), findsOneWidget);

      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Dark'), findsOneWidget);
    });

    testWidgets('Scan quality dialog: choosing Original updates tile value',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildSettingsApp());
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Scan Quality'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Scan Quality'));
      await tester.pumpAndSettle();

      expect(find.text('Scan quality'), findsOneWidget);
      expect(find.text('Standard'), findsOneWidget);
      expect(find.text('Original'), findsOneWidget);

      await tester.tap(find.text('Original'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('Original'), findsOneWidget);
    });

    testWidgets('Recent documents count picker: choosing 25 updates tile',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildSettingsApp());
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(
        find.text('Recent Documents on Home'),
        150,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Recent Documents on Home'));
      await tester.pumpAndSettle();

      expect(find.text('Recent documents on home'), findsOneWidget);
      expect(find.text('COUNT'), findsOneWidget);
      expect(find.text('25'), findsOneWidget);

      await tester.tap(find.text('25'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

      expect(find.text('25'), findsOneWidget);
    });

    testWidgets('Reset dialog Cancel keeps values; Reset restores defaults',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildSettingsApp());
      await tester.pumpAndSettle();

      // Change Theme to Dark first
      await tester.tap(find.text('Theme'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();
      expect(find.text('Dark'), findsOneWidget);

      // Scroll to Reset Settings
      await tester.scrollUntilVisible(
        find.text('Reset Settings'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      // Tap Reset Settings -> Cancel
      await tester.tap(find.text('Reset Settings'));
      await tester.pumpAndSettle();
      expect(find.text('Reset all settings?'), findsOneWidget);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      // Scroll up to check Theme is still Dark
      await tester.scrollUntilVisible(
        find.text('Theme'),
        -300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      expect(find.text('Dark'), findsOneWidget);

      // Scroll back and confirm Reset
      await tester.scrollUntilVisible(
        find.text('Reset Settings'),
        300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Reset Settings'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Reset'));
      await tester.pumpAndSettle();

      expect(find.text('Settings reset'), findsOneWidget);

      // Scroll up to check Theme went back to Light
      await tester.scrollUntilVisible(
        find.text('Theme'),
        -300,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      expect(find.text('Light'), findsOneWidget);
    });
  });
}
