import 'dart:math';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';
import 'package:vardhman_b2b/sample_data.dart';

class LabdipOrderDetails extends StatelessWidget {
  const LabdipOrderDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController = Get.find<OrdersController>();

    return Container(
      color: VardhmanColors.dividerGrey,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            'Order ${ordersController.rxSelectedOrder.value?.orderNumber} Details',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: VardhmanColors.darkGrey,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Flexible(
            child: SingleChildScrollView(
              child: DataTable2(
                columns: const [
                  DataColumn2(
                    label: Text('Item'),
                  ),
                  DataColumn2(
                    label: Text('Quantity'),
                  ),
                ],
                rows: ordersController.rxSelectedOrderDetails
                    .map(
                      (orderDetail) => DataRow(
                        cells: [
                          DataCell(
                            Text(orderDetail.item),
                          ),
                          DataCell(
                            Text(orderDetail.quantityOrdered.toString()),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
