import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/orders/item_master_controller.dart';
import 'package:vardhman_b2b/orders/order_entry_controller.dart';
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

    final orderInfos =
        await Api.fetchOrders(soldToNumber: customerSoldToNumber);

    _rxOrderHeaderLines.clear();

    if (orderInfos.isNotEmpty) {
      _rxOrderHeaderLines.addAll(orderInfos);

      _rxOrderHeaderLines.sort((a, b) => b.orderDate.compareTo(a.orderDate));

      rxEarliestOrderDate.value =
          _rxOrderHeaderLines.lastOrNull?.orderDate ?? oldestDateTime;

      rxOrderFromDate.value =
          _rxOrderHeaderLines.lastOrNull?.orderDate ?? oldestDateTime;
    } else {
      rxEarliestOrderDate.value = oldestDateTime;

      rxOrderFromDate.value = oldestDateTime;
    }
  }

  Future<void> selectOrder(OrderHeaderLine orderInfo) async {
    rxSelectedOrder.value = orderInfo;

    refreshSelectedOrderDetails();
  }

  Future<void> refreshSelectedOrderDetails() async {
    rxSelectedOrderDetails.clear();

    if (rxSelectedOrder.value != null) {
      final orderDetailLines = await Api.fetchOrderDetails(
        orderNumber: rxSelectedOrder.value!.orderNumber,
        orderType: rxSelectedOrder.value!.orderType,
        orderCompany: rxSelectedOrder.value!.orderCompany,
      );

      rxSelectedOrderDetails.addAll(orderDetailLines);
    }
  }

  List<OrderHeaderLine> get _filteredOrderInfos => _rxOrderHeaderLines
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

  List<OrderHeaderLine> get labdipOrders => _filteredOrderInfos
      .where(
        (orderStatusData) => orderStatusData.orderType == 'LD',
      )
      .toList();

  List<OrderHeaderLine> get inProgressOrders => _filteredOrderInfos
      .where(
        (orderStatusData) =>
            orderStatusData.orderStatus == 'In Progress' ||
            orderStatusData.orderStatus == 'Partially Dispatched',
      )
      .toList();

  List<OrderHeaderLine> get holdOrders => _filteredOrderInfos
      .where(
        (orderStatusData) => orderStatusData.orderStatus == 'Hold',
      )
      .toList();

  List<OrderHeaderLine> get cancelledOrders => _filteredOrderInfos
      .where(
        (orderStatusData) => orderStatusData.orderStatus == 'Cancelled',
      )
      .toList();

  List<OrderHeaderLine> get dispatchedOrders => _filteredOrderInfos
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
