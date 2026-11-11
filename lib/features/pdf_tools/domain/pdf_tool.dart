import 'package:flutter/widgets.dart';

/// Categories of tools in the PDF Toolkit hub.
enum PdfToolGroup {
  pdfDocumentTools,
  pdfToOtherFormat,
  otherFormatToPdf,
  moreOptions,
}

/// Representation of an actionable PDF tool in the toolkit drawer.
class PdfTool {
  const PdfTool({
    required this.id,
    required this.label,
    required this.icon,
    required this.group,
    this.subtitle,
  });

  final String id;
  final String label;
  final String? subtitle;
  final IconData icon;
  final PdfToolGroup group;
}
