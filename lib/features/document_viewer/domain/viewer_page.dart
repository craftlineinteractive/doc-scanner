import '../../../core/widgets/mock/mock_document_page.dart';
import '../../scan_review/domain/crop_quad.dart';
import '../../scan_review/domain/crop_shape.dart';
import '../../scan_review/domain/scan_filter.dart';

/// Immutable model representing an individual page in a saved or active viewer session.
class ViewerPage {
  const ViewerPage({
    required this.id,
    required this.variant,
    this.filter = ScanFilter.vividLight,
    this.filterLabel = 'Auto Enhanced',
    this.rotationQuarterTurns = 0,
    this.hasOcr = true,
    this.crop = const CropQuad.standard(),
    this.shape = CropShape.free,
    this.isFlipped = false,
    this.extractedText = _defaultExtractedText,
  });

  final String id;
  final MockDocumentVariant variant;
  final ScanFilter filter;
  final String filterLabel;
  final int rotationQuarterTurns;
  final bool hasOcr;
  final CropQuad crop;
  final CropShape shape;
  final bool isFlipped;
  final String extractedText;

  static const String _defaultExtractedText =
      'GLOBAL LOGISTICS LLC\n'
      'INVOICE #INV-2026-091\n'
      'Date: 10 Oct 2026\n'
      'Due Date: 24 Oct 2026\n\n'
      'Description: Retainer Fee\n'
      'Service Retainer: \$120.00\n'
      'Express Processing: \$45.00\n'
      'TOTAL DUE: \$165.00\n\n'
      'Payment Status: PAID DIGITAL RECEIPT\n'
      'Doc ID: DL-8849-B • CONFIDENTIAL';

  ViewerPage copyWith({
    String? id,
    MockDocumentVariant? variant,
    ScanFilter? filter,
    String? filterLabel,
    int? rotationQuarterTurns,
    bool? hasOcr,
    CropQuad? crop,
    CropShape? shape,
    bool? isFlipped,
    String? extractedText,
  }) {
    return ViewerPage(
      id: id ?? this.id,
      variant: variant ?? this.variant,
      filter: filter ?? this.filter,
      filterLabel: filterLabel ?? this.filterLabel,
      rotationQuarterTurns: rotationQuarterTurns ?? this.rotationQuarterTurns,
      hasOcr: hasOcr ?? this.hasOcr,
      crop: crop ?? this.crop,
      shape: shape ?? this.shape,
      isFlipped: isFlipped ?? this.isFlipped,
      extractedText: extractedText ?? this.extractedText,
    );
  }
}

