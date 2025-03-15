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

  Future<void> submitFeedback() async {
    final UserController userController =
        Get.find<UserController>(tag: 'userController');

    final nextOrderNumber = await Api.fetchOrderNumber();

    final b2bOrderNumber = 'B2BR$nextOrderNumber';

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
        merchandiserName: '',
        b2bOrderNumber: b2bOrderNumber,
        branchPlant: userController.branchPlant,
        soldTo: userController.rxCustomerDetail.value.soldToNumber,
        shipTo:
            (userController.rxDeliveryAddress.value?.deliveryAddressNumber == 0
                    ? userController.rxCustomerDetail.value.soldToNumber
                    : userController
                        .rxDeliveryAddress.value?.deliveryAddressNumber)
                .toString(),
        company: userController.rxCustomerDetail.value.companyCode,
        orderTakenBy: userController.rxUserDetail.value.role,
        orderDetailLinesReasonMap: orderDetailLinesReasonMap,
      );

      if (isSubmitted) {
        rxOrderDetailFeedbackMap.clear();

        toastification.show(
          autoCloseDuration: Duration(seconds: 5),
          primaryColor: VardhmanColors.green,
          title: Text(
            'Rematch order $b2bOrderNumber placed successfully!',
          ),
        );

        if (userController.rxCustomerDetail.value.canSendSMS) {
          Api.sendOrderEntrySMS(
            orderNumber: b2bOrderNumber,
            mobileNumber: userController.rxCustomerDetail.value.mobileNumber,
          );
        }

        if (userController.rxCustomerDetail.value.canSendWhatsApp) {
          Api.sendOrderEntryWhatsApp(
            orderNumber: b2bOrderNumber,
            mobileNumber: userController.rxCustomerDetail.value.mobileNumber,
          );
        }
      } else {
        toastification.show(
          autoCloseDuration: Duration(seconds: 5),
          primaryColor: VardhmanColors.red,
          title: Text(
            'Some error placing the order!',
          ),
        );
      }
    }

    await ordersController.refreshLabdipFeedbacks();

    Get.back();
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
