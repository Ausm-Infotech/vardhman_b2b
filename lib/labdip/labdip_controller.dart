import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/labdip_table_row.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class LabdipController extends GetxController {
  final OrdersController ordersController = Get.find<OrdersController>();

  final rxLabdipTableRows = <LabdipTableRow>[].obs;

  final rxSelectedOrderHeaderLine = Rxn<OrderHeaderLine>();

  final rxSelectedOrderDetailLines = <OrderDetailLine>[].obs;

  Future<void> selectOrder(OrderHeaderLine orderHeaderLine) async {
    rxSelectedOrderHeaderLine.value = orderHeaderLine;

    refreshSelectedOrderDetails();

    _refreshLabdipTableRows(orderHeaderLine.orderNumber);
  }

  Future<void> _refreshLabdipTableRows(int orderNumber) async {
    final labdipTableRows = await Api.fetchLabdipTableRows(orderNumber);

    rxLabdipTableRows.clear();

    rxLabdipTableRows.addAll(labdipTableRows);
  }

  Future<void> refreshSelectedOrderDetails() async {
    rxSelectedOrderDetailLines.clear();

    if (rxSelectedOrderHeaderLine.value != null) {
      final orderDetailLines = await Api.fetchOrderDetails(
        orderNumber: rxSelectedOrderHeaderLine.value!.orderNumber,
        orderType: rxSelectedOrderHeaderLine.value!.orderType,
        orderCompany: rxSelectedOrderHeaderLine.value!.orderCompany,
      );

      rxSelectedOrderDetailLines.addAll(orderDetailLines);
    }
  }

  LabdipTableRow? getLabdipTableRow(int workOrderNumber) {
    return rxLabdipTableRows.firstWhereOrNull(
      (labdipTableRow) => labdipTableRow.workOrderNumber == workOrderNumber,
    );
  }

  List<OrderHeaderLine> get filteredLabdipOrders =>
      ordersController.filteredOrderHeaderLines
          .where(
            (orderHeaderLine) => orderHeaderLine.orderType == 'LD',
          )
          .toList();
}
