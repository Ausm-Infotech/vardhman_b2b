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

class LabdipOrdersController extends GetxController {
  final _userController = Get.find<UserController>(tag: 'userController');

  final _rxFilteredOrderStatuses = RxList<OrderDetail>();

  final _orderStatuses = <OrderDetail>[];

  final isRefreshing = false.obs;

  final rxFirstDate = oldestDateTime.obs;

  final rxFromDate = oldestDateTime.obs;

  final rxToDate = DateTime.now().obs;

  final rxOrderNumberInput = ''.obs;

  final orderNumberTextEditingController = TextEditingController();

  final rxSelectedLabdipOrder = Rxn<OrderDetail>();

  final rxSelectedLabdipOrderDetails = <OrderDetailLine>[].obs;

  LabdipOrdersController() {
    init();
  }

  Future<void> init() async {
    _userController.rxCustomerDetail.listenAndPump(
      (_) async {
        await refreshOrders();

        final earliestOrderDate = _orderStatuses.isNotEmpty
            ? _orderStatuses.first.orderDate
            : oldestDateTime;

        rxFirstDate.value = earliestOrderDate;

        rxFromDate.value = earliestOrderDate;
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
      (OrderDetail) => OrderDetail.orderReference.trim().isNotEmpty
          ? OrderDetail.orderReference.contains(rxOrderNumberInput.value)
          : OrderDetail.orderNumber.toString().contains(
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
            (e) => OrderDetail(
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

  Future<void> selectLabdipOrder(OrderDetail OrderDetail) async {
    rxSelectedLabdipOrder.value = OrderDetail;

    rxSelectedLabdipOrderDetails.clear();

    final orderDetailLines = await Api.fetchOrderDetails(
      orderNumber: OrderDetail.orderNumber,
      orderType: OrderDetail.orderType,
      orderCompany: OrderDetail.orderCompany,
    );

    rxSelectedLabdipOrderDetails.addAll(orderDetailLines);
  }

  List<OrderDetail> get inProgressOrders => _rxFilteredOrderStatuses
      .where(
        (OrderDetail) =>
            OrderDetail.orderStatus == 'In Progress' ||
            OrderDetail.orderStatus == 'Partially Dispatched',
      )
      .toList();

  List<OrderDetail> get holdOrders => _rxFilteredOrderStatuses
      .where(
        (OrderDetail) => OrderDetail.orderStatus == 'Hold',
      )
      .toList();

  List<OrderDetail> get cancelledOrders => _rxFilteredOrderStatuses
      .where(
        (OrderDetail) => OrderDetail.orderStatus == 'Cancelled',
      )
      .toList();

  List<OrderDetail> get dispatchedOrders => _rxFilteredOrderStatuses
      .where(
        (OrderDetail) =>
            OrderDetail.orderStatus == 'Dispatched' ||
            OrderDetail.orderStatus == 'Partially Dispatched',
      )
      .toList();

  List<OrderDetail> get labdipOrders => _rxFilteredOrderStatuses
      .where(
        (OrderDetail) => OrderDetail.orderType == 'LD',
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
