import 'package:flutter/material.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/bulk/bulk_order_details_view.dart';
import 'package:vardhman_b2b/bulk/bulk_orders_view.dart';

class BulkView extends StatelessWidget {
  const BulkView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Expanded(
          child: BulkOrdersView(),
        ),
        VerticalDivider(
          thickness: 0.5,
          width: 1,
          color: VardhmanColors.dividerGrey,
        ),
        Expanded(
          flex: 3,
          child: BulkOrderDetailsView(),
        ),
      ],
    );
  }
}
