import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/feedback/app_snackbar.dart';
import '../../../../core/widgets/mock/mock_document_page.dart';

/// In-document search and OCR highlight view matching Frame 3.
class PageManagerSearchView extends StatefulWidget {
  const PageManagerSearchView({
    super.key,
    required this.initialQuery,
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
    return Column(
      children: <Widget>[
        // Top search bar
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      icon: const Icon(Symbols.arrow_back_rounded, size: 20),
                      onPressed: widget.onClose,
                    ),
                    const Icon(Symbols.search_rounded, size: 18, color: AppColors.primary),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    '2 occurrences in 2 pages',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: <Widget>[
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
                ],
              ),
            ],
          ),
        ),

        // Instant PDF Readiness Banner
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Open PDF', style: TextStyle(fontSize: 11)),
              ),
              const SizedBox(width: 4),
              IconButton(
                icon: const Icon(Symbols.share_rounded, size: 18, color: AppColors.primary),
                onPressed: () => showAppSnackbar(
                  context: context,
                  message: 'Sharing ISO-32000 PDF...',
                ),
              ),
            ],
          ),
        ),

        // Search Results Feed
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            children: <Widget>[
              if (_selectedFilter == 0 || _selectedFilter == 1) ...<Widget>[
                _SearchResultCard(
                  pageLabel: 'Page 1 Match',
                  matchBadge: '100% OCR Match',
                  pageNumber: 1,
                  snippetPrefix: 'OFFICIAL ',
                  highlightTerm: 'INVOICE',
                  snippetSuffix: ' SUMMARY #4092',
                  subtext: 'Detected in top metadata header:',
                  variant: MockDocumentVariant.invoice,
                  onJump: () => widget.onJumpToPage(0),
                ),
                const SizedBox(height: 12),
              ],
              if (_selectedFilter == 0 || _selectedFilter == 2) ...<Widget>[
                _SearchResultCard(
                  pageLabel: 'Page 3 Match',
                  matchBadge: 'Table Line 4',
                  pageNumber: 3,
                  snippetPrefix: 'CROSS-REF: ',
                  highlightTerm: 'INVOICE',
                  snippetSuffix: ' #INV-2026-B',
                  subtext: 'Cross-referenced item string:',
                  variant: MockDocumentVariant.receipt,
                  onJump: () => widget.onJumpToPage(2),
                ),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ],
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
    required this.snippetPrefix,
    required this.highlightTerm,
    required this.snippetSuffix,
    required this.subtext,
    required this.variant,
    required this.onJump,
  });

  final String pageLabel;
  final String matchBadge;
  final int pageNumber;
  final String snippetPrefix;
  final String highlightTerm;
  final String snippetSuffix;
  final String subtext;
  final MockDocumentVariant variant;
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
          // Miniature Thumbnail
          SizedBox(
            width: 80,
            height: 110,
            child: Stack(
              children: <Widget>[
                MockDocumentPage(
                  variant: variant,
                  aspectRatio: 0.707,
                ),
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                    Text(
                      pageLabel,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                  child: RichText(
                    text: TextSpan(
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

                // Jump to line button
                InkWell(
                  onTap: onJump,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Jump to line',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
