import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class OrdersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _userController = Get.find<UserController>(tag: 'userController');

  final rxOrderHeaderLines = <OrderHeaderLine>[].obs;

  final rxSelectedOrder = Rxn<OrderHeaderLine>();

  final rxSelectedOrderDetails = <OrderDetailLine>[].obs;

  late final tabController = TabController(length: 4, vsync: this);

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

    rxOrderHeaderLines.clear();

    if (orderHeaderLines.isNotEmpty) {
      orderHeaderLines.sort(
        (a, b) {
          int compareToResult = b.orderDate.compareTo(a.orderDate);

          if (compareToResult != 0) {
            return compareToResult;
          }

          return b.orderNumber.compareTo(a.orderNumber);
        },
      );

      rxOrderHeaderLines.addAll(orderHeaderLines);
    }
  }

  // List<OrderHeaderLine> get inProgressOrders => filteredOrderHeaderLines
  //     .where(
  //       (orderStatusData) =>
  //           orderStatusData.orderStatus == 'In Progress' ||
  //           orderStatusData.orderStatus == 'Partially Dispatched',
  //     )
  //     .toList();

  // List<OrderHeaderLine> get holdOrders => filteredOrderHeaderLines
  //     .where(
  //       (orderStatusData) => orderStatusData.orderStatus == 'Hold',
  //     )
  //     .toList();

  // List<OrderHeaderLine> get cancelledOrders => filteredOrderHeaderLines
  //     .where(
  //       (orderStatusData) => orderStatusData.orderStatus == 'Cancelled',
  //     )
  //     .toList();

  // List<OrderHeaderLine> get dispatchedOrders => filteredOrderHeaderLines
  //     .where(
  //       (orderStatusData) =>
  //           orderStatusData.orderStatus == 'Dispatched' ||
  //           orderStatusData.orderStatus == 'Partially Dispatched',
  //     )
  //     .toList();
}
