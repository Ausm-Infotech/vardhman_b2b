import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_info.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/orders/item_master_controller.dart';
import 'package:vardhman_b2b/orders/order_entry_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class OrdersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _userController = Get.find<UserController>(tag: 'userController');

  final _rxOrderInfos = <OrderInfo>[];

  final rxEarliestOrderDate = oldestDateTime.obs;

  final rxOrderFromDate = oldestDateTime.obs;

  final rxOrderToDate = DateTime.now().obs;

  final rxOrderNumberInput = ''.obs;

  final rxSelectedOrder = Rxn<OrderInfo>();

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

    final orderInfos = await Api.fetchOrders(
      soldToNumber: customerSoldToNumber,
    );

    _rxOrderInfos.clear();

    if (orderInfos.isNotEmpty) {
      _rxOrderInfos.addAll(orderInfos);

      _rxOrderInfos.sort(
        (a, b) => a.orderDate.compareTo(b.orderDate),
      );

      rxEarliestOrderDate.value = _rxOrderInfos.first.orderDate;

      rxOrderFromDate.value = _rxOrderInfos.first.orderDate;
    } else {
      rxEarliestOrderDate.value = oldestDateTime;

      rxOrderFromDate.value = oldestDateTime;
    }
  }

  Future<void> selectOrder(OrderInfo orderStatusData) async {
    rxSelectedOrder.value = orderStatusData;

    final orderDetailLines = await Api.fetchOrderDetails(
      orderNumber: orderStatusData.orderNumber,
      orderType: orderStatusData.orderType,
      orderCompany: orderStatusData.orderCompany,
    );

    if (orderDetailLines.isNotEmpty) {
      rxSelectedOrder.value = orderStatusData;

      rxSelectedOrderDetails.clear();

      rxSelectedOrderDetails.addAll(orderDetailLines);
    }

    // Get.to(() => OrderDetailsView());
  }

  List<OrderInfo> get _filteredOrderInfos => _rxOrderInfos
      .where(
        (orderInfo) =>
            (orderInfo.orderReference.trim().isNotEmpty
                ? orderInfo.orderReference.contains(rxOrderNumberInput.value)
                : orderInfo.orderNumber
                    .toString()
                    .contains(rxOrderNumberInput.value)) &&
            orderInfo.orderDate.isAfter(
              rxOrderFromDate.value.subtract(
                const Duration(days: 1),
              ),
            ) &&
            orderInfo.orderDate.isBefore(
              rxOrderToDate.value.add(
                const Duration(days: 1),
              ),
            ),
      )
      .toList();

  List<OrderInfo> get labdipOrders => _filteredOrderInfos
      .where(
        (orderStatusData) => orderStatusData.orderType == 'LD',
      )
      .toList();

  List<OrderInfo> get inProgressOrders => _filteredOrderInfos
      .where(
        (orderStatusData) =>
            orderStatusData.orderStatus == 'In Progress' ||
            orderStatusData.orderStatus == 'Partially Dispatched',
      )
      .toList();

  List<OrderInfo> get holdOrders => _filteredOrderInfos
      .where(
        (orderStatusData) => orderStatusData.orderStatus == 'Hold',
      )
      .toList();

  List<OrderInfo> get cancelledOrders => _filteredOrderInfos
      .where(
        (orderStatusData) => orderStatusData.orderStatus == 'Cancelled',
      )
      .toList();

  List<OrderInfo> get dispatchedOrders => _filteredOrderInfos
      .where(
        (orderStatusData) =>
            orderStatusData.orderStatus == 'Dispatched' ||
            orderStatusData.orderStatus == 'Partially Dispatched',
      )
      .toList();

  Map<String, Article> getArticleMapFromOrderLines(
      List<OrderDetailLine> orderDetailLines) {
    final articleMap = <String, Article>{};
    for (var orderDetailLine in orderDetailLines) {
      final item = orderDetailLine.item;

      List<String> itemParts = item.split(RegExp('\\s+'));

      log(itemParts.toString());

      if (itemParts.length == 3) {
        String article = itemParts[0].trim();

        String uom = itemParts[1].trim();

        String shade = itemParts[2].trim();

        int quantity = orderDetailLine.quantityOrdered;

        final itemMasterController = Get.find<ItemMasterController>();

        if (article.isNotEmpty && uom.isNotEmpty && shade.isNotEmpty) {
          final articleObject = articleMap[article];

          if (articleObject != null) {
            final uomObject = articleObject.uomMap[uom];

            if (uomObject != null) {
              final currentQuantity = uomObject.shadeQuantitiesMap[shade];

              uomObject.shadeQuantitiesMap[shade] = currentQuantity == null
                  ? quantity
                  : currentQuantity + quantity;
            } else {
              articleObject.uomMap[uom] = Uom(
                name: uom,
                description: itemMasterController.getUomDescription(uom),
                shadeQuantitiesMap: {shade: quantity}.obs,
              );
            }
          } else {
            articleMap[article] = Article(
              name: article,
              description: orderDetailLine.itemDescription,
              uomMap: {
                uom: Uom(
                  name: uom,
                  description: itemMasterController.getUomDescription(uom),
                  shadeQuantitiesMap: {shade: quantity}.obs,
                )
              }.obs,
            );
          }
        }
      }
    }

    return articleMap;
  }

  Map<String, Article> get selectedOrderArticlesMap =>
      getArticleMapFromOrderLines(rxSelectedOrderDetails);

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
