import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/labdip/create_labdip_order.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class LabdipOrdersView extends StatelessWidget {
  const LabdipOrdersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController = Get.find<OrdersController>();

    return Obx(
      () => Column(
        children: [
          HeaderView(
            leading: SecondaryButton(
              iconData: Icons.refresh,
              text: 'Refresh',
              onPressed: ordersController.refreshOrders,
            ),
            title: const Text(
              'Labdip Orders',
              textAlign: TextAlign.center,
            ),
            trailing: PrimaryButton(
              text: 'New Order',
              onPressed: () async {
                Get.dialog(CreateOrderView());
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: DataTable2(
                showCheckboxColumn: false,
                columns: const [
                  DataColumn(
                    label: Text('Order Number'),
                  ),
                  // DataColumn(
                  //   label: Text('Type'),
                  // ),
                  DataColumn(
                    label: Text('Date'),
                  ),
                  // DataColumn(
                  //   label: Text('Quantity'),
                  // ),
                  // DataColumn(
                  //   label: Text('Shipped'),
                  // ),
                  // DataColumn(
                  //   label: Text('Cancelled'),
                  // ),
                  // DataColumn(
                  //   label: Text('Amount'),
                  // ),
                  DataColumn(
                    label: Text('Status'),
                  ),
                ],
                rows: ordersController.labdipOrders
                    .map(
                      (labdipOrder) => DataRow(
                        selected: labdipOrder ==
                            ordersController.rxSelectedLabdipOrder.value,
                        onSelectChanged: (value) {
                          if (value == true &&
                              ordersController.rxSelectedLabdipOrder.value !=
                                  labdipOrder) {
                            ordersController.selectLabdipOrder(labdipOrder);
                          }
                        },
                        cells: [
                          DataCell(
                            Text(labdipOrder.orderNumber.toString()),
                          ),
                          // DataCell(
                          //   Text(labdipOrder.orderType),
                          // ),
                          DataCell(
                            Text(DateFormat('dd/MM/yyyy')
                                .format(labdipOrder.orderDate)),
                          ),
                          // DataCell(
                          //   Text(labdipOrder.quantityOrdered.toString()),
                          // ),
                          // DataCell(
                          //   Text(labdipOrder.quantityShipped.toString()),
                          // ),
                          // DataCell(
                          //   Text(labdipOrder.quantityCancelled.toString()),
                          // ),
                          // DataCell(
                          //   Text(labdipOrder.orderAmount.toStringAsFixed(2)),
                          // ),
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
        ],
      ),
    );
  }
}
