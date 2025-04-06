import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/constants.dart';
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

  final rxEarliestOrderDate = oldestDateTime.obs;

  final rxOrderFromDate = oldestDateTime.obs;

  final rxOrderToDate = DateTime.now().obs;

  final rxOrderNumberInput = ''.obs;

  final rxPoNumberInput = ''.obs;

  final rxMerchandiserInput = ''.obs;

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

    ordersController.rxOrderHeaderLines.listen(
      (orderHeaderLines) {
        rxEarliestOrderDate.value =
            dtmOrders.lastOrNull?.orderDate ?? oldestDateTime;

        rxOrderFromDate.value =
            dtmOrders.lastOrNull?.orderDate ?? oldestDateTime;
      },
    );
  }

  Future<void> refreshOrders() async {
    await ordersController.refreshOrders();
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

      rxOrderDetailLines.clear();

      rxOrderDetailLines.addAll(orderDetailLines);
    }
  }

  List<OrderHeaderLine> get dtmOrders => ordersController.rxOrderHeaderLines
      .where(
        (orderHeaderLine) =>
            orderHeaderLine.orderType == 'SW' && orderHeaderLine.isDTM,
      )
      .toList();

  List<OrderHeaderLine> get filteredDtmOrders => dtmOrders
      .where((orderHeaderLine) =>
          (orderHeaderLine.orderReference
                  .trim()
                  .contains(rxOrderNumberInput.value) ||
              orderHeaderLine.orderNumber
                  .toString()
                  .contains(rxOrderNumberInput.value)) &&
          orderHeaderLine.orderDate.isAfter(
            rxOrderFromDate.value.subtract(
              const Duration(days: 1),
            ),
          ) &&
          orderHeaderLine.orderDate.isBefore(
            rxOrderToDate.value.add(
              const Duration(days: 1),
            ),
          ) &&
          orderHeaderLine.merchandiser.contains(rxMerchandiserInput.value) &&
          orderHeaderLine.poNumber.contains(rxPoNumberInput.value))
      .toList();

  List<OrderDetailLine> get primaryOrderDetailLines => rxOrderDetailLines.where(
        (orderDetailLine) {
          final itemParts = orderDetailLine.item.split(RegExp('\\s+'));

          return itemParts.length == 3 && itemParts[2].startsWith('SWT');
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

  bool get hasDefaultValues =>
      areDatesEqual(
        rxOrderFromDate.value,
        rxEarliestOrderDate.value,
      ) &&
      areDatesEqual(rxOrderToDate.value, DateTime.now()) &&
      rxOrderNumberInput.value.isEmpty &&
      rxPoNumberInput.value.isEmpty &&
      rxMerchandiserInput.value.isEmpty;

  Future<void> setDefaultValues() async {
    rxOrderFromDate.value = rxEarliestOrderDate.value;

    rxOrderToDate.value = DateTime.now();

    rxOrderNumberInput.value = '';

    rxPoNumberInput.value = '';

    rxMerchandiserInput.value = '';
  }
}
