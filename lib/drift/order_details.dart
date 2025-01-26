import 'package:drift/drift.dart';

class OrderDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get soldToNumber => text()();
  IntColumn get orderNumber => integer().unique()();
  TextColumn get orderType => text()();
  TextColumn get orderCompany => text()();
  DateTimeColumn get orderDate => dateTime()();
  TextColumn get orderReference => text()();
  TextColumn get holdCode => text()();
  IntColumn get shipTo => integer()();
  IntColumn get quantityOrdered => integer()();
  IntColumn get quantityShipped => integer()();
  IntColumn get quantityCancelled => integer()();
  TextColumn get orderStatus => text()();
  RealColumn get orderAmount => real()();
}
