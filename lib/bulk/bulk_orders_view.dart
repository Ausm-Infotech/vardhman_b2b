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
import 'package:vardhman_b2b/bulk/create_bulk_order_view.dart';
import 'package:vardhman_b2b/bulk/bulk_controller.dart';
import 'package:vardhman_b2b/bulk/bulk_entry_controller.dart';

class BulkOrdersView extends StatelessWidget {
  const BulkOrdersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BulkController bulkController = Get.find<BulkController>();

    return Obx(
      () => Column(
        children: [
          HeaderView(
            leading: SecondaryButton(
              iconData: Icons.refresh,
              text: '',
              onPressed: bulkController.refreshOrders,
            ),
            title: const Text(
              'Bulk Orders',
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
                final newOrderNumber = await Api.fetchDraftOrderNumber();

                if (newOrderNumber != null) {
                  if (Get.isRegistered<BulkEntryController>()) {
                    Get.delete<BulkEntryController>();
                  }

                  Get.put(
                    BulkEntryController(
                      orderNumber: newOrderNumber,
                    ),
                  );

                  Get.dialog(
                    const Dialog(
                      insetPadding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 24,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CreateBulkOrderView(),
                    ),
                  );
                } else {
                  toastification.show(
                    autoCloseDuration: Duration(seconds: 3),
                    primaryColor: VardhmanColors.red,
                    title: Text('Failed to fetch new order number!'),
                  );
                }
              },
            ),
          ),
          Expanded(
            child: bulkController.filteredBulkOrders.isEmpty &&
                    bulkController.rxDraftOrders.isEmpty
                ? const Center(
                    child: Text('No Bulk Orders'),
                  )
                : Container(
                    padding: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: DataTable2(
                      minWidth: 600,
                      isHorizontalScrollBarVisible: true,
                      isVerticalScrollBarVisible: true,
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
                          headingRowAlignment: MainAxisAlignment.start,
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('Date'),
                          size: ColumnSize.S,
                          headingRowAlignment: MainAxisAlignment.center,
                        ),
                        DataColumn2(
                          label: Text('PO Number'),
                          size: ColumnSize.S,
                          headingRowAlignment: MainAxisAlignment.center,
                        ),
                        DataColumn2(
                          label: Text('Merchandiser'),
                          size: ColumnSize.M,
                          headingRowAlignment: MainAxisAlignment.center,
                        ),
                      ],
                      rows: [
                        ...bulkController.rxDraftOrders.map(
                          (draftTableData) {
                            final index = bulkController.rxDraftOrders
                                .indexOf(draftTableData);

                            return DataRow(
                              color: WidgetStatePropertyAll(
                                index.isEven
                                    ? Colors.white
                                    : VardhmanColors.dividerGrey.withAlpha(128),
                              ),
                              onSelectChanged: (value) {
                                if (Get.isRegistered<BulkEntryController>()) {
                                  Get.delete<BulkEntryController>();
                                }

                                Get.put(
                                  BulkEntryController(
                                    orderNumber: draftTableData.orderNumber,
                                  ),
                                );

                                Get.dialog(
                                  const Dialog(
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 24,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: CreateBulkOrderView(),
                                  ),
                                );
                              },
                              cells: [
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Draft',
                                          textAlign: TextAlign.end,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          draftTableData.orderNumber.toString(),
                                          textAlign: TextAlign.end,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      DateFormat('d MMM yy HH:mm').format(
                                        draftTableData.lastUpdated,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      draftTableData.poNumber,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      draftTableData.merchandiser,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        ...bulkController.filteredBulkOrders.map(
                          (orderHeaderLine) {
                            final index = bulkController.filteredBulkOrders
                                    .indexOf(orderHeaderLine) +
                                bulkController.rxDraftOrders.length;

                            final isSelected = bulkController
                                    .rxSelectedOrderHeaderLine.value ==
                                orderHeaderLine;

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
                                        : VardhmanColors.dividerGrey
                                            .withAlpha(128),
                              ),
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
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: DefaultTextStyle(
                                      style: textStyle,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            orderHeaderLine.orderNumber
                                                .toString(),
                                            textAlign: TextAlign.end,
                                          ),
                                          if (orderHeaderLine.orderReference
                                              .trim()
                                              .isNotEmpty) ...[
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Text(
                                              orderHeaderLine.orderReference,
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      DateFormat('d MMM yy').format(
                                        orderHeaderLine.orderDate,
                                      ),
                                      style: textStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      orderHeaderLine.poNumber,
                                      style: textStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      orderHeaderLine.merchandiser,
                                      style: textStyle,
                                      textAlign: TextAlign.center,
                                    ),
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
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: TextEditingController.fromValue(
                          TextEditingValue(
                            text: bulkController.rxOrderNumberInput.value,
                            selection: TextSelection.collapsed(
                              offset: bulkController
                                  .rxOrderNumberInput.value.length,
                            ),
                          ),
                        ),
                        onChanged: (String orderNumber) {
                          bulkController.rxOrderNumberInput.value = orderNumber;
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
                            bulkController.rxOrderFromDate.value,
                          ),
                          prefixStyle: TextStyle(
                            color: bulkController.rxOrderFromDate.value
                                    .isAtSameMomentAs(oldestDateTime)
                                ? Colors.white
                                : VardhmanColors.darkGrey,
                            fontSize: 13,
                          ),
                        ),
                        firstDate: bulkController.rxEarliestOrderDate.value,
                        lastDate: bulkController.rxOrderToDate.value,
                        value: bulkController.rxOrderFromDate.value,
                        onChanged: (DateTime? date) {
                          if (date != null) {
                            bulkController.rxOrderFromDate.value = date;
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
                            bulkController.rxOrderToDate.value,
                          ),
                          prefixStyle: TextStyle(
                            color: VardhmanColors.darkGrey,
                            fontSize: 13,
                          ),
                        ),
                        firstDate: bulkController.rxOrderFromDate.value,
                        lastDate: DateTime.now(),
                        value: bulkController.rxOrderToDate.value,
                        onChanged: (DateTime? date) {
                          if (date != null) {
                            bulkController.rxOrderToDate.value = date;
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    SecondaryButton(
                      wait: false,
                      iconData: FontAwesomeIcons.arrowRotateLeft,
                      text: '',
                      onPressed: bulkController.hasDefaultValues
                          ? null
                          : bulkController.setDefaultValues,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: TextEditingController.fromValue(
                          TextEditingValue(
                            text: bulkController.rxPoNumberInput.value,
                            selection: TextSelection.collapsed(
                              offset:
                                  bulkController.rxPoNumberInput.value.length,
                            ),
                          ),
                        ),
                        onChanged: (String poNumber) {
                          bulkController.rxPoNumberInput.value = poNumber;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [capitalFormatter],
                        decoration: InputDecoration(
                          isDense: true,
                          label: Text('PO Number'),
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
                      child: TextField(
                        controller: TextEditingController.fromValue(
                          TextEditingValue(
                            text: bulkController.rxMerchandiserInput.value,
                            selection: TextSelection.collapsed(
                              offset: bulkController
                                  .rxMerchandiserInput.value.length,
                            ),
                          ),
                        ),
                        onChanged: (String merchandiser) {
                          bulkController.rxMerchandiserInput.value =
                              merchandiser;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [capitalFormatter],
                        decoration: InputDecoration(
                          isDense: true,
                          label: Text('Merchandiser'),
                          labelStyle: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
