import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/bulk/bulk_order_details_view.dart';
import 'package:vardhman_b2b/bulk/bulk_orders_view.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class BulkView extends StatelessWidget {
  const BulkView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<OrdersController>();

    return Container(
      color: VardhmanColors.dividerGrey,
      child: const Row(
        children: <Widget>[
          Expanded(
            child: BulkOrdersView(),
          ),
          VerticalDivider(
            thickness: 8,
            width: 8,
            color: VardhmanColors.darkGrey,
          ),
          Expanded(
            flex: 3,
            child: BulkOrderDetailsView(),
          ),
        ],
      ),
    );
  }
}
