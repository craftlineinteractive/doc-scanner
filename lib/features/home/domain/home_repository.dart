import '../../../core/models/scan_document.dart';
import '../../../core/models/scan_folder.dart';

/// Contract for querying folder and document collections on the Home screen.
abstract class HomeRepository {
  List<ScanFolder> folders();
  List<ScanDocument> documents();
}

