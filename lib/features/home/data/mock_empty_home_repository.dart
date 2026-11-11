import '../../../core/models/scan_document.dart';
import '../../../core/models/scan_folder.dart';
import '../domain/home_repository.dart';

/// Mock repository representing an empty initial run state with zero folders and documents.
class MockEmptyHomeRepository implements HomeRepository {
  const MockEmptyHomeRepository();

  @override
  List<ScanFolder> folders() => const <ScanFolder>[];

  @override
  List<ScanDocument> documents() => const <ScanDocument>[];
}
