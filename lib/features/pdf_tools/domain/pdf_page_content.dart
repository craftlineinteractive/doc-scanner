/// Structured content for a simulated PDF page.
class PdfPageContent {
  const PdfPageContent({
    required this.pageNumber,
    required this.title,
    required this.tag,
    required this.paragraphs,
    this.company = 'Doc Scanner Global',
    this.growthLabel,
    this.growthValue,
    this.metrics = const <String, String>{},
    this.hasChart = false,
  });

  final int pageNumber;
  final String company;
  final String title;
  final String tag;
  final List<String> paragraphs;
  final String? growthLabel;
  final String? growthValue;
  final Map<String, String> metrics;
  final bool hasChart;

  /// Full concatenated text for lexical searching.
  String get fullText => '$title ${paragraphs.join(' ')}';
}
