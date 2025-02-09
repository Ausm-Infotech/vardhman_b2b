import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/dtm/dtm_controller.dart';
import 'package:vardhman_b2b/dtm/dtm_entry_controller.dart';
import 'package:vardhman_b2b/home/home_controller.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';
import 'package:vardhman_b2b/labdip/labdip_entry_controller.dart';
import 'package:vardhman_b2b/login/otp_view.dart';
import 'package:vardhman_b2b/orders/item_master_controller.dart';
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

  String otp = '';

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

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
      final isTokenRefreshed = await refreshToken(userDetail.soldToNumber);

      if (isTokenRefreshed) {
        await _logIn(userDetail);
      }
    }

    rxIsProcessing.value = false;
  }

  Future<String> getDeviceInfoString() async {
    String deviceInfoString = 'Unknown Device';

    try {
      if (GetPlatform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceInfoString = '${androidInfo.brand} ${androidInfo.model}';
      } else if (GetPlatform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceInfoString = '${iosInfo.name} ${iosInfo.model}';
      } else if (GetPlatform.isWeb) {
        final webInfo = await deviceInfo.webBrowserInfo;
        deviceInfoString = '${webInfo.browserName} ${webInfo.userAgent}';
      }
    } catch (e) {
      log('Failed to get device name: $e');
    }

    return deviceInfoString;
  }

  Future<bool> refreshToken(String userId) async {
    await Api.logout();

    final deviceInfoString = await getDeviceInfoString();

    final deviceName = '${deviceInfoString}_$userId';

    final isTokenSuccess = await Api.fetchToken(deviceName);

    if (isTokenSuccess) {
      return true;
    } else {
      toastification.show(
        primaryColor: VardhmanColors.red,
        title: const Text('Connection error!'),
      );

      return false;
    }
  }

  Future<void> validateUser() async {
    final isTokenRefreshed = await refreshToken(rxUserId.value);

    if (isTokenRefreshed) {
      _userDetailsCompanion = await Api.fetchUserData(rxUserId.value);

      if (_userDetailsCompanion != null) {
        if (!_userDetailsCompanion!.isMobileUser.value) {
          otp = await Api.generateAndSendOtp(
              _userDetailsCompanion!.mobileNumber.value);

          toastification.show(
            primaryColor: VardhmanColors.green,
            title: Text(
                'OTP sent to ${_userDetailsCompanion!.mobileNumber.value}'),
          );

          Get.to(() => const OtpView());

          userIdTextEditingController.clear();
        } else {
          toastification.show(
            primaryColor: VardhmanColors.red,
            title: const Text('User is not a B2B Portal user!'),
          );
        }
      } else {
        toastification.show(
          primaryColor: VardhmanColors.red,
          title: const Text('User not found!'),
        );
      }
    }
  }

  Future<void> validateOtp() async {
    if (_userDetailsCompanion != null &&
        otpTextEditingController.value.text == otp) {
      await _logIn(
        UserDetail(
          soldToNumber: _userDetailsCompanion!.soldToNumber.value,
          isMobileUser: _userDetailsCompanion!.isMobileUser.value,
          mobileNumber: _userDetailsCompanion!.mobileNumber.value,
          canSendSMS: _userDetailsCompanion!.canSendSMS.value,
          email: _userDetailsCompanion!.email.value,
          whatsAppNumber: _userDetailsCompanion!.whatsAppNumber.value,
          canSendWhatsApp: _userDetailsCompanion!.canSendWhatsApp.value,
          name: _userDetailsCompanion!.name.value,
          companyCode: _userDetailsCompanion!.companyCode.value,
          companyName: _userDetailsCompanion!.companyName.value,
          role: _userDetailsCompanion!.role.value,
          category: _userDetailsCompanion!.category.value,
          discountPercent: _userDetailsCompanion!.discountPercent.value,
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

  //

  Future<void> _logIn(UserDetail userDetail) async {
    await resetController(
      () => UserController(
        userDetail: userDetail,
        customerDetail: userDetail,
      ),
      tag: 'userController',
    );

    await resetController(() => ItemMasterController());

    await resetController(() => CatalogController());

    await resetController(() => LabdipEntryController());

    await resetController(() => DtmEntryController());

    await resetController(() => OrderReviewController());

    await resetController(() => OrdersController());

    await resetController(() => LabdipController());

    await resetController(() => DtmController());

    await resetController(() => InvoicesController());

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
