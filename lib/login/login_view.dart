import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/login/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/digital-nws.png',
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  TextField(
                    controller: loginController.userIdTextEditingController,
                    decoration: const InputDecoration(
                      labelText: 'User ID',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  PrimaryButton(
                    iconData: Icons.login_outlined,
                    text: 'Login',
                    onPressed: loginController.rxUserId.value.isEmpty
                        ? null
                        : loginController.validateUser,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
