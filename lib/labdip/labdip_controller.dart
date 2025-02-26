import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/labdip_table_row.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class LabdipController extends GetxController {
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

  final rxLabdipTableRows = <LabdipTableRow>[].obs;

  final rxSelectedOrderHeaderLine = Rxn<OrderHeaderLine>();

  final rxOrderDetailLines = <OrderDetailLine>[].obs;

  final rxSelectedOrderDetailLinesReasonMap = <OrderDetailLine, String>{}.obs;

  final Database _database = Get.find<Database>();

  final UserController _userController =
      Get.find<UserController>(tag: 'userController');

  LabdipController() {
    _database.managers.draftTable
        .filter(
          (f) => f.orderType.equals('LD'),
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

    _refreshLabdipTableRows(orderHeaderLine.orderNumber);
  }

  Future<void> _refreshLabdipTableRows(int orderNumber) async {
    final labdipTableRows = await Api.fetchLabdipTableRows(orderNumber);

    rxLabdipTableRows.clear();

    rxLabdipTableRows.addAll(labdipTableRows);
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

      rxOrderDetailLines.clear();

      rxOrderDetailLines.addAll(orderDetailLines);
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
