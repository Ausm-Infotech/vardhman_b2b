import 'package:data_table_2/data_table_2.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/labdip/create_labdip_order_view.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';
import 'package:vardhman_b2b/labdip/labdip_entry_controller.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class LabdipOrdersView extends StatelessWidget {
  const LabdipOrdersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController = Get.find<OrdersController>();

    final LabdipController labdipController = Get.find<LabdipController>();

    return Obx(
      () => Column(
        children: [
          HeaderView(
            leading: SecondaryButton(
              iconData: Icons.refresh,
              text: '',
              onPressed: ordersController.refreshOrders,
            ),
            title: const Text(
              'Labdip Orders',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: VardhmanColors.darkGrey,
              ),
            ),
            trailing: PrimaryButton(
              text: 'New Order',
              onPressed: () async {
                final newOrderNumber = await Api.fetchOrderNumber();

                if (newOrderNumber != null) {
                  if (Get.isRegistered<LabdipEntryController>()) {
                    Get.delete<LabdipEntryController>();
                  }

                  Get.put(
                    LabdipEntryController(
                      orderNumber: newOrderNumber,
                    ),
                  );

                  Get.dialog(
                    const Dialog(
                      insetPadding: EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 48,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CreateLabdipOrderView(),
                    ),
                  );
                } else {
                  toastification.show(
                    primaryColor: VardhmanColors.red,
                    title: Text('Failed to fetch new order number!'),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: labdipController.filteredLabdipOrders.isEmpty &&
                    labdipController.rxDraftOrders.isEmpty
                ? const Center(
                    child: Text('No Labdip Orders'),
                  )
                : Container(
                    padding: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: DataTable2(
                      columnSpacing: 16,
                      horizontalMargin: 16,
                      headingRowHeight: 40,
                      dataRowHeight: 40,
                      headingRowColor: WidgetStatePropertyAll(Colors.grey),
                      headingTextStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      dataTextStyle: TextStyle(
                        fontSize: 13,
                        color: VardhmanColors.darkGrey,
                      ),
                      border: TableBorder.symmetric(
                        inside: BorderSide(
                          width: 0.1,
                          color: VardhmanColors.darkGrey,
                        ),
                      ),
                      showCheckboxColumn: false,
                      columns: const [
                        DataColumn2(
                          label: Text('Order No.'),
                          size: ColumnSize.L,
                          headingRowAlignment: MainAxisAlignment.start,
                        ),
                        // DataColumn2(
                        //     label: Text('Reference'), size: ColumnSize.M),
                        DataColumn2(
                          label: Text('Date'),
                          size: ColumnSize.S,
                          // headingRowAlignment: MainAxisAlignment.end,
                          numeric: true,
                        ),
                      ],
                      rows: [
                        ...labdipController.rxDraftOrders.map(
                          (draftTableData) {
                            final index = labdipController.rxDraftOrders
                                .indexOf(draftTableData);

                            return DataRow(
                              color: WidgetStatePropertyAll(
                                index.isEven
                                    ? Colors.white
                                    : VardhmanColors.dividerGrey,
                              ),
                              onSelectChanged: (value) {
                                if (Get.isRegistered<LabdipEntryController>()) {
                                  Get.delete<LabdipEntryController>();
                                }

                                Get.put(
                                  LabdipEntryController(
                                    orderNumber: draftTableData.orderNumber,
                                  ),
                                );

                                Get.dialog(
                                  const Dialog(
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: 80,
                                      vertical: 48,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: CreateLabdipOrderView(),
                                  ),
                                );
                              },
                              cells: [
                                DataCell(
                                  Row(
                                    children: <Widget>[
                                      Text('Draft'),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(draftTableData.orderNumber
                                          .toString()),
                                    ],
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    DateFormat('d MMM yy').format(
                                      draftTableData.lastUpdated,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        ...labdipController.filteredLabdipOrders.map(
                          (labdipOrder) {
                            final index = labdipController.filteredLabdipOrders
                                    .indexOf(labdipOrder) +
                                labdipController.rxDraftOrders.length;

                            final isSelected = labdipController
                                    .rxSelectedOrderHeaderLine.value ==
                                labdipOrder;

                            final textStyle = TextStyle(
                              fontSize: 13,
                              color: isSelected
                                  ? Colors.white
                                  : VardhmanColors.darkGrey,
                            );

                            return DataRow(
                              color: WidgetStatePropertyAll(
                                isSelected
                                    ? VardhmanColors.red
                                    : index.isEven
                                        ? Colors.white
                                        : VardhmanColors.dividerGrey,
                              ),
                              selected: labdipOrder ==
                                  labdipController
                                      .rxSelectedOrderHeaderLine.value,
                              onSelectChanged: (value) {
                                if (value == true &&
                                    labdipController
                                            .rxSelectedOrderHeaderLine.value !=
                                        labdipOrder) {
                                  labdipController.selectOrder(labdipOrder);
                                }
                              },
                              cells: [
                                DataCell(
                                  DefaultTextStyle(
                                    style: textStyle,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                            labdipOrder.orderNumber.toString()),
                                        if (labdipOrder.orderReference
                                            .trim()
                                            .isNotEmpty) ...[
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Text(labdipOrder.orderReference),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    DateFormat('d MMM yy').format(
                                      labdipOrder.orderDate,
                                    ),
                                    style: textStyle,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ],
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
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Flexible(
                  child: DateTimeField(
                    mode: DateTimeFieldPickerMode.date,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'From Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Container(),
                      prefixText: DateFormat('d MMM yy').format(
                        ordersController.rxOrderFromDate.value,
                      ),
                      prefixStyle: TextStyle(
                        color: ordersController.rxOrderFromDate.value
                                .isAtSameMomentAs(oldestDateTime)
                            ? Colors.white
                            : VardhmanColors.darkGrey,
                        fontSize: 13,
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
                SizedBox(width: 8),
                Flexible(
                  child: DateTimeField(
                    mode: DateTimeFieldPickerMode.date,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: 'To Date',
                      border: OutlineInputBorder(),
                      suffixIcon: Container(),
                      prefixText: DateFormat('d MMM yy').format(
                        ordersController.rxOrderToDate.value,
                      ),
                      prefixStyle: TextStyle(
                        color: VardhmanColors.darkGrey,
                        fontSize: 13,
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
                SizedBox(width: 8),
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
