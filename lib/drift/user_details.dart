import 'package:drift/drift.dart';

class UserDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get mobileNumber => text().unique()();
  TextColumn get name => text()();
  TextColumn get soldToNumber => text().unique()();
  TextColumn get companyCode => text()();
  TextColumn get companyName => text()();
  TextColumn get role => text()();
  TextColumn get category => text()();
}
