/// Domain model representing recognized OCR text extraction.
class OcrResult {
  const OcrResult({
    this.title = 'Scanned Document',
    this.accuracyLabel = '99.4% OCR',
    this.pageCount = 1,
    this.language = 'English',
    this.documentTag = 'IMG_08',
    required this.text,
  });

  final String title;
  final String accuracyLabel;
  final int pageCount;
  final String language;
  final String documentTag;
  final String text;

  String get summarySubtitle =>
      '$pageCount page • $language • Tap to preview original';
}

