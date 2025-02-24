import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class DtmController extends GetxController {
  final OrdersController ordersController = Get.find<OrdersController>();

  final rejectionReasons = [
    'Late Delivery',
    'Tonel Difference',
    'Brighter',
    'Lighter',
    'Darker',
    'Wrong Dispatch',
    'Metamerism',
    'Duller',
    'Order Cancel by Buyer',
  ];

  final rxDraftOrders = <DraftTableData>[].obs;

  final rxSelectedOrderHeaderLine = Rxn<OrderHeaderLine>();

  final rxOrderDetailLines = <OrderDetailLine>[].obs;

  final rxSelectedOrderDetailLinesReasonMap = <OrderDetailLine, String>{}.obs;

  final Database _database = Get.find<Database>();

  final UserController _userController =
      Get.find<UserController>(tag: 'userController');

  DtmController() {
    _database.managers.draftTable
        .filter(
          (f) => f.orderType.equals('DT'),
        )
        .filter(
          (f) =>
              f.soldTo.equals(_userController.rxUserDetail.value.soldToNumber),
        )
        .orderBy(
          (o) => o.lastUpdated.desc(),
        )
        .watch()
        .listen(
      (draftTableDatas) {
        rxDraftOrders.clear();

        // LOGIC to remove duplicate orders

        for (DraftTableData draftTableData in draftTableDatas) {
          if (!rxDraftOrders.any(
            (draftOrder) =>
                draftOrder.orderNumber == draftTableData.orderNumber,
          )) {
            rxDraftOrders.add(draftTableData);
          }
        }
      },
    );
  }

  void selectOrderDetailLine(OrderDetailLine orderDetailLine) {
    if (rxSelectedOrderDetailLinesReasonMap.containsKey(orderDetailLine)) {
      rxSelectedOrderDetailLinesReasonMap.remove(orderDetailLine);
    } else {
      rxSelectedOrderDetailLinesReasonMap[orderDetailLine] = '';
    }
  }

  Future<void> selectOrder(OrderHeaderLine orderHeaderLine) async {
    rxSelectedOrderHeaderLine.value = orderHeaderLine;

    refreshSelectedOrderDetails();
  }

  Future<void> refreshSelectedOrderDetails() async {
    rxOrderDetailLines.clear();

    rxSelectedOrderDetailLinesReasonMap.clear();

    if (rxSelectedOrderHeaderLine.value != null) {
      final orderDetailLines = await Api.fetchOrderDetails(
        orderNumber: rxSelectedOrderHeaderLine.value!.orderNumber,
        orderType: rxSelectedOrderHeaderLine.value!.orderType,
        orderCompany: rxSelectedOrderHeaderLine.value!.orderCompany,
      );

      rxOrderDetailLines.addAll(orderDetailLines);
    }
  }

  List<OrderHeaderLine> get filteredDtmOrders =>
      ordersController.filteredOrderHeaderLines
          .where(
            (orderHeaderLine) =>
                orderHeaderLine.orderType == 'SW' && orderHeaderLine.isDTM,
          )
          .toList();

  List<OrderDetailLine> get primaryOrderDetailLines => rxOrderDetailLines.where(
        (orderDetailLine) {
          final itemParts = orderDetailLine.item.split(RegExp('\\s+'));

          return itemParts.length == 3 && itemParts[2] == ('SWT');
        },
      ).toList();

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
