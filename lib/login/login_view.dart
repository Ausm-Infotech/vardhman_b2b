import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/login/login_controller.dart';
import 'package:video_player/video_player.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () => SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: loginController.videoPlayerController.value.size.width,
                  height:
                      loginController.videoPlayerController.value.size.height,
                  child: VideoPlayer(loginController.videoPlayerController),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      height: 100,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 140,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Image.asset(
                            'assets/digital-nws.png',
                            height: 60,
                          ),
                        ),
                        Image.asset(
                          'assets/50_years.png',
                          height: 140,
                          width: 140,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  // margin: EdgeInsets.all(16),
                  constraints: const BoxConstraints(maxWidth: 600),
                  // padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: Colors.black26,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'A&E DIGITAL WORLD',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Text(
                          'Welcome to our Portal which is for Buyers looking to place & track their Orders with ease, comfort and convenience, with a few clicks.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.zero,
                            bottom: Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: <Widget>[
                            // TextField(
                            //   controller:
                            //       loginController.userIdTextEditingController,
                            //   decoration: InputDecoration(
                            //     labelText: 'User ID',
                            //     border: OutlineInputBorder(),
                            //   ),
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: NewOrderTextField(
                                    isEnabled:
                                        loginController.rxLoginState.value ==
                                            LoginState.loggedOut,
                                    labelText: 'User ID',
                                    rxString: loginController.rxUserId,
                                  ),
                                ),
                                if (loginController.rxLoginState.value ==
                                    LoginState.password) ...[
                                  SizedBox(width: 16),
                                  SizedBox(
                                    width: 150,
                                    child: NewOrderTextField(
                                      obscureText: true,
                                      labelText: 'Password',
                                      rxString: loginController.rxPassword,
                                    ),
                                  ),
                                ],
                                if (loginController.rxLoginState.value ==
                                    LoginState.otp) ...[
                                  SizedBox(width: 16),
                                  SizedBox(
                                    width: 150,
                                    child: NewOrderTextField(
                                      labelText: 'OTP',
                                      rxString: loginController.rxOtp,
                                    ),
                                  ),
                                ],
                                if (loginController.rxLoginState.value ==
                                    LoginState.setPassword) ...[
                                  SizedBox(width: 16),
                                  SizedBox(
                                    width: 150,
                                    child: NewOrderTextField(
                                      obscureText: true,
                                      labelText: 'New Password',
                                      rxString: loginController.rxPassword,
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  SizedBox(
                                    width: 150,
                                    child: NewOrderTextField(
                                      obscureText: true,
                                      labelText: 'Confirm Password',
                                      isEnabled:
                                          loginController.rxPassword.isNotEmpty,
                                      rxString:
                                          loginController.rxConfirmPassword,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            if (loginController.rxLoginState.value ==
                                LoginState.loggedOut)
                              PrimaryButton(
                                iconData: Icons.login_outlined,
                                text: 'Send OTP',
                                onPressed:
                                    loginController.rxUserId.value.isEmpty
                                        ? null
                                        : loginController.validateUser,
                              ),
                            if (loginController.rxLoginState.value ==
                                LoginState.password)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SecondaryButton(
                                    text: 'Change User/Password',
                                    wait: false,
                                    onPressed: loginController.forgotPassword,
                                  ),
                                  SizedBox(width: 32),
                                  PrimaryButton(
                                    iconData: Icons.login_outlined,
                                    text: 'Login',
                                    onPressed:
                                        loginController.rxPassword.value.isEmpty
                                            ? null
                                            : loginController.validatePassword,
                                  ),
                                ],
                              ),
                            if (loginController.rxLoginState.value ==
                                LoginState.otp)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SecondaryButton(
                                    text: 'Cancel',
                                    wait: false,
                                    onPressed: () async {
                                      loginController.rxLoginState.value =
                                          LoginState.loggedOut;
                                      loginController.rxUserId.value = '';
                                      loginController.rxOtp.value = '';
                                    },
                                  ),
                                  SizedBox(width: 32),
                                  PrimaryButton(
                                    iconData: Icons.login_outlined,
                                    text: 'Verify OTP',
                                    onPressed:
                                        loginController.rxOtp.value.isEmpty
                                            ? null
                                            : loginController.validateOtp,
                                  ),
                                ],
                              ),
                            if (loginController.rxLoginState.value ==
                                LoginState.setPassword)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SecondaryButton(
                                    text: 'Cancel',
                                    wait: false,
                                    onPressed: () async {
                                      loginController.rxLoginState.value =
                                          LoginState.loggedOut;
                                      loginController.rxUserId.value = '';
                                      loginController.rxOtp.value = '';
                                    },
                                  ),
                                  SizedBox(width: 32),
                                  PrimaryButton(
                                    iconData: Icons.login_outlined,
                                    text: 'Set Password',
                                    onPressed: loginController.rxPassword.value
                                                .trim()
                                                .isEmpty ||
                                            loginController
                                                    .rxConfirmPassword.value !=
                                                loginController.rxPassword.value
                                        ? null
                                        : loginController.setPassword,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.black,
                  child: DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: VardhmanColors.red,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: const Text(
                                  'Vardhman Yarns & Threads Ltd, Central Marketing Office, 1st Floor, Palm Court Sector 16, M.G.Road Gurugram - 122001',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: VardhmanColors.red,
                              ),
                              SizedBox(width: 8),
                              const Text(
                                '+91 124-4981600 , +91 124-4981601',
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.email,
                                color: VardhmanColors.red,
                              ),
                              SizedBox(width: 8),
                              const Text(
                                'info@vardhmanthreads.in',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
