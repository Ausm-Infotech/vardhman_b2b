import 'package:drift/drift.dart';

class CatalogItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get article => text()();
  TextColumn get brand => text()();
  TextColumn get length => text()();
  TextColumn get ticket => text()();
  TextColumn get tex => text()();
  TextColumn get variation => text()();
}
