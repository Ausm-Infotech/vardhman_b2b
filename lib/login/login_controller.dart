import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/home/home_controller.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/login/otp_view.dart';
import 'package:vardhman_b2b/orders/item_master_controller.dart';
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
    _userDetailsCompanion = await Api.fetchUserData(rxUserId.value);

    if (_userDetailsCompanion != null) {
      otp = '1234';

      toastification.show(
        primaryColor: VardhmanColors.green,
        title: Text('OTP sent to ${_userDetailsCompanion!.mobileNumber.value}'),
      );

      Get.to(() => const OtpView());

      userIdTextEditingController.clear();
    } else {
      toastification.show(
        primaryColor: VardhmanColors.red,
        title: const Text('User not found!'),
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

      Get.back(
        canPop: true,
        closeOverlays: true,
      );
    } else {
      toastification.show(
        primaryColor: VardhmanColors.red,
        title: const Text('OTP incorrect!'),
      );
    }
  }

  Future<UserDetail> getCustomerDetail(UserDetail userDetail) async {
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
                customerName: e.customerName.value,
              ),
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
    }

    return userDetail;
  }

  Future<void> _logIn(UserDetail userDetail) async {
    final customerDetail = await getCustomerDetail(userDetail);

    await resetController(
      () => UserController(
        userDetail: userDetail,
        customerDetail: customerDetail,
        relatedCustomers: isCustomer(customerDetail) ? [] : _relatedCustomers,
      ),
      tag: 'userController',
    );

    await resetController(() => ItemMasterController());

    await resetController(() => OrderEntryController());

    await resetController(() => OrderReviewController());

    await resetController(() => OrdersController());

    await resetController(() => InvoicesController());

    await resetController(() => CatalogController());

    await resetController(() => HomeController());

    toastification.show(
      primaryColor: VardhmanColors.green,
      title: Text('Logged in as ${userDetail.name}'),
    );

    rxUserDetail.value = userDetail;
  }

  Future<void> resetController<T extends GetxController>(
      T Function() controller,
      {String? tag}) async {
    await Get.delete<T>(tag: tag, force: true);

    Get.put<T>(
      controller(),
      permanent: true,
      tag: tag,
    );
  }
}
