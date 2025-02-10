import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class BulkController extends GetxController {
  final OrdersController _ordersController = Get.find<OrdersController>();

  final rxSelectedOrderHeaderLine = Rxn<OrderHeaderLine>();

  final rxOrderDetailLines = <OrderDetailLine>[].obs;

  Future<void> selectOrder(OrderHeaderLine orderHeaderLine) async {
    rxSelectedOrderHeaderLine.value = orderHeaderLine;

    refreshSelectedOrderDetails();
  }

  Future<void> refreshSelectedOrderDetails() async {
    rxOrderDetailLines.clear();

    if (rxSelectedOrderHeaderLine.value != null) {
      final orderDetailLines = await Api.fetchOrderDetails(
        orderNumber: rxSelectedOrderHeaderLine.value!.orderNumber,
        orderType: rxSelectedOrderHeaderLine.value!.orderType,
        orderCompany: rxSelectedOrderHeaderLine.value!.orderCompany,
      );

      rxOrderDetailLines.addAll(orderDetailLines);
    }
  }

  List<OrderHeaderLine> get filteredBulkOrders =>
      _ordersController.filteredOrderHeaderLines
          .where(
            (orderHeaderLine) =>
                orderHeaderLine.orderType == 'SW' && !orderHeaderLine.isDTM,
          )
          .toList();

  OrderDetailLine? getPermanentShadeLine(int workOrderNumber) {
    return rxOrderDetailLines.firstWhereOrNull(
      (detailLine) =>
          detailLine.catalogName.endsWith(workOrderNumber.toString()),
    );
  }

  List<OrderDetailLine> getInvoicedLines(String itemNumber) {
    return rxOrderDetailLines
        .where(
          (detailLine) =>
              detailLine.item == itemNumber && detailLine.invoiceNumber > 0,
        )
        .toList();
  }
}
