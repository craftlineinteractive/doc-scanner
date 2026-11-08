import '../domain/trash_item.dart';
import '../domain/trash_repository.dart';
import 'mock_trash.dart';

/// In-memory repository delivering mock trash items.
class MockTrashRepository implements TrashRepository {
  const MockTrashRepository({this.items});

  final List<TrashItem>? items;

  @override
  List<TrashItem> getTrashItems() {
    return items ?? List<TrashItem>.from(mockTrashItems);
  }
}

