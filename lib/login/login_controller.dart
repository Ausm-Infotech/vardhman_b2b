import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/home/home_controller.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/labdip/labdip_entry_controller.dart';
import 'package:vardhman_b2b/login/otp_view.dart';
import 'package:vardhman_b2b/orders/order_entry_controller.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class LoginController extends GetxController {
  final _database = Get.find<Database>();

  final TextEditingController userIdTextEditingController =
      TextEditingController();

  final TextEditingController otpTextEditingController =
      TextEditingController();

  final rxUserId = ''.obs;

  final rxOtp = ''.obs;

  final rxUserDetail = Rxn<UserDetail>();

  UserDetailsCompanion? _userDetailsCompanion;

  final rxIsProcessing = true.obs;

  List<RelatedCustomer> _relatedCustomers = [];

  String otp = '';

  LoginController() {
    userIdTextEditingController.addListener(
      () {
        rxUserId.value = userIdTextEditingController.text;
      },
    );

    otpTextEditingController.addListener(
      () {
        rxOtp.value = otpTextEditingController.text;
      },
    );

    init();
  }

  Future<void> init() async {
    final userDetail = await _database.managers.userDetails.getSingleOrNull();

    if (userDetail != null) {
      await _logIn(userDetail);
    }

    rxIsProcessing.value = false;
  }

  Future<void> validateUser() async {
    log('validateUser');

    _userDetailsCompanion = await Api.fetchUserData(rxUserId.value);

    if (_userDetailsCompanion != null) {
      Api.generateAndSendOtp('9623451355');

      otp = '1234';

      Get.snackbar(
        '',
        'OTP sent to ${_userDetailsCompanion!.mobileNumber.value}',
        colorText: VardhmanColors.green,
      );

      Get.to(() => const OtpView());

      userIdTextEditingController.clear();
    } else {
      Get.snackbar(
        '',
        'User not found!',
        colorText: VardhmanColors.red,
      );
    }
  }

  Future<void> validateOtp() async {
    if (_userDetailsCompanion != null &&
        otpTextEditingController.value.text == otp) {
      await _logIn(
        UserDetail(
          id: 0,
          mobileNumber: _userDetailsCompanion!.mobileNumber.value,
          name: _userDetailsCompanion!.name.value,
          soldToNumber: _userDetailsCompanion!.soldToNumber.value,
          companyCode: _userDetailsCompanion!.companyCode.value,
          companyName: _userDetailsCompanion!.companyName.value,
          role: _userDetailsCompanion!.role.value,
          category: _userDetailsCompanion!.category.value,
        ),
      );

      _database.managers.userDetails.create(
        (o) => _userDetailsCompanion!,
        mode: InsertMode.insertOrReplace,
      );

      otpTextEditingController.clear();

      Get.back();
    } else {
      Get.snackbar(
        '',
        'OTP incorrect!',
        colorText: VardhmanColors.red,
      );
    }
  }

  Future<UserDetail?> getCustomerDetail(UserDetail userDetail) async {
    if (!isCustomer(userDetail)) {
      final relatedCustomersCompanion = await Api.fetchRelatedCustomers(
        userCategory: userDetail.category,
        userAddressNumber: userDetail.soldToNumber,
      );

      if (relatedCustomersCompanion.isNotEmpty) {
        _relatedCustomers = relatedCustomersCompanion
            .map(
              (e) => RelatedCustomer(
                  id: 0,
                  managerSoldTo: e.managerSoldTo.value,
                  customerSoldTo: e.customerSoldTo.value,
                  customerName: e.customerName.value),
            )
            .toList();

        await _database.managers.relatedCustomers
            .filter(
              (f) => f.managerSoldTo.equals(userDetail.soldToNumber),
            )
            .delete();

        _database.managers.relatedCustomers.bulkCreate(
          (o) => relatedCustomersCompanion,
          mode: InsertMode.insertOrReplace,
        );

        final sharedPrefs = await SharedPreferences.getInstance();

        final sharedPrefsKey = sharedPrefsSelectedCustomerKey(userDetail);

        var selectedCustomerSoldTo =
            sharedPrefs.getString(sharedPrefsKey) ?? '';

        if (selectedCustomerSoldTo.isEmpty ||
            !relatedCustomersCompanion.any(
              (element) =>
                  element.customerSoldTo.value == selectedCustomerSoldTo,
            )) {
          selectedCustomerSoldTo =
              relatedCustomersCompanion.first.customerSoldTo.value;
        }

        final customerDetailComp =
            await Api.fetchUserData(selectedCustomerSoldTo);

        if (customerDetailComp != null) {
          sharedPrefs.setString(sharedPrefsKey, selectedCustomerSoldTo);

          return UserDetail(
            id: 0,
            mobileNumber: customerDetailComp.mobileNumber.value,
            name: customerDetailComp.name.value,
            soldToNumber: customerDetailComp.soldToNumber.value,
            companyCode: customerDetailComp.companyCode.value,
            companyName: customerDetailComp.companyName.value,
            role: customerDetailComp.role.value,
            category: customerDetailComp.category.value,
          );
        }
      }
    } else {
      return userDetail;
    }
    return null;
  }

  Future<void> _logIn(UserDetail userDetail) async {
    await Get.deleteAll();

    await Get.delete<UserController>(
      tag: 'userController',
      force: true,
    );

    final customerDetail = await getCustomerDetail(userDetail);

    if (!Get.isRegistered<OrderEntryController>()) {
      Get.put(
        OrderEntryController(),
        permanent: true,
      );
    }

    if (!Get.isRegistered<UserController>(tag: 'userController')) {
      Get.put(
        UserController(
          userDetail: userDetail,
          customerDetail: customerDetail ?? userDetail,
          relatedCustomers: _relatedCustomers,
        ),
        permanent: true,
        tag: 'userController',
      );
    }

    if (!Get.isRegistered<OrderReviewController>()) {
      Get.put(
        OrderReviewController(),
        permanent: true,
      );
    }

    if (!Get.isRegistered<OrdersController>()) {
      Get.put(
        OrdersController(),
        permanent: true,
      );
    }

    if (!Get.isRegistered<InvoicesController>()) {
      Get.put(
        InvoicesController(),
        permanent: true,
      );
    }

    if (!Get.isRegistered<CatalogController>()) {
      Get.put(
        CatalogController(),
        permanent: true,
      );
    }

    if (!Get.isRegistered<HomeController>()) {
      Get.put(
        HomeController(),
        permanent: true,
      );
    }

    if (!Get.isRegistered<LabdipEntryController>()) {
      Get.put(
        LabdipEntryController(),
        permanent: true,
      );
    }

    // Get.snackbar(
    //   '',
    //   'Logged in as ${userDetail.name}',
    //   colorText: VardhmanColors.green,
    // );

    rxUserDetail.value = userDetail;
  }
}
