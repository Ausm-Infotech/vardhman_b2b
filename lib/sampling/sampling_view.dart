import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';
import 'package:vardhman_b2b/sampling/sampling_order_details_view.dart';
import 'package:vardhman_b2b/sampling/sampling_orders_view.dart';

class SamplingView extends StatelessWidget {
  const SamplingView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<OrdersController>();

    return Container(
      color: VardhmanColors.dividerGrey,
      child: const Row(
        children: <Widget>[
          Expanded(
            child: SamplingOrdersView(),
          ),
          VerticalDivider(
            thickness: 8,
            width: 8,
            color: VardhmanColors.darkGrey,
          ),
          Expanded(
            flex: 3,
            child: SamplingOrderDetailsView(),
          ),
        ],
      ),
    );
  }
}
