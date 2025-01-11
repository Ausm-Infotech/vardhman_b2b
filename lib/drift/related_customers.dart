import 'package:drift/drift.dart';

class RelatedCustomers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get managerSoldTo => text()();
  TextColumn get customerSoldTo => text()();
  TextColumn get customerName => text()();
}
