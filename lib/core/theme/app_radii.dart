import 'package:flutter/material.dart';

/// Corner radius values conforming to DESIGN.md and mockup specifications.
class AppRadii {
  AppRadii._();

  static const double sm = 4.0;
  static const double md = 8.0;
  static const double input = 12.0;
  static const double card = 16.0;
  static const double cardLarge = 20.0;
  static const double sheet = 28.0;
  static const double pill = 9999.0;

  // BorderRadius instances
  static const BorderRadius roundedSm = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius roundedMd = BorderRadius.all(Radius.circular(md));
  static const BorderRadius roundedInput = BorderRadius.all(
    Radius.circular(input),
  );
  static const BorderRadius roundedCard = BorderRadius.all(
    Radius.circular(card),
  );
  static const BorderRadius roundedCardLarge = BorderRadius.all(
    Radius.circular(cardLarge),
  );
  static const BorderRadius roundedPill = BorderRadius.all(
    Radius.circular(pill),
  );

  // Bottom sheet top-only radius
  static const BorderRadius sheetRadius = BorderRadius.vertical(
    top: Radius.circular(sheet),
  );

  // Drawer right-only radius
  static const BorderRadius drawerRadius = BorderRadius.horizontal(
    right: Radius.circular(24.0),
  );

  // Header bottom-only radius
  static const BorderRadius headerBottomRadius = BorderRadius.vertical(
    bottom: Radius.circular(cardLarge),
  );
}
