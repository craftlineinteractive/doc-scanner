import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/pdf_page_content.dart';
import '../../domain/pdf_search_match.dart';
import 'pdf_chart_painter.dart';

/// Renders a single simulated high-fidelity PDF page sheet.
class PdfPageCard extends StatelessWidget {
  const PdfPageCard({
    super.key,
    required this.content,
    this.searchQuery = '',
    this.currentMatch,
  });

  final PdfPageContent content;
  final String searchQuery;
  final PdfSearchMatch? currentMatch;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(15, 23, 42, 0.08),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Symbols.corporate_fare_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            content.company.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textMuted,
                              letterSpacing: 0.8,
                            ),
                          ),
                          _buildHighlightedText(
                            text: content.title,
                            baseStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
                decoration: BoxDecoration(
                  color: AppColors.successTint,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  content.tag,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Chart if present
          if (content.hasChart) ...<Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.canvas,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        content.growthLabel ?? 'Revenue Growth',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        content.growthValue ?? '+28.4%',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: PdfChartPainter(
                        lineColor: AppColors.primary,
                        fillColor: Color(0x144F46E5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
          ],

          // Metrics table if present
          if (content.metrics.isNotEmpty) ...<Widget>[
            ...content.metrics.entries.map(
              (MapEntry<String, String> entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Paragraphs with search highlights
          ...content.paragraphs.map(
            (String paragraph) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _buildHighlightedText(
                text: paragraph,
                baseStyle: const TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),

          // Simulated document lines
          const SizedBox(height: 8),
          Container(
            height: 4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.hairline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 4,
            width: 140,
            decoration: BoxDecoration(
              color: AppColors.hairline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedText({
    required String text,
    required TextStyle baseStyle,
  }) {
    final String query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return Text(text, style: baseStyle);
    }

    final String lowerText = text.toLowerCase();
    final List<TextSpan> spans = <TextSpan>[];
    int start = 0;

    while (start < text.length) {
      final int index = lowerText.indexOf(query, start);
      if (index == -1) {
        spans.add(TextSpan(text: text.substring(start), style: baseStyle));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(text: text.substring(start, index), style: baseStyle));
      }

      final int end = index + query.length;
      final String matchText = text.substring(index, end);

      final bool isCurrentMatch = currentMatch != null &&
          currentMatch!.pageIndex == (content.pageNumber - 1) &&
          currentMatch!.term.toLowerCase() == query;

      spans.add(
        TextSpan(
          text: matchText,
          style: baseStyle.copyWith(
            backgroundColor: isCurrentMatch
                ? const Color(0xFFFFB690)
                : const Color(0xFFD3E4FE),
            color: isCurrentMatch
                ? const Color(0xFF341100)
                : AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
      );

      start = end;
    }

    return Text.rich(TextSpan(children: spans));
  }
}

