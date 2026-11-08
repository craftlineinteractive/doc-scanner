import '../../../core/widgets/mock/mock_document_page.dart';

/// Represents a deleted document or folder in the trash container.
class TrashItem {
  const TrashItem({
    required this.id,
    required this.title,
    this.isFolder = false,
    this.itemCount,
    this.pageCount,
    this.typeBadge = 'A4 PDF',
    required this.deletedLabel,
    required this.shortDeletedLabel,
    required this.daysLeft,
    this.originalFolderMissing = false,
    this.variant = MockDocumentVariant.invoice,
  });

  final String id;
  final String title;
  final bool isFolder;
  final int? itemCount;
  final int? pageCount;
  final String typeBadge;
  final String deletedLabel;
  final String shortDeletedLabel;
  final int daysLeft;
  final bool originalFolderMissing;
  final MockDocumentVariant variant;

  TrashItem copyWith({
    String? id,
    String? title,
    bool? isFolder,
    int? itemCount,
    int? pageCount,
    String? typeBadge,
    String? deletedLabel,
    String? shortDeletedLabel,
    int? daysLeft,
    bool? originalFolderMissing,
    MockDocumentVariant? variant,
  }) {
    return TrashItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isFolder: isFolder ?? this.isFolder,
      itemCount: itemCount ?? this.itemCount,
      pageCount: pageCount ?? this.pageCount,
      typeBadge: typeBadge ?? this.typeBadge,
      deletedLabel: deletedLabel ?? this.deletedLabel,
      shortDeletedLabel: shortDeletedLabel ?? this.shortDeletedLabel,
      daysLeft: daysLeft ?? this.daysLeft,
      originalFolderMissing:
          originalFolderMissing ?? this.originalFolderMissing,
      variant: variant ?? this.variant,
    );
  }
}

