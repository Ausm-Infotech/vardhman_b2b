import 'package:flutter/material.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/sample_data.dart';

class DtmOrdersView extends StatelessWidget {
  const DtmOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: VardhmanColors.dividerGrey,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text('DTM ORDERS'),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: dtmOrders.first.keys
                        .map(
                          (e) => DataColumn(
                            label: Text(e),
                          ),
                        )
                        .toList(),
                    rows: dtmOrders
                        .map(
                          (dtmOrderMap) => DataRow(
                            cells: dtmOrderMap.values
                                .map(
                                  (dtmOrderData) => DataCell(
                                    Text(dtmOrderData),
                                  ),
                                )
                                .toList(),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
