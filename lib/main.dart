import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vardhman_b2b/app/app.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/login/login_controller.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  VideoPlayerMediaKit.ensureInitialized(windows: true);

  final sharedPrefs = await SharedPreferences.getInstance();

  Get.put(
    sharedPrefs,
    permanent: true,
  );

  final database = Database();

  Get.put(
    database,
    permanent: true,
  );

  Get.put(
    LoginController(),
    permanent: true,
  );

  runApp(const App());
}
