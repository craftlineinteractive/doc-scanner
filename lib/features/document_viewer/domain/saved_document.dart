import 'viewer_page.dart';

/// Immutable model representing a saved multi-page document.
class SavedDocument {
  const SavedDocument({
    required this.id,
    required this.title,
    required this.pages,
    this.sizeMb = 1.8,
    this.isFavorite = false,
    this.isSynced = false,
    this.folderName = 'General',
    this.scannedLabel = 'Scanned today',
    this.ocrDone = true,
    this.dpi = 300,
    this.storagePath = 'Device Internal / Scans',
  });

  final String id;
  final String title;
  final List<ViewerPage> pages;
  final double sizeMb;
  final bool isFavorite;
  final bool isSynced;
  final String folderName;
  final String scannedLabel;
  final bool ocrDone;
  final int dpi;
  final String storagePath;

  int get pageCount => pages.length;

  ViewerPage? getPage(int index) {
    if (index >= 0 && index < pages.length) {
      return pages[index];
    }
    return null;
  }

  SavedDocument copyWith({
    String? id,
    String? title,
    List<ViewerPage>? pages,
    double? sizeMb,
    bool? isFavorite,
    bool? isSynced,
    String? folderName,
    String? scannedLabel,
    bool? ocrDone,
    int? dpi,
    String? storagePath,
  }) {
    return SavedDocument(
      id: id ?? this.id,
      title: title ?? this.title,
      pages: pages ?? this.pages,
      sizeMb: sizeMb ?? this.sizeMb,
      isFavorite: isFavorite ?? this.isFavorite,
      isSynced: isSynced ?? this.isSynced,
      folderName: folderName ?? this.folderName,
      scannedLabel: scannedLabel ?? this.scannedLabel,
      ocrDone: ocrDone ?? this.ocrDone,
      dpi: dpi ?? this.dpi,
      storagePath: storagePath ?? this.storagePath,
    );
  }
}
