import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/feedback/placeholder_screen.dart';
import '../dev/ui_gallery/components_page.dart';
import '../dev/ui_gallery/ui_gallery_screen.dart';
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
        builder: (context, state) => const PlaceholderScreen(
          title: 'Home Screen',
          subtitle: '01_home_screen source of truth',
        ),
      ),
      GoRoute(
        path: AppRoutes.homeEmpty,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Home Empty State',
          subtitle: '03_home_empty_state onboarding layout',
        ),
      ),

      // 03 Camera
      GoRoute(
        path: AppRoutes.camera,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Camera Screen',
          subtitle: '03_camera dark camera viewfinder',
        ),
      ),

      // 04 Scan Review
      GoRoute(
        path: AppRoutes.adjust,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Adjust / Crop Screen',
          subtitle: '01_adjust_crop_default with 4 corner handles',
        ),
      ),
      GoRoute(
        path: AppRoutes.reviewScan,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Review Scan Screen',
          subtitle: '05_review_scan_suite multi-page review',
        ),
      ),
      GoRoute(
        path: AppRoutes.arrangePages,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Arrange Pages Screen',
          subtitle: 'Reorder pages grid view',
        ),
      ),

      // 05 Document Viewer
      GoRoute(
        path: AppRoutes.postScanViewer,
        builder: (context, state) => const PlaceholderScreen(
          title: 'Post-Scan Viewer Screen',
          subtitle: '01_post_scan_viewer_suite with edit tools',
        ),
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

