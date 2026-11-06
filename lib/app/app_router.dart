import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/feedback/placeholder_screen.dart';
import '../dev/ui_gallery/components_page.dart';
import '../dev/ui_gallery/ui_gallery_screen.dart';
import '../features/camera/presentation/screens/camera_screen.dart';
import '../features/drawer/presentation/screens/drawer_preview_screen.dart';
import '../features/document_viewer/presentation/screens/post_scan_viewer_screen.dart';
import '../features/home/application/home_providers.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/scan_review/presentation/screens/adjust_screen.dart';
import '../features/scan_review/presentation/screens/arrange_pages_screen.dart';
import '../features/scan_review/presentation/screens/review_scan_screen.dart';
import 'routes.dart';

/// Provider for application GoRouter instance.
final Provider<GoRouter> routerProvider = Provider<GoRouter>((Ref ref) {
  return createRouter();
});

/// Factory function to construct GoRouter configuration.
GoRouter createRouter({String? initialLocation}) {
  return GoRouter(
    initialLocation: initialLocation ??
        (kDebugMode ? AppRoutes.gallery : AppRoutes.home),
    routes: <RouteBase>[
      // Dev routes
      GoRoute(
        path: AppRoutes.gallery,
        builder: (context, state) => const UiGalleryScreen(),
      ),
      GoRoute(
        path: AppRoutes.components,
        builder: (context, state) => const ComponentsPage(),
      ),

      // 01 Home
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) {
          final String? mode = state.uri.queryParameters['mode'];
          final bool showOverflow = state.uri.queryParameters['overflow'] == 'true';
          final bool importExpanded = state.uri.queryParameters['importExpanded'] == 'true';
          final bool showAddSheet = state.uri.queryParameters['addSheet'] == 'true';

          return ProviderScope(
            overrides: [
              if (mode == 'grid')
                homeViewModeProvider.overrideWith(
                  GridHomeViewModeNotifier.new,
                ),
            ],
            child: HomeScreen(
              initialShowOverflowMenu: showOverflow,
              initialShowImportExpanded: importExpanded,
              initialShowAddSheet: showAddSheet,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.homeEmpty,
        builder: (context, state) => ProviderScope(
          overrides: [
            homeRepositoryProvider.overrideWith(
              EmptyHomeRepositoryNotifier.new,
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.drawerSignedIn,
        builder: (context, state) => const DrawerPreviewScreen(),
      ),
      GoRoute(
        path: AppRoutes.drawerSignedOut,
        builder: (context, state) =>
            const DrawerPreviewScreen(initialSignedOut: true),
      ),
      GoRoute(
        path: AppRoutes.drawerToolsOther,
        builder: (context, state) => const DrawerPreviewScreen(
          initialToolsExpanded: true,
          initialOtherExpanded: true,
        ),
      ),

      // 03 Camera
      GoRoute(
        path: AppRoutes.camera,
        builder: (context, state) {
          final mode = state.uri.queryParameters['mode'];
          final panel = state.uri.queryParameters['panel'];
          final dialog = state.uri.queryParameters['dialog'];
          final flash = state.uri.queryParameters['flash'];
          return CameraScreen(
            initialMode: mode,
            initialPanel: panel,
            initialDialog: dialog,
            initialFlash: flash,
          );
        },
      ),

      // 04 Scan Review
      GoRoute(
        path: AppRoutes.adjust,
        builder: (context, state) {
          final sheet = state.uri.queryParameters['sheet'];
          final dialog = state.uri.queryParameters['dialog'];
          final drag = state.uri.queryParameters['drag'];
          return AdjustScreen(
            initialSheet: sheet,
            initialDialog: dialog,
            initialDrag: drag,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.adjustShort,
        builder: (context, state) {
          final sheet = state.uri.queryParameters['sheet'];
          final dialog = state.uri.queryParameters['dialog'];
          final drag = state.uri.queryParameters['drag'];
          return AdjustScreen(
            initialSheet: sheet,
            initialDialog: dialog,
            initialDrag: drag,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.reviewScan,
        builder: (context, state) {
          final mode = state.uri.queryParameters['mode'];
          final dialog = state.uri.queryParameters['dialog'];
          return ReviewScanScreen(
            initialMode: mode,
            initialDialog: dialog,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.reviewScanShort,
        builder: (context, state) {
          final mode = state.uri.queryParameters['mode'];
          final dialog = state.uri.queryParameters['dialog'];
          return ReviewScanScreen(
            initialMode: mode,
            initialDialog: dialog,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.arrangePages,
        builder: (context, state) => const ArrangePagesScreen(),
      ),
      GoRoute(
        path: AppRoutes.arrangePagesShort,
        builder: (context, state) => const ArrangePagesScreen(),
      ),

      // 05 Document Viewer
      GoRoute(
        path: AppRoutes.postScanViewer,
        builder: (context, state) {
          final String docId =
              state.uri.queryParameters['id'] ?? 'doc_post_scan';
          final String? tier = state.uri.queryParameters['tier'];
          final String? panel = state.uri.queryParameters['panel'];
          final int page =
              int.tryParse(state.uri.queryParameters['page'] ?? '0') ?? 0;
          return PostScanViewerScreen(
            initialDocId: docId,
            initialTier: tier,
            initialPanel: panel,
            initialPageIndex: page,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.savedViewer,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Saved Document Viewer Screen',
          subtitle: '02_saved_document_viewer_suite',
        ),
      ),
      GoRoute(
        path: AppRoutes.pageManager,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Multi-Page Manager Screen',
          subtitle: '03_multi_page_manager_suite with search & action drawer',
        ),
      ),

      // 06 PDF Tools
      GoRoute(
        path: AppRoutes.pdfViewer,
        builder: (context, state) => const PlaceholderScreen(
          title: 'PDF Viewer & Toolkit',
          subtitle: '01_pdf_tools_toolkit_suite (14 tools)',
        ),
      ),

      // 07 OCR
      GoRoute(
        path: AppRoutes.ocrResult,
        builder: (context, state) => const PlaceholderScreen(
          title: 'OCR Result Screen',
          subtitle: '01_ocr_result_screen text extraction view',
        ),
      ),

      // 08 Trash
      GoRoute(
        path: AppRoutes.trash,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Trash Screen',
          subtitle: '01_trash_suite with 30-day retention',
        ),
      ),

      // 09 Settings
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Settings Screen',
          subtitle: '01_settings_suite (6 interaction states)',
        ),
      ),

      // 10 Premium
      GoRoute(
        path: AppRoutes.premium,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Premium Paywall Screen',
          subtitle: '01_premium_paywall with plan picker and trial',
        ),
      ),
    ],
  );
}

