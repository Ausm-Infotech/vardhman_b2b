import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/labdip/labdip_order_details.dart';
import 'package:vardhman_b2b/labdip/labdip_orders_view.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class LabdipView extends StatelessWidget {
  const LabdipView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<OrdersController>();

    return const Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: LabdipOrdersView(),
        ),
        VerticalDivider(
          thickness: 0.5,
          width: 1,
          color: VardhmanColors.dividerGrey,
        ),
        Expanded(
          flex: 2,
          child: LabdipOrderDetails(),
        ),
      ],
    );
  }
}
