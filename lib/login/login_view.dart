import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
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
            children: [
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width:
                        loginController.videoPlayerController.value.size.width,
                    height:
                        loginController.videoPlayerController.value.size.height,
                    child: VideoPlayer(loginController.videoPlayerController),
                  ),
                ),
              ),
              Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Image.asset(
                        'assets/digital-nws.png',
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      TextField(
                        controller: loginController.userIdTextEditingController,
                        decoration: InputDecoration(
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
            ],
          ),
        ),
      ),
    );
  }
}
