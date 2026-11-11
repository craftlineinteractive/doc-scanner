import 'package:flutter/widgets.dart';

/// Immutable model representing a category or custom folder.
class ScanFolder {
  const ScanFolder({
    required this.id,
    required this.name,
    required this.itemCount,
    required this.lastModified,
    required this.categoryColorKey,
    required this.icon,
  });

  final String id;
  final String name;
  final int itemCount;
  final DateTime lastModified;
  final String categoryColorKey; // 'indigo', 'orange', 'emerald', 'rose'
  final IconData icon;

  /// Returns localized summary string such as "4 items · 12 Oct".
  String get summaryText {
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
    final String day = lastModified.day.toString().padLeft(2, '0');
    final String month = months[lastModified.month - 1];
    final String countUnit = itemCount == 1 ? 'item' : 'items';
    return '$itemCount $countUnit · $day $month';
  }
}
