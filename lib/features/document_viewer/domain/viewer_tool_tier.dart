/// Tool tier hierarchy for document viewer screen.
enum ViewerToolTier {
  /// Tier 1: Main bottom toolbar (Edit, Open PDF, Share, Save/Retake, etc.)
  main,

  /// Tier 2: Sub-toolbar opened by tapping Edit (Crop, Color, Rotate, Erase, Sign, Watermark, Text, Close)
  edit,

  /// Tier 3: Nested sub-toolbar opened by tapping Crop (Free, Auto Detect, Flip, Cancel, Apply)
  crop,

  /// PDF sub-toolbar opened by tapping Open PDF (Compress, Watermark, Fit Type, Page Size, Orientation)
  pdf,
}

