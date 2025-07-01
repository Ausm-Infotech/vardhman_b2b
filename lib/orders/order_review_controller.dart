import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class OrderReviewController extends GetxController {
  final _userController = Get.find<UserController>(tag: 'userController');

  final rxOrderNumber = Rxn<int>();

  final rxIsProcessing = false.obs;

  final rxUomDescriptionMap = <String, String>{}.obs;

  OrderReviewController() {
    fetchDraftOrderNumber();

    Api.fetchUoMDescriptions().then(
      (uomDescMap) {
        rxUomDescriptionMap.clear();

        rxUomDescriptionMap.addAll(uomDescMap);
      },
    );
  }

  void fetchDraftOrderNumber() {
    Api.fetchDraftOrderNumber().then(
      (newOrderNumber) {
        if (newOrderNumber != null) {
          rxOrderNumber.value = newOrderNumber;
        }
      },
    );
  }

  String getUomDescription(String uom) {
    return rxUomDescriptionMap.containsKey(uom)
        ? rxUomDescriptionMap[uom]!
        : '';
  }

  Future<bool> submitLabdipOrder({
    required String merchandiserName,
    required String b2bOrderNumber,
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
      toastification.show(
        autoCloseDuration: Duration(seconds: 3),
        primaryColor: VardhmanColors.green,
        title: Text(
          'Order $b2bOrderNumber placed successfully!',
        ),
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

      fetchDraftOrderNumber();
    } else {
      toastification.show(
        autoCloseDuration: Duration(seconds: 3),
        primaryColor: VardhmanColors.red,
        title: Text(
          'Some error placing the order!',
        ),
      );
    }

    return isSubmitted;
  }

  Future<bool> submitDtmOrder({
    required String merchandiserName,
    required String b2bOrderNumber,
    required List<DraftTableData> dtmEntryLines,
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
      toastification.show(
          autoCloseDuration: Duration(seconds: 3),
          primaryColor: VardhmanColors.green,
          title: Text('Order $b2bOrderNumber placed successfully!'));

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

      fetchDraftOrderNumber();
    } else {
      toastification.show(
        autoCloseDuration: Duration(seconds: 3),
        primaryColor: VardhmanColors.red,
        title: Text('Some error placing the order!'),
      );
    }

    return isSubmitted;
  }

  Future<bool> submitBulkOrder({
    required String merchandiserName,
    required String b2bOrderNumber,
    required List<DraftTableData> bulkEntryLines,
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
      toastification.show(
        autoCloseDuration: Duration(seconds: 3),
        primaryColor: VardhmanColors.green,
        title: Text('Order $b2bOrderNumber placed successfully!'),
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

      fetchDraftOrderNumber();
    } else {
      toastification.show(
        autoCloseDuration: Duration(seconds: 3),
        primaryColor: VardhmanColors.red,
        title: Text('Some error placing the order!'),
      );
    }

    return isSubmitted;
  }

  bool get canSubmit =>
      _userController.rxDeliveryAddress.value != null &&
      rxOrderNumber.value != null;
}
