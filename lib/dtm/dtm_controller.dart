import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class DtmController extends GetxController {
  final OrdersController _ordersController = Get.find<OrdersController>();

  final rxSelectedOrderHeaderLine = Rxn<OrderHeaderLine>();

  final _rxOrderDetailLines = <OrderDetailLine>[].obs;

  Future<void> selectOrder(OrderHeaderLine orderHeaderLine) async {
    rxSelectedOrderHeaderLine.value = orderHeaderLine;

    refreshSelectedOrderDetails();
  }

  Future<void> refreshSelectedOrderDetails() async {
    _rxOrderDetailLines.clear();

    if (rxSelectedOrderHeaderLine.value != null) {
      final orderDetailLines = await Api.fetchOrderDetails(
        orderNumber: rxSelectedOrderHeaderLine.value!.orderNumber,
        orderType: rxSelectedOrderHeaderLine.value!.orderType,
        orderCompany: rxSelectedOrderHeaderLine.value!.orderCompany,
      );

      _rxOrderDetailLines.addAll(orderDetailLines);
    }
  }

  List<OrderHeaderLine> get filteredDtmOrders =>
      _ordersController.filteredOrderHeaderLines
          .where(
            (orderHeaderLine) =>
                orderHeaderLine.orderType == 'SW' && orderHeaderLine.isDTM,
          )
          .toList();

  List<OrderDetailLine> get primaryOrderDetailLines =>
      _rxOrderDetailLines.where(
        (orderDetailLine) {
          final itemParts = orderDetailLine.item.split(RegExp('\\s+'));

          return itemParts.length == 3 && itemParts[2] == ('SWT');
        },
      ).toList();

  OrderDetailLine? getPermanentShadeLine(int workOrderNumber) {
    return _rxOrderDetailLines.firstWhereOrNull(
      (detailLine) =>
          detailLine.catalogName.endsWith(workOrderNumber.toString()),
    );
  }
}
