import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/labdip_feedback.dart';
import 'package:vardhman_b2b/api/labdip_table_row.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class LabdipController extends GetxController {
  final OrdersController ordersController = Get.find<OrdersController>();

  final rxEarliestOrderDate = oldestDateTime.obs;

  final rxOrderFromDate = oldestDateTime.obs;

  final rxOrderToDate = DateTime.now().obs;

  final rxOrderNumberInput = ''.obs;

  final rxMerchandiserInput = ''.obs;

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

  final rxOrderDetailFeedbackMap = <OrderDetailLine, LabdipFeedback>{}.obs;

  final rxLabdipFeedbacks = <LabdipFeedback>[].obs;

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

    ordersController.rxOrderHeaderLines.listenAndPump(
      (orderHeaderLines) {
        rxEarliestOrderDate.value =
            labdipOrders.lastOrNull?.orderDate ?? oldestDateTime;

        rxOrderFromDate.value =
            labdipOrders.lastOrNull?.orderDate ?? oldestDateTime;

        refreshLabdipFeedbacks();
      },
    );
  }

  Future<void> refreshOrders() async {
    await ordersController.refreshOrders();
  }

  Future<void> selectOrder(OrderHeaderLine orderHeaderLine) async {
    rxSelectedOrderHeaderLine.value = orderHeaderLine;

    await refreshSelectedOrderDetails();

    _refreshLabdipTableRows();
  }

  Future<void> _refreshLabdipTableRows() async {
    rxLabdipTableRows.clear();

    final labdipTableRows = await Api.fetchLabdipTableRows(
      workOrderNumbers: rxOrderDetailLines
          .map((orderDetailLine) => orderDetailLine.workOrderNumber)
          .toList(),
    );

    rxLabdipTableRows.addAll(labdipTableRows);
  }

  Future<void> refreshSelectedOrderDetails() async {
    rxOrderDetailLines.clear();

    rxOrderDetailFeedbackMap.clear();

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

  Future<void> refreshLabdipFeedbacks() async {
    final labdipFeedbacks = await Api.fetchLabdipFeedback(
      labdipOrders
          .map((orderHeaderLine) => orderHeaderLine.orderNumber)
          .toList(),
    );

    rxLabdipFeedbacks.clear();

    rxLabdipFeedbacks.addAll(labdipFeedbacks);
  }

  Future<void> submitFeedback() async {
    final UserController userController =
        Get.find<UserController>(tag: 'userController');

    var orderReferenceNumber = rxSelectedOrderHeaderLine.value!.orderReference;

    final nextOrderNumber =
        await Api.fetchLabdipRejectionCount(orderReferenceNumber);

    var b2bRejectionOrderNumber =
        '$orderReferenceNumber-R${nextOrderNumber.length + 1}';

    rxOrderDetailFeedbackMap.forEach(
      (orderDetailLine, labdipFeedback) async {
        await Api.submitLabdipFeedback(
          orderDetailLine: orderDetailLine,
          labdipFeedback: labdipFeedback,
        );
      },
    );

    rxOrderDetailFeedbackMap.removeWhere(
      (orderDetailLine, labdipFeedback) => !labdipFeedback.shouldRematch,
    );

    if (nextOrderNumber != null && rxOrderDetailFeedbackMap.isNotEmpty) {
      final orderDetailLinesReasonMap = rxOrderDetailFeedbackMap.map(
        (orderDetailLine, labdipFeedback) => MapEntry(
          orderDetailLine,
          labdipFeedback.reason,
        ),
      );

      final isSubmitted = await Api.submitRematchOrder(
        merchandiserName: rxSelectedOrderHeaderLine.value!.merchandiser,
        b2bOrderNumber: b2bRejectionOrderNumber,
        branchPlant: userController.branchPlant,
        soldTo: userController.rxCustomerDetail.value.soldToNumber,
        // shipTo:
        //     (userController.rxDeliveryAddress.value?.deliveryAddressNumber == 0
        //             ? userController.rxCustomerDetail.value.soldToNumber
        //             : userController
        //                 .rxDeliveryAddress.value?.deliveryAddressNumber)
        //         .toString(),
        shipTo: userController.rxCustomerDetail.value.soldToNumber,
        company: userController.rxCustomerDetail.value.companyCode,
        orderTakenBy: userController.rxUserDetail.value.role,
        orderDetailLinesReasonMap: orderDetailLinesReasonMap,
      );

      if (isSubmitted) {
        rxOrderDetailFeedbackMap.clear();

        toastification.show(
          autoCloseDuration: Duration(seconds: 3),
          primaryColor: VardhmanColors.green,
          title: Text(
            'Rematch order $b2bRejectionOrderNumber placed successfully!',
          ),
        );

        if (userController.rxCustomerDetail.value.canSendSMS) {
          Api.sendOrderEntrySMS(
            orderNumber: b2bRejectionOrderNumber,
            mobileNumber: userController.rxCustomerDetail.value.mobileNumber,
          );
        }

        if (userController.rxCustomerDetail.value.canSendWhatsApp) {
          Api.sendOrderEntryWhatsApp(
            orderNumber: b2bRejectionOrderNumber,
            mobileNumber: userController.rxCustomerDetail.value.mobileNumber,
          );
        }
      } else {
        toastification.show(
          autoCloseDuration: Duration(seconds: 3),
          primaryColor: VardhmanColors.red,
          title: Text(
            'Some error placing the order!',
          ),
        );
      }
    }

    await refreshLabdipFeedbacks();

    Get.back();
  }

  List<LabdipTableRow> getLabdipTableRows(int workOrderNumber) {
    return rxLabdipTableRows
        .where(
          (labdipTableRow) => labdipTableRow.workOrderNumber == workOrderNumber,
        )
        .toList();
  }

  List<OrderHeaderLine> get labdipOrders => ordersController.rxOrderHeaderLines
      .where((orderHeaderLine) => orderHeaderLine.orderType == 'LD')
      .toList();

  List<OrderHeaderLine> get filteredLabdipOrders => labdipOrders
      .where(
        (orderHeaderLine) =>
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
            orderHeaderLine.merchandiser.contains(rxMerchandiserInput.value),
      )
      .toList();

  bool get hasDefaultValues =>
      areDatesEqual(
        rxOrderFromDate.value,
        rxEarliestOrderDate.value,
      ) &&
      areDatesEqual(rxOrderToDate.value, DateTime.now()) &&
      rxOrderNumberInput.value.isEmpty &&
      rxMerchandiserInput.value.isEmpty;

  Future<void> setDefaultValues() async {
    rxOrderFromDate.value = rxEarliestOrderDate.value;

    rxOrderToDate.value = DateTime.now();

    rxOrderNumberInput.value = '';

    rxMerchandiserInput.value = '';
  }
}
