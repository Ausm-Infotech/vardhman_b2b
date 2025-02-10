import 'package:data_table_2/data_table_2.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/bulk/create_bulk_order_view.dart';
import 'package:vardhman_b2b/bulk/bulk_controller.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class BulkOrdersView extends StatelessWidget {
  const BulkOrdersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController = Get.find<OrdersController>();

    final BulkController bulkController = Get.find<BulkController>();

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
              'Bulk Orders',
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
                    child: CreateBulkOrderView(),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: bulkController.filteredBulkOrders.isEmpty
                ? const Center(
                    child: Text('No Bulk Orders'),
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
                          label: Text('Reference'),
                        ),
                        DataColumn(
                          label: Text('Date'),
                        ),
                      ],
                      rows: bulkController.filteredBulkOrders
                          .map(
                            (orderHeaderLine) => DataRow(
                              selected: orderHeaderLine ==
                                  bulkController
                                      .rxSelectedOrderHeaderLine.value,
                              onSelectChanged: (value) {
                                if (value == true &&
                                    bulkController
                                            .rxSelectedOrderHeaderLine.value !=
                                        orderHeaderLine) {
                                  bulkController.selectOrder(orderHeaderLine);
                                }
                              },
                              cells: [
                                DataCell(
                                  Text(orderHeaderLine.orderNumber.toString()),
                                ),
                                DataCell(
                                  Text(orderHeaderLine.orderReference),
                                ),
                                DataCell(
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(
                                      orderHeaderLine.orderDate,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 16, right: 8, left: 8, bottom: 8),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    controller: TextEditingController.fromValue(
                      TextEditingValue(
                        text: ordersController.rxOrderNumberInput.value,
                        selection: TextSelection.collapsed(
                          offset:
                              ordersController.rxOrderNumberInput.value.length,
                        ),
                      ),
                    ),
                    onChanged: (String orderNumber) {
                      ordersController.rxOrderNumberInput.value = orderNumber;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      isDense: true,
                      label: Text('Order No.'),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: DateTimeField(
                    mode: DateTimeFieldPickerMode.date,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'From Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Container(),
                      prefixText: DateFormat('d MMM yyyy').format(
                        ordersController.rxOrderFromDate.value,
                      ),
                      prefixStyle: TextStyle(
                        color: ordersController.rxOrderFromDate.value
                                .isAtSameMomentAs(oldestDateTime)
                            ? Colors.white
                            : VardhmanColors.darkGrey,
                        fontSize: 14,
                      ),
                    ),
                    firstDate: ordersController.rxEarliestOrderDate.value,
                    lastDate: ordersController.rxOrderToDate.value,
                    value: ordersController.rxOrderFromDate.value,
                    onChanged: (DateTime? date) {
                      if (date != null) {
                        ordersController.rxOrderFromDate.value = date;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: DateTimeField(
                    mode: DateTimeFieldPickerMode.date,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'To Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Container(),
                      prefixText: DateFormat('d MMM yyyy').format(
                        ordersController.rxOrderToDate.value,
                      ),
                      prefixStyle: TextStyle(
                        color: VardhmanColors.darkGrey,
                        fontSize: 14,
                      ),
                    ),
                    firstDate: ordersController.rxOrderFromDate.value,
                    lastDate: DateTime.now(),
                    value: ordersController.rxOrderToDate.value,
                    onChanged: (DateTime? date) {
                      if (date != null) {
                        ordersController.rxOrderToDate.value = date;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                SecondaryButton(
                  wait: false,
                  iconData: FontAwesomeIcons.arrowRotateLeft,
                  text: '',
                  onPressed: ordersController.hasDefaultValues
                      ? null
                      : ordersController.setDefaultValues,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
