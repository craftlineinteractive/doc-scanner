import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/models/scan_document.dart';
import '../../../../core/models/scan_folder.dart';
import '../../../../core/theme/app_radii.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/doc_colors.dart';
import '../../../../core/widgets/buttons/dual_pill_fab.dart';
import '../../../../core/widgets/cards/info_banner.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/feedback/empty_state.dart';
import '../../../../core/widgets/inputs/app_search_field.dart';
import '../../../../core/widgets/navigation/app_top_bar.dart';
import '../../../drawer/presentation/widgets/app_drawer.dart';
import '../../application/home_providers.dart';
import '../../domain/home_repository.dart';
import '../widgets/home_documents_section.dart';
import '../widgets/home_folders_section.dart';

/// Primary landing screen of Doc Scanner featuring folder categories,
/// document list/grid collection, edge OCR status, and floating dual action pill.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    this.initialShowOverflowMenu = false,
    this.initialShowImportExpanded = false,
    this.initialShowAddSheet = false,
  });

  final bool initialShowOverflowMenu;
  final bool initialShowImportExpanded;
  final bool initialShowAddSheet;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (widget.initialShowAddSheet) {
        _openAddDocumentSheet();
      } else if (widget.initialShowOverflowMenu) {
        _openOverflowMenu(initialImportExpanded: widget.initialShowImportExpanded);
      }
    });
  }

  void _openAddDocumentSheet() {
    // Will be wired to AddDocumentSheet in Step 5
    showAppSnackbar(context: context, message: 'Add Document sheet');
  }

  void _openOverflowMenu({bool initialImportExpanded = false}) {
    // Will be wired to HomeOverflowMenu in Step 4
    showAppSnackbar(context: context, message: 'Overflow menu');
  }

  @override
  Widget build(BuildContext context) {
    final HomeRepository repo = ref.watch(homeRepositoryProvider);
    final HomeViewMode viewMode = ref.watch(homeViewModeProvider);
    final DocColors docColors = context.docColors;
    final List<ScanFolder> folders = repo.folders();
    final List<ScanDocument> documents = repo.documents();
    final bool isEmpty = folders.isEmpty && documents.isEmpty;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      appBar: AppTopBar(
        title: AppStrings.appName,
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
        onAvatarTap: () => _scaffoldKey.currentState?.openDrawer(),
        onProTap: () => context.push(AppRoutes.premium),
        onSearchTap: () => showAppSnackbar(
          context: context,
          message: 'Search screen is coming later',
        ),
        onMoreTap: () => _openOverflowMenu(),
      ),
      body: Stack(
        children: <Widget>[
          // Main scrollable content
          Positioned.fill(
            child: isEmpty
                ? EmptyState(
                    title: AppStrings.scanFirstDoc,
                    description:
                        'Digitize receipts, ID cards, notes, or import existing files effortlessly.',
                    onCameraHintTap: () => context.push(AppRoutes.camera),
                    onPlusHintTap: _openAddDocumentSheet,
                  )
                : ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.screenMargin,
                      AppSpacing.md,
                      AppSpacing.screenMargin,
                      AppSpacing.bottomListPadding,
                    ),
                    children: <Widget>[
                      // Search and filter bar
                      AppSearchField(
                        hintText: AppStrings.searchHint,
                        onFilterTap: () => showAppSnackbar(
                          context: context,
                          message: 'Search filter is coming later',
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),

                      // Edge OCR Info Banner
                      InfoBanner(
                        title: AppStrings.edgeOcrActive,
                        subtitle: AppStrings.edgeOcrSubtitle,
                        icon: const Icon(
                          Symbols.auto_read_play_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        trailingChip: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: docColors.successTint,
                            borderRadius: AppRadii.roundedPill,
                          ),
                          child: Text(
                            AppStrings.onDeviceBadge,
                            style: AppTypography.labelSm.copyWith(
                              color: docColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      // Folders Section
                      HomeFoldersSection(folders: folders),
                      const SizedBox(height: AppSpacing.lg),

                      // Documents Section
                      HomeDocumentsSection(
                        documents: documents,
                        viewMode: viewMode,
                      ),
                    ],
                  ),
          ),

          // Floating Dual Pill FAB at bottom right
          Positioned(
            bottom: AppSpacing.screenMargin + 8,
            right: AppSpacing.screenMargin,
            child: DualPillFab(
              onCameraTap: () => context.push(AppRoutes.camera),
              onPlusTap: _openAddDocumentSheet,
            ),
          ),
        ],
      ),
    );
  }
}
