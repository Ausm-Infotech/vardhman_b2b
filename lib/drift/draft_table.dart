import 'package:drift/drift.dart';

class DraftTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get soldTo => text()();
  TextColumn get orderType => text()();
  IntColumn get orderNumber => integer()();
  TextColumn get merchandiser => text()();
  IntColumn get lineNumber => integer()();
  TextColumn get shade => text()();
  TextColumn get buyer => text()();
  TextColumn get buyerCode => text()();
  TextColumn get firstLightSource => text()();
  TextColumn get secondLightSource => text()();
  TextColumn get substrate => text()();
  TextColumn get tex => text()();
  TextColumn get ticket => text()();
  TextColumn get brand => text()();
  TextColumn get article => text()();
  TextColumn get requestType => text()();
  TextColumn get colorName => text()();
  TextColumn get lab => text()();
  TextColumn get remark => text()();
  TextColumn get billingType => text()();
  TextColumn get uom => text()();
  TextColumn get endUse => text()();
  IntColumn get quantity => integer()();
  TextColumn get colorRemark => text()();
  DateTimeColumn get lastUpdated => dateTime()();
  BlobColumn get qtxFileBytes => blob().nullable()();
  TextColumn get qtxFileName => text()();
  DateTimeColumn get requestedDate => dateTime().nullable()();
  TextColumn get poNumber => text()();
  TextColumn get poFileName => text()();
  BlobColumn get poFileBytes => blob().nullable()();
  RealColumn get unitPrice => real().nullable()();
}
