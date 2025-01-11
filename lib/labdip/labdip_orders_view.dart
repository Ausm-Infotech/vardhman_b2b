import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class LabdipOrdersView extends StatelessWidget {
  const LabdipOrdersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController = Get.find<OrdersController>();

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
            'LABDIP ORDERS',
            textAlign: TextAlign.center,
          ),
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text('Order Number'),
                    ),
                    DataColumn(
                      label: Text('Type'),
                    ),
                    DataColumn(
                      label: Text('Date'),
                    ),
                    DataColumn(
                      label: Text('Quantity'),
                    ),
                    DataColumn(
                      label: Text('Shipped'),
                    ),
                    DataColumn(
                      label: Text('Cancelled'),
                    ),
                    DataColumn(
                      label: Text('Amount'),
                    ),
                    DataColumn(
                      label: Text('Status'),
                    ),
                  ],
                  rows: ordersController.labdipOrders
                      .map(
                        (labdipOrder) => DataRow(
                          cells: [
                            DataCell(
                              Text(labdipOrder.orderNumber.toString()),
                            ),
                            DataCell(
                              Text(labdipOrder.orderType),
                            ),
                            DataCell(
                              Text(DateFormat('dd/MM/yyyy')
                                  .format(labdipOrder.orderDate)),
                            ),
                            DataCell(
                              Text(labdipOrder.quantityOrdered.toString()),
                            ),
                            DataCell(
                              Text(labdipOrder.quantityShipped.toString()),
                            ),
                            DataCell(
                              Text(labdipOrder.quantityCancelled.toString()),
                            ),
                            DataCell(
                              Text(labdipOrder.orderStatus),
                            ),
                          ],
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
