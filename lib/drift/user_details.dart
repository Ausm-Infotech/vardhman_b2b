import 'package:drift/drift.dart';

class UserDetails extends Table {
  @override
  Set<Column> get primaryKey => {soldToNumber};

  TextColumn get soldToNumber => text().unique()();
  BoolColumn get isMobileUser => boolean()();
  TextColumn get mobileNumber => text()();
  BoolColumn get canSendSMS => boolean()();
  TextColumn get whatsAppNumber => text()();
  BoolColumn get canSendWhatsApp => boolean()();
  TextColumn get email => text()();
  TextColumn get name => text()();
  TextColumn get companyCode => text()();
  TextColumn get companyName => text()();
  TextColumn get role => text()();
  TextColumn get category => text()();
}
