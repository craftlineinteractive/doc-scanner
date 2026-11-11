import 'package:docscanner/app/app.dart';
import 'package:docscanner/core/theme/app_theme.dart';
import 'package:docscanner/features/premium/presentation/screens/premium_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _buildPremiumApp({String? initialPlan}) {
  return ProviderScope(
    child: Consumer(
      builder: (BuildContext context, WidgetRef ref, _) {
        final ThemeMode mode = ref.watch(themeModeProvider);
        return MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: mode,
          home: PremiumScreen(initialPlan: initialPlan),
        );
      },
    ),
  );
}

void main() {
  group('M9 Premium Paywall Tests', () {
    testWidgets(
      'Header, Hero medallion, 8 features, and 3 plans render with Yearly default',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.5;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(_buildPremiumApp());
        await tester.pumpAndSettle();

        // Top bar title
        expect(find.text('Premium Paywall'), findsOneWidget);

        // Hero medallion text
        expect(find.text('Doc Scanner Pro'), findsOneWidget);
        expect(find.text('Scan without limits'), findsOneWidget);

        // 8 features in checklist
        expect(find.text('No ads'), findsOneWidget);
        expect(find.text('Unlimited OCR'), findsOneWidget);
        expect(find.text('All OCR languages'), findsOneWidget);
        expect(find.text('Cloud backup'), findsOneWidget);
        expect(find.text('Advanced filters'), findsOneWidget);
        expect(find.text('Batch export'), findsOneWidget);
        expect(find.text('Password PDF'), findsOneWidget);
        expect(find.text('Premium themes'), findsOneWidget);

        // 3 Plans
        expect(find.text('Yearly Access'), findsOneWidget);
        expect(find.text('3-Day Trial'), findsOneWidget);
        expect(find.text('Best Value · Save 60%'), findsOneWidget);
        expect(find.text('\$2.50'), findsOneWidget);
        expect(find.text('\$29.99/yr'), findsOneWidget);

        expect(find.text('Monthly Access'), findsOneWidget);
        expect(find.text('Flexible billing, cancel anytime'), findsOneWidget);
        expect(find.text('\$6.99'), findsOneWidget);

        expect(find.text('Weekly Access'), findsOneWidget);
        expect(find.text('Short-term priority scanning'), findsOneWidget);
        expect(find.text('\$2.99'), findsOneWidget);

        // Default CTA button & fine print
        expect(find.text('Start 3-Day Free Trial'), findsOneWidget);
        expect(
          find.text('Free for 3 days, then \$29.99/year. Cancel anytime.'),
          findsOneWidget,
        );
        expect(find.text('Restore Purchase'), findsOneWidget);
        expect(find.text('Terms of Service'), findsOneWidget);
        expect(find.text('Privacy Policy'), findsOneWidget);
      },
    );

    testWidgets('Selecting Monthly plan updates CTA label and fine print', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildPremiumApp());
      await tester.pumpAndSettle();

      // Tap Monthly Access card
      await tester.tap(find.text('Monthly Access'));
      await tester.pumpAndSettle();

      // CTA label and fine print change
      expect(find.text('Subscribe Monthly'), findsOneWidget);
      expect(
        find.text('Billed \$6.99 every month. Cancel anytime.'),
        findsOneWidget,
      );
    });

    testWidgets('Selecting Weekly plan updates CTA label and fine print', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.5;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(_buildPremiumApp());
      await tester.pumpAndSettle();

      // Tap Weekly Access card
      await tester.tap(find.text('Weekly Access'));
      await tester.pumpAndSettle();

      // CTA label and fine print change
      expect(find.text('Subscribe Weekly'), findsOneWidget);
      expect(
        find.text('Billed \$2.99 every week. Cancel anytime.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'Tapping CTA button, Restore, and Legal links triggers toasts',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.5;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(_buildPremiumApp());
        await tester.pumpAndSettle();

        // Tap CTA button
        await tester.tap(find.text('Start 3-Day Free Trial'));
        await tester.pump();
        expect(find.text('Purchases are coming later'), findsOneWidget);
        ScaffoldMessenger.of(
          tester.element(find.byType(PremiumScreen)),
        ).clearSnackBars();
        await tester.pumpAndSettle();

        // Tap Restore Purchase
        await tester.scrollUntilVisible(find.text('Restore Purchase'), 100);
        await tester.tap(find.text('Restore Purchase'));
        await tester.pump();
        expect(find.text('Purchases are coming later'), findsOneWidget);
        ScaffoldMessenger.of(
          tester.element(find.byType(PremiumScreen)),
        ).clearSnackBars();
        await tester.pumpAndSettle();

        // Tap Terms of Service
        await tester.scrollUntilVisible(find.text('Terms of Service'), 100);
        await tester.tap(find.text('Terms of Service'));
        await tester.pump();
        expect(find.text('Terms of Service is coming later'), findsOneWidget);
        ScaffoldMessenger.of(
          tester.element(find.byType(PremiumScreen)),
        ).clearSnackBars();
        await tester.pumpAndSettle();

        // Tap Privacy Policy
        await tester.scrollUntilVisible(find.text('Privacy Policy'), 100);
        await tester.tap(find.text('Privacy Policy'));
        await tester.pump();
        expect(find.text('Privacy Policy is coming later'), findsOneWidget);
        ScaffoldMessenger.of(
          tester.element(find.byType(PremiumScreen)),
        ).clearSnackBars();
        await tester.pumpAndSettle();
      },
    );

    testWidgets(
      'Deep link initialPlan=monthly initializes with Monthly selected',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(1080, 2400);
        tester.view.devicePixelRatio = 2.5;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(_buildPremiumApp(initialPlan: 'monthly'));
        await tester.pumpAndSettle();

        expect(find.text('Subscribe Monthly'), findsOneWidget);
        expect(
          find.text('Billed \$6.99 every month. Cancel anytime.'),
          findsOneWidget,
        );
      },
    );
  });
}
