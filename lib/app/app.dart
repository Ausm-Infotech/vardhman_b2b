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
          () => loginController.rxLoginState.value != LoginState.loggedIn
              ? const LoginView()
              : const HomeScaffold(),
        ),
      ),
    );
  }
}
