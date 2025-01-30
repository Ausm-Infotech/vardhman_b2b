import 'package:get/get.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class HomeController extends GetxController {
  final rxNavRailIndex = 3.obs;

  final UserDetail userDetail =
      Get.find<UserController>(tag: 'userController').rxUserDetail.value;

  final database = Get.find<Database>();

  final isLoaded = false.obs;

  final swiperIndex = 0.obs;

  HomeController();

  toggleLoaded() {}
}
