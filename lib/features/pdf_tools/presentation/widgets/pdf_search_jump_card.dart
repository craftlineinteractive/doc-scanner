import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/pdf_search_match.dart';

/// Floating snippet action card with Jump button matching Frame 3.
class PdfSearchJumpCard extends StatelessWidget {
  const PdfSearchJumpCard({
    super.key,
    required this.match,
    required this.totalMatches,
    required this.onJump,
  });

  final PdfSearchMatch match;
  final int totalMatches;
  final VoidCallback onJump;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.textPrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Match ${match.matchIndex + 1} of $totalMatches (Page ${match.pageIndex + 1})',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFC3C0FF),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  match.snippet,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: onJump,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              visualDensity: VisualDensity.compact,
            ),
            child: const Text(
              'Jump',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
