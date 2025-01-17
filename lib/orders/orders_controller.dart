import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/orders/order_entry_controller.dart';
import 'package:vardhman_b2b/sample_data.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class OrdersController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final _userController = Get.find<UserController>(tag: 'userController');

  final _rxFilteredOrderStatuses = RxList<OrderStatusData>();

  final _orderStatuses = <OrderStatusData>[];

  final isRefreshing = false.obs;

  final rxFirstDate = oldestDateTime.obs;

  final rxFromDate = oldestDateTime.obs;

  final rxToDate = DateTime.now().obs;

  final rxOrderNumberInput = ''.obs;

  final orderNumberTextEditingController = TextEditingController();

  final rxSelectedLabdipOrder = Rxn<OrderStatusData>();

  final rxSelectedLabdipOrderDetails = <OrderDetailLine>[].obs;

  late final tabController = TabController(length: 4, vsync: this);

  OrdersController() {
    init();
  }

  Future<void> init() async {
    _userController.rxCustomerDetail.listenAndPump(
      (_) async {
        await refreshOrders();

        rxFirstDate.value = _orderStatuses.first.orderDate;

        rxFromDate.value = _orderStatuses.first.orderDate;
      },
    );

    rxOrderNumberInput.listenAndPump(
      (_) {
        filterOrders();
      },
    );
  }

  void filterOrders() {
    final filteredOrders = _orderStatuses.where(
      (orderStatusData) => orderStatusData.orderReference.trim().isNotEmpty
          ? orderStatusData.orderReference.contains(rxOrderNumberInput.value)
          : orderStatusData.orderNumber.toString().contains(
                rxOrderNumberInput.value,
              ),
    );

    _rxFilteredOrderStatuses.clear();

    _rxFilteredOrderStatuses.addAll(filteredOrders);
  }

  Future<void> refreshOrders() async {
    isRefreshing.value = true;

    final customerSoldToNumber =
        _userController.rxCustomerDetail.value.soldToNumber;

    Api.fetchOrders(
      soldToNumber: customerSoldToNumber,
      fromDate: rxFirstDate.value,
      toDate: DateTime.now(),
    ).then((orderStatusCompanions) {
      if (orderStatusCompanions.isNotEmpty) {
        _orderStatuses.clear();

        _orderStatuses.addAll(
          orderStatusCompanions.map(
            (e) => OrderStatusData(
              holdCode: e.holdCode.value,
              id: 0,
              orderAmount: e.orderAmount.value,
              orderCompany: e.orderCompany.value,
              orderDate: e.orderDate.value,
              orderNumber: e.orderNumber.value,
              orderReference: e.orderReference.value,
              orderStatus: e.orderStatus.value,
              orderType: e.orderType.value,
              quantityCancelled: e.quantityCancelled.value,
              quantityOrdered: e.quantityOrdered.value,
              quantityShipped: e.quantityShipped.value,
              shipTo: e.shipTo.value,
              soldToNumber: e.soldToNumber.value,
            ),
          ),
        );

        _orderStatuses.sort(
          (a, b) => a.orderDate.compareTo(b.orderDate),
        );

        filterOrders();

        if (labdipOrders.isNotEmpty) {
          if (rxSelectedLabdipOrder.value == null ||
              !labdipOrders.contains(rxSelectedLabdipOrder.value)) {
            selectLabdipOrder(labdipOrders.first);
          }
        } else {
          rxSelectedLabdipOrder.value = null;

          rxSelectedLabdipOrderDetails.clear();
        }
      }
    });

    filterOrders();

    isRefreshing.value = false;
  }

  Future<void> selectLabdipOrder(OrderStatusData orderStatusData) async {
    rxSelectedLabdipOrder.value = orderStatusData;

    rxSelectedLabdipOrderDetails.clear();

    final orderDetailLines = await Api.fetchOrderDetails(
      orderNumber: orderStatusData.orderNumber,
      orderType: orderStatusData.orderType,
      orderCompany: orderStatusData.orderCompany,
    );

    rxSelectedLabdipOrderDetails.addAll(orderDetailLines);
  }

  List<OrderStatusData> get inProgressOrders => _rxFilteredOrderStatuses
      .where(
        (orderStatusData) =>
            orderStatusData.orderStatus == 'In Progress' ||
            orderStatusData.orderStatus == 'Partially Dispatched',
      )
      .toList();

  List<OrderStatusData> get holdOrders => _rxFilteredOrderStatuses
      .where(
        (orderStatusData) => orderStatusData.orderStatus == 'Hold',
      )
      .toList();

  List<OrderStatusData> get cancelledOrders => _rxFilteredOrderStatuses
      .where(
        (orderStatusData) => orderStatusData.orderStatus == 'Cancelled',
      )
      .toList();

  List<OrderStatusData> get dispatchedOrders => _rxFilteredOrderStatuses
      .where(
        (orderStatusData) =>
            orderStatusData.orderStatus == 'Dispatched' ||
            orderStatusData.orderStatus == 'Partially Dispatched',
      )
      .toList();

  List<OrderStatusData> get labdipOrders => _rxFilteredOrderStatuses
      .where(
        (orderStatusData) => orderStatusData.orderType == 'LD',
      )
      .toList();

  Map<String, Article> get selectedOrderArticlesMap {
    final articleMap = <String, Article>{};

    for (var orderDetailLine in rxSelectedLabdipOrderDetails) {
      final item = orderDetailLine.item;

      List<String> itemParts = item.split(RegExp('\\s+'));

      log(itemParts.toString());

      if (itemParts.length == 3) {
        String article = itemParts[0].trim();

        String uom = itemParts[1].trim();

        String shade = itemParts[2].trim();

        int quantity = orderDetailLine.quantityOrdered;

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
                description: uomDescriptions[uom] ?? '',
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
                  description: uomDescriptions[uom] ?? '',
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

  bool get hasDefaultValues =>
      areDatesEqual(
        rxFromDate.value,
        rxFirstDate.value,
      ) &&
      areDatesEqual(rxToDate.value, DateTime.now()) &&
      rxOrderNumberInput.value.isEmpty;

  Future<void> setDefaultValues() async {
    rxFromDate.value = rxFirstDate.value;

    rxToDate.value = DateTime.now();

    rxOrderNumberInput.value = '';

    orderNumberTextEditingController.clear();

    await refreshOrders();
  }
}
