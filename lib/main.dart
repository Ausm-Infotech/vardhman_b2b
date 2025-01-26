import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_io/io.dart';
import 'package:vardhman_b2b/app/app.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/login/login_controller.dart';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     final httpClient = newUniversalHttpClient();

//     httpClient.badCertificateCallback =
//         (X509Certificate cert, String host, int port) {
//       return true;
//     };

//     return httpClient;
//   }
// }

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

  // HttpOverrides.global = MyHttpOverrides();

  runApp(const App());
}
