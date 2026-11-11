import 'pdf_page_content.dart';

/// Pure representation of a search match in a PDF document.
class PdfSearchMatch {
  const PdfSearchMatch({
    required this.matchIndex,
    required this.pageIndex,
    required this.term,
    required this.startOffset,
    required this.endOffset,
    required this.snippet,
  });

  final int matchIndex;
  final int pageIndex;
  final String term;
  final int startOffset;
  final int endOffset;
  final String snippet;
}

/// Pure Dart search function that indexes document pages and returns matches.
List<PdfSearchMatch> findPdfSearchMatches(
  List<PdfPageContent> pages,
  String query,
) {
  final String trimmed = query.trim();
  if (trimmed.isEmpty) return const <PdfSearchMatch>[];

  final String lowerQuery = trimmed.toLowerCase();
  final List<PdfSearchMatch> results = <PdfSearchMatch>[];

  for (int p = 0; p < pages.length; p++) {
    final String pageText = pages[p].fullText;
    final String lowerPageText = pageText.toLowerCase();

    int startIndex = 0;
    while (startIndex < lowerPageText.length) {
      final int foundIndex = lowerPageText.indexOf(lowerQuery, startIndex);
      if (foundIndex == -1) break;

      final int endIndex = foundIndex + lowerQuery.length;

      // Extract a representative snippet with ellipsis
      final int snippetStart = (foundIndex - 18).clamp(0, pageText.length);
      final int snippetEnd = (endIndex + 18).clamp(0, pageText.length);

      final String rawSnippet = pageText.substring(snippetStart, snippetEnd);
      final String snippetWithEllipsis = '“...$rawSnippet...”';

      results.add(
        PdfSearchMatch(
          matchIndex: results.length,
          pageIndex: p,
          term: pageText.substring(foundIndex, endIndex),
          startOffset: foundIndex,
          endOffset: endIndex,
          snippet: snippetWithEllipsis,
        ),
      );

      startIndex = endIndex;
    }
  }

  return results;
}
