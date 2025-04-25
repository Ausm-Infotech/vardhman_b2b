import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/order_summary.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class OrderSummaryController extends GetxController {
  final UserController userController = Get.find(tag: 'userController');
  final rxOrderCustomersList = RxList<String>();
  final soldToNumber = RxString;
  final rxOrderCustomersNameMap = RxMap<String, String>();

  final Rxn<DateTime> rxOrderSummaryDate = Rxn<DateTime>(DateTime.now());

  final rxOrderSummaryLines = <OrderSummary>[].obs;

  OrderSummaryController() {
    rxOrderSummaryDate.listenAndPump(orderSummaryDateListener);
  }

  Future<void> fetchSalsemanCode() async {
    rxOrderCustomersList.value = await Api.fetchSalsemanCode(
      soldToNumber: userController.rxUserDetail.value.soldToNumber,
    );
  }

  Future<void> fetchCustomersName() async {
    rxOrderCustomersNameMap.value = await Api.fetchCustomersName(
      salsemanCustomerList: rxOrderCustomersList,
    );
  }

  Future<void> orderSummaryDateListener(DateTime? newDate) async {
    await fetchSalsemanCode();
    await fetchCustomersName();
    rxOrderSummaryLines.value = await Api.fetchOrderCustomersByDate(
      salsemanCustomerList: rxOrderCustomersList,
      orderCustomersNameMap: rxOrderCustomersNameMap,
      date: rxOrderSummaryDate.value!,
    );
  }
}
