import 'package:flutter/material.dart';

/// Elevation shadow definitions from DESIGN.md.
class AppShadows {
  AppShadows._();

  /// Level 1 (Card / Resting Tile): Extra-diffused cool-tinted shadow
  /// box-shadow: 0 4px 16px -2px rgba(15, 23, 42, 0.04), 0 2px 6px -1px rgba(15, 23, 42, 0.02)
  static const List<BoxShadow> level1 = <BoxShadow>[
    BoxShadow(
      color: Color.fromRGBO(15, 23, 42, 0.04),
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: -2,
    ),
    BoxShadow(
      color: Color.fromRGBO(15, 23, 42, 0.02),
      offset: Offset(0, 2),
      blurRadius: 6,
      spreadRadius: -1,
    ),
  ];

  /// Level 2 (Active / Swiped / Dropdown / Lifted)
  /// box-shadow: 0 10px 24px -4px rgba(15, 23, 42, 0.08), 0 4px 8px -2px rgba(15, 23, 42, 0.03)
  static const List<BoxShadow> level2 = <BoxShadow>[
    BoxShadow(
      color: Color.fromRGBO(15, 23, 42, 0.08),
      offset: Offset(0, 10),
      blurRadius: 24,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color.fromRGBO(15, 23, 42, 0.03),
      offset: Offset(0, 4),
      blurRadius: 8,
      spreadRadius: -2,
    ),
  ];

  /// Level 3 (Floating Dual Pill CTA): Elevated indigo ambient glow
  /// box-shadow: 0 12px 28px -4px rgba(79, 70, 229, 0.35), 0 4px 10px -2px rgba(79, 70, 229, 0.20)
  static const List<BoxShadow> level3 = <BoxShadow>[
    BoxShadow(
      color: Color.fromRGBO(79, 70, 229, 0.35),
      offset: Offset(0, 12),
      blurRadius: 28,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color.fromRGBO(79, 70, 229, 0.20),
      offset: Offset(0, 4),
      blurRadius: 10,
      spreadRadius: -2,
    ),
  ];
}

