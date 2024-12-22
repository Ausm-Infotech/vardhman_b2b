import 'package:flutter/material.dart';

class PendingInvoicesView extends StatelessWidget {
  final List<Map<String, String>> pendingInvoices;

  const PendingInvoicesView({
    super.key,
    required this.pendingInvoices,
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
            'PENDING INVOICES',
            textAlign: TextAlign.center,
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: pendingInvoices.first.keys
                      .map(
                        (e) => DataColumn(
                          label: Text(e),
                        ),
                      )
                      .toList(),
                  rows: pendingInvoices
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
    );
  }
}
