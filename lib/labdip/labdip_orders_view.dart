import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/labdip/new_labdip_order_view.dart';
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
                Get.dialog(
                  const Dialog(
                    insetPadding: EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 48,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: NewLabdipOrderView(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ordersController.labdipOrders.isEmpty
                ? const Center(
                    child: Text('No Labdip Orders'),
                  )
                : Container(
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
                        DataColumn(
                          label: Text('Date'),
                        ),
                      ],
                      rows: ordersController.labdipOrders
                          .map(
                            (labdipOrder) => DataRow(
                              selected: labdipOrder ==
                                  ordersController.rxSelectedOrder.value,
                              onSelectChanged: (value) {
                                if (value == true &&
                                    ordersController.rxSelectedOrder.value !=
                                        labdipOrder) {
                                  ordersController.selectOrder(labdipOrder);
                                }
                              },
                              cells: [
                                DataCell(
                                  Text('${labdipOrder.orderNumber}'),
                                ),
                                DataCell(
                                  Text(DateFormat('dd/MM/yyyy')
                                      .format(labdipOrder.orderDate)),
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
