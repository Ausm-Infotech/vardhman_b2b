import 'package:flutter/material.dart';
import 'package:vardhman_b2b/dtm/dtm_orders_view.dart';
import 'package:vardhman_b2b/labdip/labdip_orders_view.dart';
import 'package:vardhman_b2b/sample_data.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          child: LabdipOrdersView(
            labdipOrders: labdipOrders.sublist(
              0,
              labdipOrders.length > 5 ? 5 : labdipOrders.length,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Flexible(
          child: DtmOrdersView(
            dtmOrders: dtmOrders.sublist(
              0,
              dtmOrders.length > 5 ? 5 : dtmOrders.length,
            ),
          ),
        ),
      ],
    );
  }
}
