import '../domain/ocr_result.dart';

/// Pre-populated consulting agreement text matching Frame 11.
class MockOcrResult {
  MockOcrResult._();

  static const String agreementHeading =
      'MASTER CONSULTING AGREEMENT & STATEMENT OF WORK';

  static const String agreementBody =
      'This Consulting Agreement is entered into on this 14th day of October 2026, by and between Doc Scanner Technologies Inc. ("Client") and the Independent Consultant named below ("Provider").\n\n'
      '1. SCOPE OF SERVICES: Consultant agrees to provide document pipeline analysis, edge machine learning optical character recognition optimization, and localized cloud synchronization security protocols as set forth in Exhibit A.\n\n'
      '2. DELIVERABLES & TIMELINE: All final architecture reports and source artifacts shall be delivered in portable document format (.pdf) compliant with ISO 19005-1 (PDF/A) standards by the scheduled milestone review date.\n\n'
      '3. CONFIDENTIALITY: All processed data, including signature templates and scanned credentials, remain the exclusive property of the Client and are protected under non-disclosure terms.';

  static const String fullDefaultText = '$agreementHeading\n\n$agreementBody';

  static const OcrResult defaultResult = OcrResult(
    title: 'Scanned Document',
    accuracyLabel: '99.4% OCR',
    pageCount: 1,
    language: 'English',
    documentTag: 'IMG_08',
    text: fullDefaultText,
  );
}
