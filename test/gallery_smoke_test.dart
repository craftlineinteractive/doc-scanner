import 'package:docscanner/app/app.dart';
import 'package:docscanner/app/app_router.dart';
import 'package:docscanner/dev/ui_gallery/gallery_entries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

class _SmokeConfig {
  const _SmokeConfig({
    required this.name,
    required this.size,
    required this.textScaler,
    required this.themeMode,
  });

  final String name;
  final Size size;
  final TextScaler textScaler;
  final ThemeMode themeMode;
}

const List<_SmokeConfig> _kConfigs = <_SmokeConfig>[
  _SmokeConfig(
    name: '360x800-scale1.0-light',
    size: Size(360, 800),
    textScaler: TextScaler.linear(1.0),
    themeMode: ThemeMode.light,
  ),
  _SmokeConfig(
    name: '430x932-scale1.0-light',
    size: Size(430, 932),
    textScaler: TextScaler.linear(1.0),
    themeMode: ThemeMode.light,
  ),
  _SmokeConfig(
    name: '360x800-scale1.3-light',
    size: Size(360, 800),
    textScaler: TextScaler.linear(1.3),
    themeMode: ThemeMode.light,
  ),
  _SmokeConfig(
    name: '360x800-scale1.0-dark',
    size: Size(360, 800),
    textScaler: TextScaler.linear(1.0),
    themeMode: ThemeMode.dark,
  ),
];

class _MockThemeModeNotifier extends ThemeModeNotifier {
  _MockThemeModeNotifier(this._initial);
  final ThemeMode _initial;

  @override
  ThemeMode build() => _initial;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
    FlutterError.onError = (FlutterErrorDetails details) {
      debugPrint('CAUGHT FLUTTER ERROR:\n${details.toString()}');
    };
  });

  group('M10 Gallery Smoke Test Suite', () {
    for (final GalleryEntry entry in kGalleryEntries) {
      testWidgets('Smoke test: [${entry.group}] ${entry.title}', (
        WidgetTester tester,
      ) async {
        for (final _SmokeConfig config in _kConfigs) {
          FlutterErrorDetails? caughtDetails;
          final void Function(FlutterErrorDetails)? originalOnError =
              FlutterError.onError;
          FlutterError.onError = (FlutterErrorDetails details) {
            caughtDetails = details;
            originalOnError?.call(details);
          };

          tester.view.physicalSize = Size(
            config.size.width * tester.view.devicePixelRatio,
            config.size.height * tester.view.devicePixelRatio,
          );
          addTearDown(tester.view.resetPhysicalSize);

          final router = createRouter(initialLocation: entry.route);
          final container = ProviderContainer(
            overrides: [
              themeModeProvider.overrideWith(
                () => _MockThemeModeNotifier(config.themeMode),
              ),
              routerProvider.overrideWithValue(router),
            ],
          );
          addTearDown(container.dispose);

          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: container,
              child: MediaQuery(
                data: MediaQueryData(
                  size: config.size,
                  textScaler: config.textScaler,
                  platformBrightness: config.themeMode == ThemeMode.dark
                      ? Brightness.dark
                      : Brightness.light,
                ),
                child: const DocScannerApp(),
              ),
            ),
          );

          // Use fixed pump durations instead of pumpAndSettle to prevent hanging on repeating animations
          await tester.pump(const Duration(milliseconds: 100));
          await tester.pump(const Duration(milliseconds: 200));

          final dynamic error = tester.takeException();
          if (caughtDetails != null || error != null) {
            debugPrint('>>> ERROR IN ${entry.title} (${config.name}):');
            if (caughtDetails != null) {
              debugPrint('DETAILS: ${caughtDetails!.summary}');
              for (final diag
                  in caughtDetails!.informationCollector?.call() ??
                      <DiagnosticsNode>[]) {
                debugPrint(diag.toStringDeep());
              }
            }
            if (error != null) {
              debugPrint('ERROR: $error');
            }
          }
          expect(
            caughtDetails,
            isNull,
            reason:
                'Smoke test layout error on "${entry.title}" (${entry.route}) under configuration ${config.name}',
          );
          expect(
            error,
            isNull,
            reason:
                'Smoke test exception on "${entry.title}" (${entry.route}) under configuration ${config.name}',
          );
        }
      });
    }
  });
}
