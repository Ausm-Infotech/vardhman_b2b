import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/home/home_scaffold.dart';
import 'package:vardhman_b2b/login/login_controller.dart';
import 'package:vardhman_b2b/login/login_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();

    return ToastificationWrapper(
      child: GetMaterialApp(
        builder: (context, child) {
          const double customTextScaleFactor = 1; // Set your desired value
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(customTextScaleFactor),
            ),
            child: child!,
          );
        },
        theme: ThemeData(
          primaryColor: VardhmanColors.red,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: VardhmanColors.red,
            secondary: VardhmanColors.darkGrey,
          ),
          highlightColor: VardhmanColors.darkGrey,
          splashColor: VardhmanColors.red,
          buttonTheme: const ButtonThemeData(
            buttonColor: VardhmanColors.red,
          ),
          focusColor: VardhmanColors.darkGrey,
          hoverColor: VardhmanColors.red.withAlpha(32),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: VardhmanColors.red,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: VardhmanColors.darkGrey,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: VardhmanColors.dividerGrey,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: VardhmanColors.red,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: VardhmanColors.red,
              ),
            ),
            labelStyle: TextStyle(
              color: VardhmanColors.darkGrey,
            ),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: VardhmanColors.red,
            selectionColor: VardhmanColors.dividerGrey,
            selectionHandleColor: VardhmanColors.red,
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: WidgetStateProperty.all(VardhmanColors.red),
          ),
          radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.all(VardhmanColors.red),
          ),
          switchTheme: SwitchThemeData(
            thumbColor: WidgetStateProperty.all(VardhmanColors.red),
            trackColor:
                WidgetStateProperty.all(VardhmanColors.red.withAlpha(127)),
          ),
        ),
        home: Obx(
          () => loginController.rxIsProcessing.value
              ? Scaffold(
                  body: SafeArea(
                    child: Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/digital-nws.png'),
                            const SizedBox(
                              height: 36,
                            ),
                            const CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(VardhmanColors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : loginController.rxUserDetail.value != null
                  ? const HomeScaffold()
                  : const LoginView(),
        ),
      ),
    );
  }
}
