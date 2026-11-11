import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../dev/ui_gallery/components_page.dart';
import '../dev/ui_gallery/ui_gallery_screen.dart';
import '../features/camera/presentation/screens/camera_screen.dart';
import '../features/drawer/presentation/screens/drawer_preview_screen.dart';
import '../features/document_viewer/presentation/screens/post_scan_viewer_screen.dart';
import '../features/document_viewer/presentation/screens/saved_document_viewer_screen.dart';
import '../features/ocr/presentation/screens/ocr_result_screen.dart';
import '../features/pdf_tools/presentation/screens/pdf_viewer_screen.dart';
import '../features/document_viewer/presentation/screens/page_manager_screen.dart';
import '../features/home/application/home_providers.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/scan_review/presentation/screens/adjust_screen.dart';
import '../features/scan_review/presentation/screens/arrange_pages_screen.dart';
import '../features/scan_review/presentation/screens/review_scan_screen.dart';
import '../features/premium/presentation/screens/premium_screen.dart';
import '../features/settings/presentation/screens/settings_screen.dart';
import '../features/trash/presentation/screens/trash_screen.dart';
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
    redirect: (BuildContext context, GoRouterState state) {
      final Uri uri = state.uri;
      if (uri.scheme == 'docscanner') {
        final String rawPath = uri.host.isNotEmpty
            ? '/${uri.host}${uri.path}'
            : (uri.path.isEmpty
                ? '/'
                : (uri.path.startsWith('/') ? uri.path : '/${uri.path}'));
        final String query = uri.hasQuery ? '?${uri.query}' : '';
        return '$rawPath$query';
      }
      return null;
    },
    routes: <RouteBase>[
      // Root redirect
      GoRoute(
        path: '/',
        redirect: (context, state) =>
            kDebugMode ? AppRoutes.gallery : AppRoutes.home,
      ),

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
        builder: (context, state) {
          final String docId =
              state.uri.queryParameters['id'] ?? 'doc_saved_5';
          final int? frame =
              int.tryParse(state.uri.queryParameters['frame'] ?? '');
          final int page =
              int.tryParse(state.uri.queryParameters['page'] ?? '0') ?? 0;
          return SavedDocumentViewerScreen(
            initialDocId: docId,
            initialFrame: frame,
            initialPageIndex: page,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.pageManager,
        builder: (context, state) {
          final String docId =
              state.uri.queryParameters['id'] ?? 'doc_multi_4';
          final String st = state.uri.queryParameters['state'] ?? 'grid';
          final String q = state.uri.queryParameters['q'] ?? 'Invoice';
          return PageManagerScreen(
            initialDocId: docId,
            initialState: st,
            initialQuery: q,
          );
        },
      ),

      // 06 PDF Tools
      GoRoute(
        path: AppRoutes.pdfViewer,
        builder: (context, state) {
          final String st = state.uri.queryParameters['state'] ?? 'default';
          final String q = state.uri.queryParameters['q'] ?? 'Financial';
          final int page =
              int.tryParse(state.uri.queryParameters['page'] ?? '0') ?? 0;
          return PdfViewerScreen(
            initialState: st,
            initialQuery: q,
            initialPage: page,
          );
        },
      ),

      // 07 OCR
      GoRoute(
        path: AppRoutes.ocrResult,
        builder: (context, state) {
          final String st = state.uri.queryParameters['state'] ?? 'default';
          return OcrResultScreen(initialState: st);
        },
      ),

      // 08 Trash
      GoRoute(
        path: AppRoutes.trash,
        builder: (context, state) {
          final String st = state.uri.queryParameters['state'] ?? 'list';
          return TrashScreen(initialState: st);
        },
      ),

      // 09 Settings
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) {
          final scroll = state.uri.queryParameters['scroll'];
          final dialog = state.uri.queryParameters['dialog'];
          final hint = state.uri.queryParameters['hint'] == 'true';
          return SettingsScreen(
            initialScroll: scroll,
            initialDialog: dialog,
            showHintOnStart: hint,
          );
        },
      ),

      // 10 Premium
      GoRoute(
        path: AppRoutes.premium,
        builder: (context, state) {
          final String? plan = state.uri.queryParameters['plan'];
          return PremiumScreen(initialPlan: plan);
        },
      ),
    ],
  );
}

