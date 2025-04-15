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

class LabdipOrdersView extends StatelessWidget {
  const LabdipOrdersView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LabdipController labdipController = Get.find<LabdipController>();

    return Obx(
      () => Column(
        children: [
          HeaderView(
            leading: SecondaryButton(
              iconData: Icons.refresh,
              text: '',
              onPressed: labdipController.refreshOrders,
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
                        horizontal: 40,
                        vertical: 24,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CreateLabdipOrderView(),
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
                      minWidth: 450,
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
                          label: Text('Merchandiser'),
                          size: ColumnSize.M,
                          headingRowAlignment: MainAxisAlignment.center,
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
                                    : VardhmanColors.dividerGrey.withAlpha(128),
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
                                      horizontal: 40,
                                      vertical: 24,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: CreateLabdipOrderView(),
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
                                      draftTableData.merchandiser,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        ...labdipController.filteredLabdipOrders.map(
                          (orderHeaderLine) {
                            final index = labdipController.filteredLabdipOrders
                                    .indexOf(orderHeaderLine) +
                                labdipController.rxDraftOrders.length;

                            final isSelected = labdipController
                                    .rxSelectedOrderHeaderLine.value ==
                                orderHeaderLine;

                            final hasFeedback =
                                labdipController.rxLabdipFeedbacks.any(
                              (labdipFeedback) =>
                                  labdipFeedback.orderNumber ==
                                  orderHeaderLine.orderNumber,
                            );

                            final textStyle = TextStyle(
                              fontSize: 13,
                              color: isSelected
                                  ? Colors.white
                                  : hasFeedback
                                      ? VardhmanColors.red
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
                                  labdipController
                                      .rxSelectedOrderHeaderLine.value,
                              onSelectChanged: (value) {
                                if (value == true &&
                                    labdipController
                                            .rxSelectedOrderHeaderLine.value !=
                                        orderHeaderLine) {
                                  labdipController.selectOrder(orderHeaderLine);
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
                            text: labdipController.rxOrderNumberInput.value,
                            selection: TextSelection.collapsed(
                              offset: labdipController
                                  .rxOrderNumberInput.value.length,
                            ),
                          ),
                        ),
                        onChanged: (String orderNumber) {
                          labdipController.rxOrderNumberInput.value =
                              orderNumber;
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
                            labdipController.rxOrderFromDate.value,
                          ),
                          prefixStyle: TextStyle(
                            color: labdipController.rxOrderFromDate.value
                                    .isAtSameMomentAs(oldestDateTime)
                                ? Colors.white
                                : VardhmanColors.darkGrey,
                            fontSize: 13,
                          ),
                        ),
                        firstDate: labdipController.rxEarliestOrderDate.value,
                        lastDate: labdipController.rxOrderToDate.value,
                        value: labdipController.rxOrderFromDate.value,
                        onChanged: (DateTime? date) {
                          if (date != null) {
                            labdipController.rxOrderFromDate.value = date;
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
                            labdipController.rxOrderToDate.value,
                          ),
                          prefixStyle: TextStyle(
                            color: VardhmanColors.darkGrey,
                            fontSize: 13,
                          ),
                        ),
                        firstDate: labdipController.rxOrderFromDate.value,
                        lastDate: DateTime.now(),
                        value: labdipController.rxOrderToDate.value,
                        onChanged: (DateTime? date) {
                          if (date != null) {
                            labdipController.rxOrderToDate.value = date;
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    SecondaryButton(
                      wait: false,
                      iconData: FontAwesomeIcons.arrowRotateLeft,
                      text: '',
                      onPressed: labdipController.hasDefaultValues
                          ? null
                          : labdipController.setDefaultValues,
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
                            text: labdipController.rxMerchandiserInput.value,
                            selection: TextSelection.collapsed(
                              offset: labdipController
                                  .rxMerchandiserInput.value.length,
                            ),
                          ),
                        ),
                        onChanged: (String merchandiser) {
                          labdipController.rxMerchandiserInput.value =
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
