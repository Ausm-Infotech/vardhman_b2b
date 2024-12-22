import 'package:flutter/material.dart';

class DtmOrdersView extends StatelessWidget {
  final List<Map<String, String>> dtmOrders;

  const DtmOrdersView({
    super.key,
    required this.dtmOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'DTM ORDERS',
            textAlign: TextAlign.center,
          ),
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
    );
  }
}
