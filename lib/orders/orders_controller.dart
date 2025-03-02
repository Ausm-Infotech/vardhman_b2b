import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/labdip_feedback.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class OrdersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _userController = Get.find<UserController>(tag: 'userController');

  final _rxOrderHeaderLines = <OrderHeaderLine>[];

  final rxEarliestOrderDate = oldestDateTime.obs;

  final rxOrderFromDate = oldestDateTime.obs;

  final rxOrderToDate = DateTime.now().obs;

  final rxOrderNumberInput = ''.obs;

  final rxSelectedOrder = Rxn<OrderHeaderLine>();

  final rxSelectedOrderDetails = <OrderDetailLine>[].obs;

  late final tabController = TabController(length: 4, vsync: this);

  final rxLabdipFeedbacks = <LabdipFeedback>[].obs;

  OrdersController() {
    init();
  }

  Future<void> init() async {
    _userController.rxCustomerDetail.listenAndPump(
      (_) {
        refreshOrders();
      },
    );
  }

  Future<void> refreshOrders() async {
    final customerSoldToNumber =
        _userController.rxCustomerDetail.value.soldToNumber;

    final orderHeaderLines =
        await Api.fetchOrders(soldToNumber: customerSoldToNumber);

    _rxOrderHeaderLines.clear();

    if (orderHeaderLines.isNotEmpty) {
      orderHeaderLines.sort((a, b) => b.orderDate.compareTo(a.orderDate));

      _rxOrderHeaderLines.addAll(orderHeaderLines);
    }

    rxEarliestOrderDate.value =
        orderHeaderLines.lastOrNull?.orderDate ?? oldestDateTime;

    rxOrderFromDate.value =
        orderHeaderLines.lastOrNull?.orderDate ?? oldestDateTime;

    refreshLabdipFeedbacks();
  }

  Future<void> refreshLabdipFeedbacks() async {
    final labdipFeedbacks = await Api.fetchLabdipFeedback(
      _rxOrderHeaderLines
          .where((orderHeaderLine) => orderHeaderLine.orderType == 'LD')
          .map((orderHeaderLine) => orderHeaderLine.orderNumber)
          .toList(),
    );

    rxLabdipFeedbacks.clear();

    rxLabdipFeedbacks.addAll(labdipFeedbacks);
  }

  List<OrderHeaderLine> get filteredOrderHeaderLines => _rxOrderHeaderLines
      .where(
        (orderHeaderLine) =>
            (orderHeaderLine.orderReference.trim().isNotEmpty
                ? orderHeaderLine.orderReference
                    .contains(rxOrderNumberInput.value)
                : orderHeaderLine.orderNumber
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
            ),
      )
      .toList();

  List<OrderHeaderLine> get inProgressOrders => filteredOrderHeaderLines
      .where(
        (orderStatusData) =>
            orderStatusData.orderStatus == 'In Progress' ||
            orderStatusData.orderStatus == 'Partially Dispatched',
      )
      .toList();

  List<OrderHeaderLine> get holdOrders => filteredOrderHeaderLines
      .where(
        (orderStatusData) => orderStatusData.orderStatus == 'Hold',
      )
      .toList();

  List<OrderHeaderLine> get cancelledOrders => filteredOrderHeaderLines
      .where(
        (orderStatusData) => orderStatusData.orderStatus == 'Cancelled',
      )
      .toList();

  List<OrderHeaderLine> get dispatchedOrders => filteredOrderHeaderLines
      .where(
        (orderStatusData) =>
            orderStatusData.orderStatus == 'Dispatched' ||
            orderStatusData.orderStatus == 'Partially Dispatched',
      )
      .toList();

  bool get hasDefaultValues =>
      areDatesEqual(
        rxOrderFromDate.value,
        rxEarliestOrderDate.value,
      ) &&
      areDatesEqual(rxOrderToDate.value, DateTime.now()) &&
      rxOrderNumberInput.value.isEmpty;

  Future<void> setDefaultValues() async {
    rxOrderFromDate.value = rxEarliestOrderDate.value;

    rxOrderToDate.value = DateTime.now();

    rxOrderNumberInput.value = '';
  }
}
