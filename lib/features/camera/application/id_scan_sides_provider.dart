import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'id_scan_sides.dart';

/// State notifier managing active ID scan sides selection (single vs both).
class IdScanSidesNotifier extends Notifier<IdScanSides> {
  @override
  IdScanSides build() => IdScanSides.single;

  void setSides(IdScanSides sides) {
    state = sides;
  }
}

/// Provider exposing current [IdScanSides].
final NotifierProvider<IdScanSidesNotifier, IdScanSides> idScanSidesProvider =
    NotifierProvider<IdScanSidesNotifier, IdScanSides>(
  IdScanSidesNotifier.new,
);

