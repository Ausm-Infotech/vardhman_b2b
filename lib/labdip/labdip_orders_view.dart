import 'package:flutter/material.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/sample_data.dart';

class LabdipOrdersView extends StatelessWidget {
  const LabdipOrdersView({super.key});

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
            const Text('LABDIP ORDERS'),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: labdipOrders.first.keys
                        .map(
                          (e) => DataColumn(
                            label: Text(e),
                          ),
                        )
                        .toList(),
                    rows: labdipOrders
                        .map(
                          (labdipOrderMap) => DataRow(
                            cells: labdipOrderMap.values
                                .map(
                                  (labdipOrderData) => DataCell(
                                    Text(labdipOrderData),
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
