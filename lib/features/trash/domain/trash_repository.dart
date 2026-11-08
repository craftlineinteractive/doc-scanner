import 'trash_item.dart';

/// Abstract contract for fetching trash items.
abstract class TrashRepository {
  List<TrashItem> getTrashItems();
}

