import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/order_summary.dart';

class OrderSummaryController extends GetxController {
  final rxOrderCustomersList = RxList<String>();

  final Rxn<DateTime> rxOrderSummaryDate = Rxn<DateTime>(DateTime.now());

  final rxOrderSummaryLines = <OrderSummary>[].obs;

  OrderSummaryController() {
    rxOrderSummaryDate.listenAndPump(orderSummaryDateListener);
  }

  Future<void> fetchSalsemanCode({
    required String soldToNumber,
  }) async {
    rxOrderCustomersList.value = await Api.fetchSalsemanCode(
      soldToNumber: '105979',
    );
  }

  Future<void> orderSummaryDateListener(DateTime? newDate) async {
    await fetchSalsemanCode(soldToNumber: '');
    rxOrderSummaryLines.value = await Api.fetchOrderCustomersByDate(
      salsemanCustomerList: rxOrderCustomersList,
      date: rxOrderSummaryDate.value!,
    );
  }
}
