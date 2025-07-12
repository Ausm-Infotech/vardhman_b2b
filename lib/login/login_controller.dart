import 'dart:developer';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/bulk/bulk_controller.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/dtm/dtm_controller.dart';
import 'package:vardhman_b2b/home/home_controller.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';
import 'package:video_player/video_player.dart';

enum LoginState {
  unknown,
  loggedOut,
  otp,
  setPassword,
  password,
  loggedIn,
}

class LoginController extends GetxController {
  final _database = Get.find<Database>();

  late final VideoPlayerController videoPlayerController;

  final rxUserId = ''.obs;

  final rxOtp = ''.obs;

  final rxPassword = ''.obs;

  final rxConfirmPassword = ''.obs;

  final rxUserDetail = Rxn<UserDetail>();

  final rxLoginState = LoginState.unknown.obs;

  String _otp = '';
  String? _password;

  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  LoginController() {
    rxPassword.listen(passwordListener);

    _init();
  }

  void passwordListener(String newPassword) {
    if (newPassword.trim().isEmpty) {
      rxConfirmPassword.value = '';
    }
  }

  Future<void> _init() async {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse('https://b2b.amefird.in//assets/img/B2B.mp4'),
      videoPlayerOptions: VideoPlayerOptions(
        webOptions: VideoPlayerWebOptions(
          allowRemotePlayback: true,
        ),
      ),
    );

    await videoPlayerController.initialize();

    await videoPlayerController.setVolume(0);

    await videoPlayerController.setLooping(true);

    await videoPlayerController.play();

    _checkUser();
  }

  Future<void> _checkUser() async {
    rxUserDetail.value = await _database.managers.userDetails.getSingleOrNull();

    rxLoginState.value = LoginState.loggedOut;

    if (rxUserDetail.value != null) {
      rxUserId.value = rxUserDetail.value!.soldToNumber;

      await refreshToken(rxUserDetail.value!.soldToNumber);

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      _password = sharedPreferences.getString('password');

      if (_password != null) {
        rxLoginState.value = LoginState.password;
      }
    }
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
        autoCloseDuration: Duration(seconds: 3),
        primaryColor: VardhmanColors.red,
        title: const Text('Connection error!'),
        alignment: Alignment.bottomCenter,
      );

      return false;
    }
  }

  Future<void> validateUser() async {
    final isTokenRefreshed = await refreshToken(rxUserId.value);

    if (isTokenRefreshed) {
      final userDetailsCompanion = await Api.fetchUserData(rxUserId.value);

      if (userDetailsCompanion != null) {
        if (!userDetailsCompanion.isMobileUser.value) {
          _otp = await Api.generateAndSendOtp(
              userDetailsCompanion.mobileNumber.value);

          // _otp = "1234";

          toastification.show(
            autoCloseDuration: Duration(seconds: 3),
            primaryColor: VardhmanColors.green,
            alignment: Alignment.bottomCenter,
            title: Text(
              'OTP sent to ${userDetailsCompanion.mobileNumber.value}',
            ),
          );

          rxUserDetail.value = UserDetail(
            soldToNumber: userDetailsCompanion.soldToNumber.value,
            isMobileUser: userDetailsCompanion.isMobileUser.value,
            mobileNumber: userDetailsCompanion.mobileNumber.value,
            canSendSMS: userDetailsCompanion.canSendSMS.value,
            whatsAppNumber: userDetailsCompanion.whatsAppNumber.value,
            canSendWhatsApp: userDetailsCompanion.canSendWhatsApp.value,
            email: userDetailsCompanion.email.value,
            name: userDetailsCompanion.name.value,
            companyCode: userDetailsCompanion.companyCode.value,
            companyName: userDetailsCompanion.companyName.value,
            role: userDetailsCompanion.role.value,
            category: userDetailsCompanion.category.value,
            discountPercent: userDetailsCompanion.discountPercent.value,
          );

          rxLoginState.value = LoginState.otp;
        } else {
          toastification.show(
            autoCloseDuration: Duration(seconds: 3),
            primaryColor: VardhmanColors.red,
            title: const Text('User is not a B2B Portal user!'),
            alignment: Alignment.bottomCenter,
          );
        }
      } else {
        toastification.show(
          autoCloseDuration: Duration(seconds: 3),
          primaryColor: VardhmanColors.red,
          title: const Text('User not found!'),
          alignment: Alignment.bottomCenter,
        );
      }
    }
  }

  Future<void> validateOtp() async {
    if (rxOtp.value == _otp) {
      rxLoginState.value = LoginState.setPassword;
    } else {
      toastification.show(
        autoCloseDuration: Duration(seconds: 3),
        primaryColor: VardhmanColors.red,
        title: const Text('Incorrect OTP!'),
        alignment: Alignment.bottomCenter,
      );
    }
  }

  Future<void> validatePassword() async {
    if (rxPassword.value == _password) {
      await _logIn(
        rxUserDetail.value!,
      );
    } else {
      toastification.show(
        autoCloseDuration: Duration(seconds: 3),
        primaryColor: VardhmanColors.red,
        title: const Text('Incorrect password!'),
        alignment: Alignment.bottomCenter,
      );
    }
  }

  Future<void> setPassword() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    await sharedPreferences.setString('password', rxConfirmPassword.value);

    if (rxUserDetail.value != null) {
      _logIn(rxUserDetail.value!);
    }
  }

  Future<void> _logIn(UserDetail userDetail) async {
    await resetController(
      () => UserController(
        userDetail: userDetail,
        customerDetail: userDetail,
      ),
      tag: 'userController',
    );

    await resetController(() => CatalogController());

    await resetController(() => OrderReviewController());

    await resetController(() => OrdersController());

    await resetController(() => DtmController());

    await resetController(() => LabdipController());

    await resetController(() => BulkController());

    await resetController(() => InvoicesController());

    await resetController(() => HomeController());

    await _database.managers.userDetails.create(
      (o) => UserDetailsCompanion.insert(
        soldToNumber: (rxUserDetail.value!.role == 'CUSTOMER')
            ? rxUserDetail.value!.soldToNumber
            : rxUserId.value,
        isMobileUser: rxUserDetail.value!.isMobileUser,
        mobileNumber: rxUserDetail.value!.mobileNumber,
        canSendSMS: rxUserDetail.value!.canSendSMS,
        whatsAppNumber: rxUserDetail.value!.whatsAppNumber,
        canSendWhatsApp: rxUserDetail.value!.canSendWhatsApp,
        email: rxUserDetail.value!.email,
        name: rxUserDetail.value!.name,
        companyCode: rxUserDetail.value!.companyCode,
        companyName: rxUserDetail.value!.companyName,
        role: rxUserDetail.value!.role,
        category: rxUserDetail.value!.category,
        discountPercent: rxUserDetail.value!.discountPercent,
      ),
      mode: InsertMode.insertOrReplace,
    );

    rxLoginState.value = LoginState.loggedIn;

    toastification.show(
      autoCloseDuration: Duration(seconds: 3),
      primaryColor: VardhmanColors.green,
      title: Text('Logged in as ${userDetail.name}'),
    );
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

  void lockUser() {
    rxOtp.value = '';

    rxPassword.value = '';

    rxConfirmPassword.value = '';

    _checkUser();
  }

  Future<void> forgotPassword() async {
    _clearAllInputs();

    rxLoginState.value = LoginState.loggedOut;
  }

  void _clearAllInputs() {
    rxUserId.value = '';

    rxOtp.value = '';

    rxPassword.value = '';

    rxConfirmPassword.value = '';
  }
}
