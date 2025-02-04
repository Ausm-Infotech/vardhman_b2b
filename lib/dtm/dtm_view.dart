import 'package:flutter/material.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/dtm/dtm_order_details_view.dart';
import 'package:vardhman_b2b/dtm/dtm_orders_view.dart';

class DtmView extends StatelessWidget {
  const DtmView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Expanded(
          child: DtmOrdersView(),
        ),
        VerticalDivider(
          thickness: 0.5,
          width: 1,
          color: VardhmanColors.dividerGrey,
        ),
        Expanded(
          flex: 3,
          child: DtmOrderDetailsView(),
        ),
      ],
    );
  }
}
