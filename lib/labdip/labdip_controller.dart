import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/labdip_table_row.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class LabdipController extends GetxController {
  final OrdersController ordersController = Get.find<OrdersController>();

  final rxLabdipTableRows = <LabdipTableRow>[].obs;

  LabdipController() {
    init();
  }

  Future<void> init() async {
    ordersController.rxSelectedOrder.listen(
      (orderHeaderLine) async {
        if (orderHeaderLine != null && orderHeaderLine.isLabdip) {
          final labdipTableRows =
              await Api.fetchLabdipTableRows(orderHeaderLine.orderNumber);

          rxLabdipTableRows.clear();

          rxLabdipTableRows.addAll(labdipTableRows);
        }
      },
    );
  }

  LabdipTableRow? getLabdipTableRow(int workOrderNumber) {
    return rxLabdipTableRows.firstWhereOrNull(
      (labdipTableRow) => labdipTableRow.workOrderNumber == workOrderNumber,
    );
  }
}
