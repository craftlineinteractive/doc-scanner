import 'package:flutter/material.dart';

/// Spacing values based on 8px/4px layout grid rules.
class AppSpacing {
  AppSpacing._();

  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;

  /// Standard screen horizontal margin (16px)
  static const double screenMargin = 16.0;

  /// Standard vertical and horizontal gap between cards (12px)
  static const double cardGap = 12.0;

  /// Spacing between distinct sections on screen (24px)
  static const double sectionGap = 24.0;

  /// Generous bottom padding for scrollable lists so floating pill FAB never covers content
  static const double bottomListPadding = 100.0;

  // EdgeInsets presets
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenMargin,
  );
  static const EdgeInsets screenListPadding = EdgeInsets.fromLTRB(
    screenMargin,
    lg,
    screenMargin,
    bottomListPadding,
  );
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPaddingLg = EdgeInsets.all(lg);
}
