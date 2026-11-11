import 'package:material_symbols_icons/symbols.dart';
import '../domain/pdf_tool.dart';

/// 14 core tools plus 2 additional options in the PDF Toolkit drawer.
class MockPdfTools {
  MockPdfTools._();

  static const List<PdfTool> documentTools = <PdfTool>[
    PdfTool(
      id: 'open_pdf',
      label: 'Open PDF',
      icon: Symbols.file_open_rounded,
      group: PdfToolGroup.pdfDocumentTools,
    ),
    PdfTool(
      id: 'merge_files',
      label: 'Merge Files',
      icon: Symbols.merge_type_rounded,
      group: PdfToolGroup.pdfDocumentTools,
    ),
    PdfTool(
      id: 'add_gallery',
      label: 'Add Gallery',
      icon: Symbols.add_photo_alternate_rounded,
      group: PdfToolGroup.pdfDocumentTools,
    ),
    PdfTool(
      id: 'split_pdf',
      label: 'Split PDF',
      icon: Symbols.content_cut_rounded,
      group: PdfToolGroup.pdfDocumentTools,
    ),
    PdfTool(
      id: 'page_size',
      label: 'Page Size',
      icon: Symbols.aspect_ratio_rounded,
      group: PdfToolGroup.pdfDocumentTools,
    ),
    PdfTool(
      id: 'rotate_del',
      label: 'Rotate/Del',
      icon: Symbols.rotate_right_rounded,
      group: PdfToolGroup.pdfDocumentTools,
    ),
    PdfTool(
      id: 'add_pass',
      label: 'Add Pass',
      icon: Symbols.lock_rounded,
      group: PdfToolGroup.pdfDocumentTools,
    ),
    PdfTool(
      id: 'unlock',
      label: 'Unlock',
      icon: Symbols.lock_open_rounded,
      group: PdfToolGroup.pdfDocumentTools,
    ),
    PdfTool(
      id: 'signature',
      label: 'Signature',
      icon: Symbols.draw_rounded,
      group: PdfToolGroup.pdfDocumentTools,
    ),
  ];

  static const List<PdfTool> toOtherFormat = <PdfTool>[
    PdfTool(
      id: 'to_image',
      label: 'To Image',
      subtitle: 'JPG, PNG',
      icon: Symbols.image_rounded,
      group: PdfToolGroup.pdfToOtherFormat,
    ),
    PdfTool(
      id: 'to_text',
      label: 'To Text',
      subtitle: 'OCR TXT',
      icon: Symbols.text_fields_rounded,
      group: PdfToolGroup.pdfToOtherFormat,
    ),
    PdfTool(
      id: 'to_zip',
      label: 'To ZIP',
      subtitle: 'Archive',
      icon: Symbols.folder_zip_rounded,
      group: PdfToolGroup.pdfToOtherFormat,
    ),
  ];

  static const List<PdfTool> formatToPdf = <PdfTool>[
    PdfTool(
      id: 'image_to_pdf',
      label: 'Image to PDF',
      subtitle: 'Convert photos to PDF',
      icon: Symbols.photo_library_rounded,
      group: PdfToolGroup.otherFormatToPdf,
    ),
    PdfTool(
      id: 'text_to_pdf',
      label: 'Text to PDF',
      subtitle: 'Convert documents',
      icon: Symbols.notes_rounded,
      group: PdfToolGroup.otherFormatToPdf,
    ),
  ];

  static const List<PdfTool> moreOptions = <PdfTool>[
    PdfTool(
      id: 'share_long_image',
      label: 'Share as Long Image',
      icon: Symbols.panorama_horizontal_rounded,
      group: PdfToolGroup.moreOptions,
    ),
    PdfTool(
      id: 'share_secure_link',
      label: 'Share via Secure Doc Scanner Link',
      icon: Symbols.cloud_sync_rounded,
      group: PdfToolGroup.moreOptions,
    ),
  ];

  /// All 14 actionable conversion and document tools.
  static List<PdfTool> get all14Tools => <PdfTool>[
    ...documentTools,
    ...toOtherFormat,
    ...formatToPdf,
  ];
}
