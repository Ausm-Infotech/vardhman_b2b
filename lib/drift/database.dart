import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:vardhman_b2b/drift/billing_details.dart';
import 'package:vardhman_b2b/drift/delivery_details.dart';
import 'package:vardhman_b2b/drift/order_status.dart';
import 'package:vardhman_b2b/drift/related_customers.dart';

import 'user_details.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    UserDetails,
    BillingDetails,
    DeliveryDetails,
  ],
)
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'vytl',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('/sqlite3.wasm'),
        driftWorker: Uri.parse('/drift_worker.js'),
      ),
    );
  }
}
