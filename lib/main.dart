import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vardhman_b2b/app/app.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/login/login_controller.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefs = await SharedPreferences.getInstance();

  Get.put(
    sharedPrefs,
    permanent: true,
  );

  Get.put(
    Database(),
    permanent: true,
  );

  Get.put(
    LoginController(),
    permanent: true,
  );

  HttpOverrides.global = MyHttpOverrides();

  runApp(const App());
}
