import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vardhman_b2b/app/app.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/login/login_controller.dart';

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

  runApp(const App());
}
