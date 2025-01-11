import 'package:drift/drift.dart';

class InvoiceDetails extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get openAmount => real()();
  RealColumn get grossAmount => real()();
  RealColumn get discountAmount => real()();
  RealColumn get taxableAmount => real()();
  RealColumn get tax => real()();
  TextColumn get customerNumber => text()();
  TextColumn get company => text()();
  TextColumn get docType => text()();
  IntColumn get invoiceNumber => integer()();
  IntColumn get salesOrderNumber => integer()();
  TextColumn get salesOrderType => text()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get discountDueDate => dateTime()();
  BoolColumn get isOpen => boolean()();
}
