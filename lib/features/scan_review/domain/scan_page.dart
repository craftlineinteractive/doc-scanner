import '../../../core/widgets/mock/mock_document_page.dart';
import 'crop_quad.dart';
import 'crop_shape.dart';
import 'scan_filter.dart';

/// Immutable model representing an individual scanned page within a multi-page session.
class ScanPage {
  const ScanPage({
    required this.id,
    required this.variant,
    this.filter = ScanFilter.vividLight,
    this.rotationQuarterTurns = 0,
    required this.crop,
    this.shape = CropShape.free,
    this.isFlipped = false,
  });

  final String id;
  final MockDocumentVariant variant;
  final ScanFilter filter;
  final int rotationQuarterTurns;
  final CropQuad crop;
  final CropShape shape;
  final bool isFlipped;

  ScanPage copyWith({
    String? id,
    MockDocumentVariant? variant,
    ScanFilter? filter,
    int? rotationQuarterTurns,
    CropQuad? crop,
    CropShape? shape,
    bool? isFlipped,
  }) {
    return ScanPage(
      id: id ?? this.id,
      variant: variant ?? this.variant,
      filter: filter ?? this.filter,
      rotationQuarterTurns: rotationQuarterTurns ?? this.rotationQuarterTurns,
      crop: crop ?? this.crop,
      shape: shape ?? this.shape,
      isFlipped: isFlipped ?? this.isFlipped,
    );
  }
}

