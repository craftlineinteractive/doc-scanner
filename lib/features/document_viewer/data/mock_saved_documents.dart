import '../../../core/widgets/mock/mock_document_page.dart';
import '../../scan_review/domain/crop_quad.dart';
import '../../scan_review/domain/scan_filter.dart';
import '../domain/saved_document.dart';
import '../domain/viewer_page.dart';

/// Predefined realistic mock documents matching all Document Viewer suite specifications.
class MockSavedDocuments {
  MockSavedDocuments._();

  /// 3-page document matching 01_post_scan_viewer_suite_5_frames.
  static final SavedDocument postScanDoc = SavedDocument(
    id: 'doc_post_scan',
    title: 'Doc Scanner 10 Oct 2026 12-02',
    sizeMb: 1.4,
    scannedLabel: 'Scanned today',
    isFavorite: false,
    isSynced: false,
    pages: <ViewerPage>[
      const ViewerPage(
        id: 'p1',
        variant: MockDocumentVariant.invoice,
        filter: ScanFilter.vividLight,
        filterLabel: 'Auto Enhanced',
        crop: CropQuad.standard(),
      ),
      const ViewerPage(
        id: 'p2',
        variant: MockDocumentVariant.contract,
        filter: ScanFilter.vividLight,
        filterLabel: 'Vivid Light',
        crop: CropQuad.standard(),
      ),
      const ViewerPage(
        id: 'p3',
        variant: MockDocumentVariant.receipt,
        filter: ScanFilter.vividLight,
        filterLabel: 'Original',
        crop: CropQuad.standard(),
      ),
    ],
  );

  /// 5-page document matching 02_saved_document_viewer_suite_5_frames.
  static final SavedDocument savedViewerDoc = SavedDocument(
    id: 'doc_saved_5',
    title: 'Doc Scanner 10 Oct 2026 7-52 pm',
    sizeMb: 2.1,
    scannedLabel: '7:52 PM',
    isFavorite: true,
    isSynced: true,
    pages: <ViewerPage>[
      const ViewerPage(
        id: 'p1',
        variant: MockDocumentVariant.invoice,
        filter: ScanFilter.vividLight,
        filterLabel: 'Auto Enhanced',
        crop: CropQuad.standard(),
      ),
      const ViewerPage(
        id: 'p2',
        variant: MockDocumentVariant.contract,
        filter: ScanFilter.vividLight,
        filterLabel: 'Vivid Light',
        crop: CropQuad.standard(),
      ),
      const ViewerPage(
        id: 'p3',
        variant: MockDocumentVariant.receipt,
        filter: ScanFilter.vividLight,
        filterLabel: 'Vivid Light',
        crop: CropQuad.standard(),
      ),
      const ViewerPage(
        id: 'p4',
        variant: MockDocumentVariant.idCard,
        filter: ScanFilter.vividLight,
        filterLabel: 'Original',
        crop: CropQuad.standard(),
      ),
      const ViewerPage(
        id: 'p5',
        variant: MockDocumentVariant.invoice,
        filter: ScanFilter.vividLight,
        filterLabel: 'Auto Enhanced',
        crop: CropQuad.standard(),
      ),
    ],
  );

  /// 4-page document matching 03_multi_page_manager_suite_3_frames.
  static final SavedDocument multiPageDoc = SavedDocument(
    id: 'doc_multi_4',
    title: 'Doc Scanner 10 Oct 2026 12-02',
    sizeMb: 1.8,
    scannedLabel: '12:02 PM',
    isFavorite: false,
    isSynced: true,
    pages: <ViewerPage>[
      const ViewerPage(
        id: 'p1',
        variant: MockDocumentVariant.invoice,
        filter: ScanFilter.autoEnhance,
        filterLabel: 'Auto Enhanced',
        crop: CropQuad.standard(),
      ),
      const ViewerPage(
        id: 'p2',
        variant: MockDocumentVariant.contract,
        filter: ScanFilter.vividLight,
        filterLabel: 'Vivid Light',
        crop: CropQuad.standard(),
      ),
      const ViewerPage(
        id: 'p3',
        variant: MockDocumentVariant.receipt,
        filter: ScanFilter.vividLight,
        filterLabel: 'Vivid Light',
        crop: CropQuad.standard(),
      ),
      const ViewerPage(
        id: 'p4',
        variant: MockDocumentVariant.contract,
        filter: ScanFilter.original,
        filterLabel: 'Original',
        crop: CropQuad.standard(),
      ),
    ],
  );

  /// Factory helper to resolve a document by ID or return a sensible default.
  static SavedDocument getDocumentById(String? id) {
    if (id == null) return multiPageDoc;
    switch (id) {
      case 'doc_post_scan':
        return postScanDoc;
      case 'doc_saved_5':
      case 'doc_2':
        return savedViewerDoc;
      case 'doc_multi_4':
      case 'doc_1':
      case 'doc_3':
      case 'doc_4':
      case 'doc_5':
      case 'doc_6':
      case 'doc_7':
      default:
        return multiPageDoc;
    }
  }
}

