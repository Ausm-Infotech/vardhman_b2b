import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/orders/order_entry_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class OrderReviewController extends GetxController {
  final _userController = Get.find<UserController>(tag: 'userController');

  final _orderEntryController = Get.find<OrderEntryController>();

  final rxOrderNumber = Rxn<int>();

  final rxIsProcessing = false.obs;

  OrderReviewController() {
    fetchOrderNumber();
  }

  void fetchOrderNumber() {
    Api.fetchOrderNumber().then(
      (newOrderNumber) {
        if (newOrderNumber != null) {
          rxOrderNumber.value = newOrderNumber;
        }
      },
    );
  }

  Future<void> submit() async {
    rxIsProcessing.value = true;

    final itemQuantityMaps = <Map<String, String>>[];

    for (var article in _orderEntryController.carticleMap.values) {
      for (var uom in article.uomMap.values) {
        uom.shadeQuantitiesMap.forEach(
          (shade, quantity) {
            itemQuantityMaps.add(
              {
                "2nd_Item_Number": getItemNumber(
                    article: article.name, uom: uom.name, shade: shade),
                "Quantity_Ordered": quantity.toString(),
              },
            );
          },
        );
      }
    }

    final mappOrderNumber = 'MAPP-${rxOrderNumber.value}';

    final isSubmitted = await Api.submitOrder(
      branchPlant: _userController.rxDeliveryAddresses
              .firstWhere(
                (element) => element.deliveryAddressNumber == 0,
              )
              .branchPlant ??
          '',
      soldTo: _userController.rxCustomerDetail.value.soldToNumber,
      shipTo: (_userController.rxDeliveryAddress.value?.deliveryAddressNumber ==
                  0
              ? _userController.rxCustomerDetail.value.soldToNumber
              : _userController.rxDeliveryAddress.value?.deliveryAddressNumber)
          .toString(),
      company: _userController.rxCustomerDetail.value.companyCode,
      mobileOrderNumber: mappOrderNumber,
      itemQuantityMaps: itemQuantityMaps,
      orderTakenBy: _userController.rxUserDetail.value.role,
    );

    rxIsProcessing.value = false;

    if (isSubmitted) {
      Get.snackbar(
        '',
        'Order $mappOrderNumber placed successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: VardhmanColors.green,
        colorText: Colors.white,
      );

      Api.sendOrderEntrySMS(
        mappOrderNumber,
        _userController.rxCustomerDetail.value.mobileNumber,
      );

      _orderEntryController.carticleMap.clear();

      fetchOrderNumber();

      Get.back(
        closeOverlays: true,
      );
    } else {
      Get.snackbar(
        '',
        'Some error placing the order!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: VardhmanColors.red,
        colorText: Colors.white,
      );
    }
  }

  bool get canSubmit =>
      _userController.rxDeliveryAddress.value != null &&
      rxOrderNumber.value != null;
}
