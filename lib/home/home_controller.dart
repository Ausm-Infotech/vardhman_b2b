import 'package:get/get.dart';

class HomeController extends GetxController {
  final rxNavRailIndex = 0.obs;

  final rxIsHovering = false.obs;

  final rxEmail = ''.obs;

  final Rxn<DateTime> rxFromDate =
      Rxn(DateTime.now().subtract(Duration(days: 30)));
}
