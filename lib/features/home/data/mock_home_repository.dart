import 'package:material_symbols_icons/symbols.dart';
import '../../../core/models/scan_document.dart';
import '../../../core/models/scan_folder.dart';
import '../../../core/widgets/mock/mock_document_page.dart';
import '../domain/home_repository.dart';

/// Full mock repository providing realistic folder and document data matching mockups.
class MockHomeRepository implements HomeRepository {
  const MockHomeRepository();

  @override
  List<ScanFolder> folders() {
    return <ScanFolder>[
      ScanFolder(
        id: 'folder_client_files',
        name: 'Client Files',
        itemCount: 4,
        lastModified: DateTime(2026, 10, 12),
        categoryColorKey: 'indigo',
        icon: Symbols.folder_rounded,
      ),
      ScanFolder(
        id: 'folder_property_docs',
        name: 'Property Docs',
        itemCount: 8,
        lastModified: DateTime(2026, 10, 4),
        categoryColorKey: 'orange',
        icon: Symbols.folder_special_rounded,
      ),
      ScanFolder(
        id: 'folder_personal_ids',
        name: 'Personal IDs',
        itemCount: 3,
        lastModified: DateTime(2026, 9, 28),
        categoryColorKey: 'emerald',
        icon: Symbols.badge_rounded,
      ),
    ];
  }

  @override
  List<ScanDocument> documents() {
    return <ScanDocument>[
      ScanDocument(
        id: 'doc_1',
        title: 'sunilkumar_prajapati',
        modifiedAt: DateTime(2026, 11, 2), // 2 days ago
        pageCount: 26,
        sizeMb: 4.2,
        isSynced: true,
        thumbnailVariant: MockDocumentVariant.invoice,
      ),
      ScanDocument(
        id: 'doc_2',
        title: 'Doc Scanner 17 Sept 2026 12-02',
        modifiedAt: DateTime(2026, 10, 14), // 3 weeks ago
        pageCount: 1,
        sizeMb: 0.8,
        isSynced: true,
        thumbnailVariant: MockDocumentVariant.contract,
      ),
      ScanDocument(
        id: 'doc_3',
        title: 'kunjbhai',
        modifiedAt: DateTime(2026, 7, 30),
        pageCount: 39,
        sizeMb: 8.5,
        isSynced: true,
        thumbnailVariant: MockDocumentVariant.invoice,
      ),
      ScanDocument(
        id: 'doc_4',
        title: 'pravinaben',
        modifiedAt: DateTime(2026, 7, 30),
        pageCount: 16,
        sizeMb: 3.4,
        isSynced: true,
        thumbnailVariant: MockDocumentVariant.contract,
      ),
      ScanDocument(
        id: 'doc_5',
        title: 'Tax_Filing_FY25_Receipt',
        modifiedAt: DateTime(2026, 7, 15),
        pageCount: 4,
        sizeMb: 1.1,
        isSynced: true,
        thumbnailVariant: MockDocumentVariant.receipt,
      ),
      ScanDocument(
        id: 'doc_6',
        title: 'Rent_Agreement_2026',
        modifiedAt: DateTime(2026, 6, 10),
        pageCount: 12,
        sizeMb: 2.9,
        isLocked: true,
        thumbnailVariant: MockDocumentVariant.contract,
      ),
      ScanDocument(
        id: 'doc_7',
        title: 'Passport_Copy',
        modifiedAt: DateTime(2026, 5, 20),
        pageCount: 1,
        sizeMb: 0.5,
        isFavorite: true,
        thumbnailVariant: MockDocumentVariant.idCard,
      ),
    ];
  }
}

