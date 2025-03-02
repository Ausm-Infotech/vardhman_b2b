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
            fit: StackFit.expand,
            children: [
              Expanded(
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
                  margin: EdgeInsets.all(16),
                  constraints: const BoxConstraints(maxWidth: 300),
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
                      // Image.asset(
                      //   'assets/digital-nws.png',
                      //   height: 80,
                      //   width: 160,
                      // ),
                      // const SizedBox(
                      //   height: 16,
                      // ),
                      TextField(
                        controller: loginController.userIdTextEditingController,
                        decoration: InputDecoration(
                          labelText: 'User ID',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: <Widget>[],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
