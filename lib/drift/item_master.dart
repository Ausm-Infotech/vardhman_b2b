import 'package:drift/drift.dart';

class ItemMaster extends Table {
  @override
  Set<Column> get primaryKey => {itemNumber};

  TextColumn get itemNumber => text()();
  TextColumn get article => text()();
  TextColumn get articleDescription => text()();
  TextColumn get uom => text()();
  TextColumn get uomDescription => text()();
  TextColumn get shade => text()();
  BoolColumn get isInShadeCard => boolean()();
  DateTimeColumn get lastUpdatedDateTime => dateTime()();
}
