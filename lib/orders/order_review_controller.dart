import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/bulk/bulk_entry_line.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/dtm/dtm_entry_line.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class OrderReviewController extends GetxController {
  final _userController = Get.find<UserController>(tag: 'userController');

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

  Future<bool> submitLabdipOrder({
    required String merchandiserName,
    required List<DraftTableData> labdipOrderLines,
  }) async {
    bool isSubmitted = false;

    isSubmitted = await Api.submitLabdipOrder(
      b2bOrderNumber: b2bOrderNumber,
      merchandiserName: merchandiserName,
      branchPlant: _userController.branchPlant,
      soldTo: _userController.rxCustomerDetail.value.soldToNumber,
      shipTo: (_userController.rxDeliveryAddress.value?.deliveryAddressNumber ==
                  0
              ? _userController.rxCustomerDetail.value.soldToNumber
              : _userController.rxDeliveryAddress.value?.deliveryAddressNumber)
          .toString(),
      company: _userController.rxCustomerDetail.value.companyCode,
      orderTakenBy: _userController.rxUserDetail.value.role,
      labdipOrderLines: labdipOrderLines,
    );

    rxIsProcessing.value = false;

    if (isSubmitted) {
      Get.back();

      Get.snackbar(
        '',
        'Order $b2bOrderNumber placed successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: VardhmanColors.green,
        colorText: Colors.white,
      );

      if (_userController.rxCustomerDetail.value.canSendSMS) {
        Api.sendOrderEntrySMS(
          orderNumber: b2bOrderNumber,
          mobileNumber: _userController.rxCustomerDetail.value.mobileNumber,
        );
      }

      if (_userController.rxCustomerDetail.value.canSendWhatsApp) {
        Api.sendOrderEntryWhatsApp(
          orderNumber: b2bOrderNumber,
          mobileNumber: _userController.rxCustomerDetail.value.mobileNumber,
        );
      }

      fetchOrderNumber();
    } else {
      Get.snackbar(
        '',
        'Some error placing the order!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: VardhmanColors.red,
        colorText: Colors.white,
      );
    }

    return isSubmitted;
  }

  Future<bool> submitDtmOrder({
    required String merchandiserName,
    required List<DtmEntryLine> dtmEntryLines,
  }) async {
    bool isSubmitted = false;

    isSubmitted = await Api.submitDtmOrder(
      b2bOrderNumber: b2bOrderNumber,
      merchandiserName: merchandiserName,
      branchPlant: _userController.branchPlant,
      soldTo: _userController.rxCustomerDetail.value.soldToNumber,
      shipTo: (_userController.rxDeliveryAddress.value?.deliveryAddressNumber ==
                  0
              ? _userController.rxCustomerDetail.value.soldToNumber
              : _userController.rxDeliveryAddress.value?.deliveryAddressNumber)
          .toString(),
      company: _userController.rxCustomerDetail.value.companyCode,
      orderTakenBy: _userController.rxUserDetail.value.role,
      dtmEntryLines: dtmEntryLines,
    );

    rxIsProcessing.value = false;

    if (isSubmitted) {
      Get.back();

      Get.snackbar(
        '',
        'Order $b2bOrderNumber placed successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: VardhmanColors.green,
        colorText: Colors.white,
      );

      if (_userController.rxCustomerDetail.value.canSendSMS) {
        Api.sendOrderEntrySMS(
          orderNumber: b2bOrderNumber,
          mobileNumber: _userController.rxCustomerDetail.value.mobileNumber,
        );
      }

      if (_userController.rxCustomerDetail.value.canSendWhatsApp) {
        Api.sendOrderEntryWhatsApp(
          orderNumber: b2bOrderNumber,
          mobileNumber: _userController.rxCustomerDetail.value.mobileNumber,
        );
      }

      fetchOrderNumber();
    } else {
      Get.snackbar(
        '',
        'Some error placing the order!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: VardhmanColors.red,
        colorText: Colors.white,
      );
    }

    return isSubmitted;
  }

  Future<bool> submitBulkOrder({
    required String merchandiserName,
    required List<BulkEntryLine> bulkEntryLines,
  }) async {
    bool isSubmitted = false;

    isSubmitted = await Api.submitBulkOrder(
      b2bOrderNumber: b2bOrderNumber,
      merchandiserName: merchandiserName,
      branchPlant: _userController.branchPlant,
      soldTo: _userController.rxCustomerDetail.value.soldToNumber,
      shipTo: (_userController.rxDeliveryAddress.value?.deliveryAddressNumber ==
                  0
              ? _userController.rxCustomerDetail.value.soldToNumber
              : _userController.rxDeliveryAddress.value?.deliveryAddressNumber)
          .toString(),
      company: _userController.rxCustomerDetail.value.companyCode,
      orderTakenBy: _userController.rxUserDetail.value.role,
      bulkEntryLines: bulkEntryLines,
    );

    rxIsProcessing.value = false;

    if (isSubmitted) {
      Get.back();

      Get.snackbar(
        '',
        'Order $b2bOrderNumber placed successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: VardhmanColors.green,
        colorText: Colors.white,
      );

      if (_userController.rxCustomerDetail.value.canSendSMS) {
        Api.sendOrderEntrySMS(
          orderNumber: b2bOrderNumber,
          mobileNumber: _userController.rxCustomerDetail.value.mobileNumber,
        );
      }

      if (_userController.rxCustomerDetail.value.canSendWhatsApp) {
        Api.sendOrderEntryWhatsApp(
          orderNumber: b2bOrderNumber,
          mobileNumber: _userController.rxCustomerDetail.value.mobileNumber,
        );
      }

      fetchOrderNumber();
    } else {
      Get.snackbar(
        '',
        'Some error placing the order!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: VardhmanColors.red,
        colorText: Colors.white,
      );
    }

    return isSubmitted;
  }

  bool get canSubmit =>
      _userController.rxDeliveryAddress.value != null &&
      rxOrderNumber.value != null;

  String get b2bOrderNumber => 'B2B-${rxOrderNumber.value}';
}
