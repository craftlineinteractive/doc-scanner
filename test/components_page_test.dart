import 'package:docscanner/core/theme/app_theme.dart';
import 'package:docscanner/dev/ui_gallery/components_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ComponentsPage renders all primitive sections in light theme',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const ComponentsPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('UI Components Kit'), findsOneWidget);
    expect(find.text('Navigation Primitives'), findsOneWidget);
    expect(find.text('Buttons & Actions'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Inputs & Controls'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Inputs & Controls'), findsOneWidget);
  });

  testWidgets('ComponentsPage switches to Dark and Camera themes cleanly',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: const ComponentsPage(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // Switch to Dark
    await tester.tap(find.text('Dark'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Dark'), findsOneWidget);

    // Switch to Camera
    await tester.tap(find.text('Camera'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('Camera'), findsOneWidget);
  });
}
