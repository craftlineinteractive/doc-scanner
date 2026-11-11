import 'package:docscanner/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App boots and renders initial screen smoke test', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: DocScannerApp()));

    await tester.pumpAndSettle();

    // Verify app starts up and displays initial UI gallery screen
    expect(find.text('UI Gallery'), findsOneWidget);
    expect(find.text('DEBUG ONLY'), findsOneWidget);
  });
}
