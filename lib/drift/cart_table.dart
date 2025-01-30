import 'package:drift/drift.dart';

class CartTable extends Table {
  @override
  Set<Column<Object>> get primaryKey => {soldTo, article, uom, shade};

  Column<String> get soldTo => text()();
  Column<String> get article => text()();
  Column<String> get uom => text()();
  Column<String> get shade => text()();
  Column<int> get quantity => integer()();
}
