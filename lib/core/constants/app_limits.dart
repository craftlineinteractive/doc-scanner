/// Application numerical limits and thresholds.
class AppLimits {
  AppLimits._();

  static const int trashRetentionDays = 30;
  static const int maxRecentDocuments = 100;
  static const int defaultRecentDocumentsHome = 50;

  static const double minTouchTargetSize = 48.0;
  static const double minViewportWidth = 360.0;
  static const double maxViewportWidth = 430.0;
  static const double maxTextScaleFactor = 1.3;
}

