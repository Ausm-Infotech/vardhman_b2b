import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/login/login_controller.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/digital-nws.png'),
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: loginController.otpTextEditingController,
                  decoration: const InputDecoration(
                    labelText: 'OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                PrimaryButton(
                  iconData: Icons.check,
                  text: 'Verify',
                  onPressed: loginController.rxOtp.value.isEmpty
                      ? null
                      : loginController.validateOtp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
