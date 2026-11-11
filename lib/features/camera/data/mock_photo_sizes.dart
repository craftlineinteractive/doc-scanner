import '../domain/photo_size.dart';

/// Predefined list of mock photo size presets for ID Photo Editor.
abstract class MockPhotoSizes {
  static const PhotoSize defaultSelected = PhotoSize(
    id: '2x2_in',
    label: '2 x 2 INCHES',
    detail: 'DPI 600',
  );

  static const List<PhotoSize> defaultSizes = <PhotoSize>[
    defaultSelected,
    PhotoSize(id: '35x45_mm', label: '35 x 45 MM', detail: 'DPI 300'),
    PhotoSize(id: '2x2.5_cm', label: '2 x 2.5 CM', detail: 'DPI 450'),
    PhotoSize(id: '600x600_px', label: '600 x 600 PX', detail: 'PIXEL'),
    PhotoSize(id: '51x51_mm', label: '51 x 51 MM', detail: 'DPI 300'),
    PhotoSize(id: '25x35_mm', label: '25 x 35 MM', detail: 'DPI 450'),
  ];
}
