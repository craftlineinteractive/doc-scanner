import '../../../core/widgets/mock/mock_document_page.dart';
import '../domain/trash_item.dart';

/// Prepopulated trash items matching Frame 1 of `08_trash`.
final List<TrashItem> mockTrashItems = <TrashItem>[
  // 1 Folder
  const TrashItem(
    id: 'folder_old_client_files',
    title: 'Old Client Files',
    isFolder: true,
    itemCount: 4,
    typeBadge: 'FOLDER',
    deletedLabel: 'Deleted 2 hours ago',
    shortDeletedLabel: 'Deleted 2h ago',
    daysLeft: 29,
  ),

  // 6 Documents
  const TrashItem(
    id: 'doc_1',
    title: 'Doc Scanner 10 Oct 2026 7-49 pm',
    isFolder: false,
    pageCount: 3,
    typeBadge: 'A4 PDF',
    deletedLabel: 'Deleted 35 minutes ago',
    shortDeletedLabel: 'Deleted 35m ago',
    daysLeft: 28,
    variant: MockDocumentVariant.invoice,
  ),
  const TrashItem(
    id: 'doc_2',
    title: 'kunjbhai',
    isFolder: false,
    pageCount: 1,
    typeBadge: 'ID JPG',
    deletedLabel: 'Deleted 4 hours ago',
    shortDeletedLabel: 'Deleted 4h ago',
    daysLeft: 29,
    variant: MockDocumentVariant.idCard,
  ),
  const TrashItem(
    id: 'doc_3',
    title: 'pravinaben',
    isFolder: false,
    pageCount: 2,
    typeBadge: 'DOC PDF',
    deletedLabel: 'Deleted Yesterday',
    shortDeletedLabel: 'Deleted Yesterday',
    daysLeft: 27,
    originalFolderMissing: true,
    variant: MockDocumentVariant.contract,
  ),
  const TrashItem(
    id: 'doc_4',
    title: 'CDP',
    isFolder: false,
    pageCount: 5,
    typeBadge: 'A4 PDF',
    deletedLabel: 'Deleted Yesterday',
    shortDeletedLabel: 'Deleted Yesterday',
    daysLeft: 26,
    variant: MockDocumentVariant.invoice,
  ),
  const TrashItem(
    id: 'doc_5',
    title: 'Tax_Filing_FY25_Receipt',
    isFolder: false,
    pageCount: 4,
    typeBadge: 'TAX PDF',
    deletedLabel: 'Deleted Yesterday',
    shortDeletedLabel: 'Deleted Yesterday',
    daysLeft: 25,
    variant: MockDocumentVariant.receipt,
  ),
  const TrashItem(
    id: 'doc_6',
    title: 'Scan_Receipt_Oct',
    isFolder: false,
    pageCount: 1,
    typeBadge: 'REC JPG',
    deletedLabel: 'Deleted Yesterday',
    shortDeletedLabel: 'Deleted Yesterday',
    daysLeft: 2, // Critical chip (red state)
    variant: MockDocumentVariant.receipt,
  ),
];
