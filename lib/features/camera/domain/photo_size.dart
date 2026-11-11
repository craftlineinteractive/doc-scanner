/// Immutable model representing a photo size preset for the ID Photo Editor.
class PhotoSize {
  const PhotoSize({
    required this.id,
    required this.label,
    required this.detail,
    this.isCustom = false,
  });

  /// Unique identifier.
  final String id;

  /// Display label e.g. "2 x 2 INCHES".
  final String label;

  /// Resolution / detail text e.g. "DPI 600" or "PIXEL".
  final String detail;

  /// Whether this size was added as a custom preset.
  final bool isCustom;

  PhotoSize copyWith({
    String? id,
    String? label,
    String? detail,
    bool? isCustom,
  }) {
    return PhotoSize(
      id: id ?? this.id,
      label: label ?? this.label,
      detail: detail ?? this.detail,
      isCustom: isCustom ?? this.isCustom,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoSize && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
