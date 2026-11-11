import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'book_scan_type.dart';

/// State notifier managing active Book scan type selection.
class BookScanTypeNotifier extends Notifier<BookScanType> {
  @override
  BookScanType build() => BookScanType.twoPages;

  void setType(BookScanType type) {
    state = type;
  }
}

/// Provider exposing current [BookScanType].
final NotifierProvider<BookScanTypeNotifier, BookScanType>
bookScanTypeProvider = NotifierProvider<BookScanTypeNotifier, BookScanType>(
  BookScanTypeNotifier.new,
);
