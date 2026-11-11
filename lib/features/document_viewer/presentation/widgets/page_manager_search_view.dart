import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../app/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/buttons/labelled_dual_pill_fab.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';

/// In-document search and OCR highlight view matching Frame 3.
class PageManagerSearchView extends StatefulWidget {
  const PageManagerSearchView({
    super.key,
    this.initialQuery = 'Invoice',
    required this.onClose,
    required this.onJumpToPage,
    required this.onOpenPdf,
  });

  final String initialQuery;
  final VoidCallback onClose;
  final ValueChanged<int> onJumpToPage;
  final VoidCallback onOpenPdf;

  @override
  State<PageManagerSearchView> createState() => _PageManagerSearchViewState();
}

class _PageManagerSearchViewState extends State<PageManagerSearchView> {
  late final TextEditingController _controller;
  int _selectedFilter = 0; // 0 = All, 1 = Pg 1, 2 = Pg 3

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Top search bar
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.canvas,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(
                            Symbols.arrow_back_rounded,
                            size: 20,
                          ),
                          onPressed: widget.onClose,
                        ),
                        const Icon(
                          Symbols.search_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              hintText: 'Search in document...',
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Symbols.close_rounded, size: 16),
                          onPressed: () {
                            _controller.clear();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Filter row
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        const Text(
                          '2 occurrences in 2 pages',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        _SearchChip(
                          label: 'All (2)',
                          isSelected: _selectedFilter == 0,
                          onTap: () => setState(() => _selectedFilter = 0),
                        ),
                        const SizedBox(width: 6),
                        _SearchChip(
                          label: 'Pg 1 (1)',
                          isSelected: _selectedFilter == 1,
                          onTap: () => setState(() => _selectedFilter = 1),
                        ),
                        const SizedBox(width: 6),
                        _SearchChip(
                          label: 'Pg 3 (1)',
                          isSelected: _selectedFilter == 2,
                          onTap: () => setState(() => _selectedFilter = 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Search Results Feed with Readiness Banner
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
                children: <Widget>[
                  // Instant PDF Readiness Banner
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primaryTint,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Symbols.check_circle_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'PDF Ready (1.8 MB)',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                'Standard ISO-32000 PDF/A-1b',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: widget.onOpenPdf,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Open PDF',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        const SizedBox(width: 4),
                        IconButton(
                          icon: const Icon(
                            Symbols.share_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                          onPressed: () => showAppSnackbar(
                            context: context,
                            message: 'Sharing ISO-32000 PDF...',
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (_selectedFilter == 0 ||
                      _selectedFilter == 1) ...<Widget>[
                    _SearchResultCard(
                      pageLabel: 'Page 1 Match',
                      matchBadge: '100% OCR Match',
                      pageNumber: 1,
                      thumbnailBadgeText: 'INVOICE #4092',
                      thumbnailBottomText: '\$1,450.00',
                      snippetPrefix: '“OFFICIAL ',
                      highlightTerm: 'INVOICE',
                      snippetSuffix: ' SUMMARY #4092”',
                      subtext: 'Detected in top metadata header:',
                      onJump: () => widget.onJumpToPage(0),
                    ),
                    const SizedBox(height: 12),
                  ],
                  if (_selectedFilter == 0 ||
                      _selectedFilter == 2) ...<Widget>[
                    _SearchResultCard(
                      pageLabel: 'Page 3 Match',
                      matchBadge: 'Table Line 4',
                      pageNumber: 3,
                      thumbnailBadgeText: 'REF: INVOICE-2026',
                      thumbnailBottomText: null,
                      snippetPrefix: '“CROSS-REF: ',
                      highlightTerm: 'INVOICE',
                      snippetSuffix: ' #INV-2026-B”',
                      subtext: 'Cross-referenced item string:',
                      onJump: () => widget.onJumpToPage(2),
                    ),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: LabelledDualPillFab(
        onScanPageTap: () => context.push(AppRoutes.camera),
        onImportTap: () => showAppSnackbar(
          context: context,
          message: 'Select image or document to import',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _SearchChip extends StatelessWidget {
  const _SearchChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.canvas,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  const _SearchResultCard({
    required this.pageLabel,
    required this.matchBadge,
    required this.pageNumber,
    required this.thumbnailBadgeText,
    required this.thumbnailBottomText,
    required this.snippetPrefix,
    required this.highlightTerm,
    required this.snippetSuffix,
    required this.subtext,
    required this.onJump,
  });

  final String pageLabel;
  final String matchBadge;
  final int pageNumber;
  final String thumbnailBadgeText;
  final String? thumbnailBottomText;
  final String snippetPrefix;
  final String highlightTerm;
  final String snippetSuffix;
  final String subtext;
  final VoidCallback onJump;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
        boxShadow: const <BoxShadow>[
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Miniature Mock Document Preview
          _ThumbnailPreview(
            pageNumber: pageNumber,
            highlightText: thumbnailBadgeText,
            bottomText: thumbnailBottomText,
          ),
          const SizedBox(width: 14),

          // Match details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        pageLabel,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successTint,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        matchBadge,
                        style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtext,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 6),

                // Highlight snippet pill
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.canvas,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11,
                        color: AppColors.textPrimary,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: snippetPrefix),
                        TextSpan(
                          text: highlightTerm,
                          style: const TextStyle(
                            backgroundColor: Color(0xFF6FFBBE),
                            color: Color(0xFF002113),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextSpan(text: snippetSuffix),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Action row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: InkWell(
                        onTap: onJump,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Jump to line',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Symbols.arrow_forward_rounded,
                              size: 14,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Symbols.crop_free_rounded,
                        size: 18,
                        color: AppColors.textMuted,
                      ),
                      onPressed: onJump,
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ThumbnailPreview extends StatelessWidget {
  const _ThumbnailPreview({
    required this.pageNumber,
    required this.highlightText,
    this.bottomText,
  });

  final int pageNumber;
  final String highlightText;
  final String? bottomText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 84,
      height: 116,
      decoration: BoxDecoration(
        color: AppColors.surfaceSubdued,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.hairline),
      ),
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(15, 23, 42, 0.04),
                  offset: Offset(0, 1),
                  blurRadius: 3,
                ),
              ],
            ),
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6FFBBE),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Text(
                        highlightText,
                        style: const TextStyle(
                          fontSize: 6.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF002113),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.hairline,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Container(
                      height: 3,
                      width: 36,
                      decoration: BoxDecoration(
                        color: AppColors.hairline,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
                if (bottomText != null)
                  Text(
                    bottomText!,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            top: 2,
            left: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
              decoration: BoxDecoration(
                color: AppColors.textPrimary.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'Pg $pageNumber',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
