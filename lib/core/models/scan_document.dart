import '../widgets/mock/mock_document_page.dart';

/// Immutable model representing a scanned document item.
class ScanDocument {
  const ScanDocument({
    required this.id,
    required this.title,
    required this.modifiedAt,
    required this.pageCount,
    this.sizeMb = 1.0,
    this.isLocked = false,
    this.isFavorite = false,
    this.isSynced = false,
    this.thumbnailVariant = MockDocumentVariant.invoice,
  });

  final String id;
  final String title;
  final DateTime modifiedAt;
  final int pageCount;
  final double sizeMb;
  final bool isLocked;
  final bool isFavorite;
  final bool isSynced;
  final MockDocumentVariant thumbnailVariant;

  /// Default baseline reference date matching fixed mockup timestamp (4 Nov 2026).
  static final DateTime mockToday = DateTime(2026, 11, 4);

  /// Computes human-friendly relative date text (e.g. "2 days ago", "3 weeks ago")
  /// or absolute date (e.g. "30 Jul 2026") when older than 30 days.
  String relativeDateText({DateTime? referenceDate}) {
    final DateTime now = referenceDate ?? mockToday;
    final Duration diff = now.difference(modifiedAt);

    if (diff.isNegative || diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else if (diff.inDays < 30) {
      final int weeks = (diff.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else {
      return formattedAbsoluteDate;
    }
  }

  /// Formatted absolute date representation (e.g. "30 Jul 2026").
  String get formattedAbsoluteDate {
    const List<String> months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final String day = modifiedAt.day.toString();
    final String month = months[modifiedAt.month - 1];
    final String year = modifiedAt.year.toString();
    return '$day $month $year';
  }
}

