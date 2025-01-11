import 'package:drift/drift.dart';

class DeliveryDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get soldToNumber => text().unique()();
  TextColumn get name => text()();
  TextColumn get address => text()();
  TextColumn get city => text()();
  TextColumn get state => text()();
  TextColumn get pincode => text()();
  TextColumn get country => text()();
}
