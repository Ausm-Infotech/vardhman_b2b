import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/api/labdip_feedback.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/labdip/feedback_dialog.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class LabdipOrderDetailsView extends StatelessWidget {
  const LabdipOrderDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LabdipController labdipController = Get.find<LabdipController>();

    final CatalogController catalogController = Get.find<CatalogController>();

    return Obx(
      () {
        final hasDispatchedLine = labdipController.rxOrderDetailLines.any(
          (element) => element.status == 'Dispatched',
        );

        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              HeaderView(
                elevation: 4,
                title: DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: VardhmanColors.darkGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (labdipController.rxSelectedOrderHeaderLine.value !=
                            null) ...[
                          Text(
                            'Order Details for ${labdipController.rxSelectedOrderHeaderLine.value!.orderReference}',
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'JDE order no. ${labdipController.rxSelectedOrderHeaderLine.value!.orderNumber}',
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Dated ${DateFormat('dd/MM/yyyy').format(labdipController.rxSelectedOrderHeaderLine.value!.orderDate)}',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: labdipController.rxSelectedOrderHeaderLine.value == null
                    ? const Center(
                        child: Text('No Order Selected'),
                      )
                    : DataTable2(
                        columnSpacing: 8,
                        showBottomBorder: true,
                        border: TableBorder.symmetric(
                          inside: BorderSide(
                              color: VardhmanColors.darkGrey, width: 0.2),
                          outside: BorderSide(
                              color: VardhmanColors.darkGrey, width: 0.2),
                        ),
                        headingCheckboxTheme: CheckboxThemeData(
                          fillColor: WidgetStatePropertyAll(Colors.white),
                          checkColor:
                              WidgetStatePropertyAll(VardhmanColors.red),
                        ),
                        datarowCheckboxTheme: CheckboxThemeData(
                          fillColor: WidgetStatePropertyAll(Colors.white),
                          checkColor:
                              WidgetStatePropertyAll(VardhmanColors.red),
                        ),
                        dataTextStyle: TextStyle(
                          color: VardhmanColors.darkGrey,
                          fontSize: 13,
                        ),
                        checkboxHorizontalMargin: 0,
                        horizontalMargin: 0,
                        showCheckboxColumn: false,
                        headingRowHeight: 40,
                        dataRowHeight: 40,
                        headingRowColor:
                            WidgetStatePropertyAll(VardhmanColors.darkGrey),
                        headingTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        columns: [
                          DataColumn2(
                            label: Text('#'),
                            size: ColumnSize.S,
                            fixedWidth: 30,
                            numeric: true,
                          ),
                          DataColumn2(
                            label: Text('Article'),
                            fixedWidth: 60,
                          ),
                          DataColumn2(label: Text('Brand'), size: ColumnSize.M),
                          DataColumn2(
                            label: Text('Ticket'),
                            fixedWidth: 50,
                            numeric: true,
                          ),
                          DataColumn2(
                            label: Text('Tex'),
                            numeric: true,
                            fixedWidth: 40,
                          ),
                          DataColumn2(
                            label: Text('Shade'),
                            fixedWidth: 60,
                          ),
                          DataColumn2(
                            label: Text('Final Shade'),
                            fixedWidth: 80,
                          ),
                          DataColumn2(
                              label: Text('Remark'), size: ColumnSize.S),
                          DataColumn2(
                              label: Text('Status'), size: ColumnSize.M),
                          if (hasDispatchedLine)
                            DataColumn2(
                                label: Text('Feedback'), size: ColumnSize.S),
                        ],
                        rows: labdipController.rxOrderDetailLines.map(
                          (orderDetailLine) {
                            final itemParts =
                                orderDetailLine.item.split(RegExp('\\s+'));

                            final String article = itemParts[0];
                            final String uom = itemParts[1];
                            final String shade = itemParts[2];

                            final catalogItem = catalogController
                                .rxFilteredItems
                                .firstWhereOrNull(
                              (itemCatalogInfo) =>
                                  itemCatalogInfo.article == article &&
                                  itemCatalogInfo.uom == uom,
                            );

                            final labdipTableRow =
                                labdipController.getLabdipTableRow(
                                    orderDetailLine.workOrderNumber);

                            final index = labdipController.rxOrderDetailLines
                                .indexOf(orderDetailLine);

                            final isDispatchedLine =
                                orderDetailLine.status == 'Dispatched';

                            final OrdersController ordersController =
                                Get.find<OrdersController>();

                            final feedback = ordersController.rxLabdipFeedbacks
                                .firstWhereOrNull((labdipFeedback) =>
                                    labdipFeedback.orderNumber ==
                                        orderDetailLine.orderNumber &&
                                    labdipFeedback.lineNumber ==
                                        orderDetailLine.lineNumber);

                            return DataRow(
                              color: WidgetStatePropertyAll(
                                index.isEven
                                    ? Colors.white
                                    : VardhmanColors.dividerGrey,
                              ),
                              cells: [
                                DataCell(
                                  Text(orderDetailLine.lineNumber.toString()),
                                ),
                                DataCell(
                                  Text(article),
                                ),
                                DataCell(
                                  Text(catalogItem?.brandDesc ?? ''),
                                ),
                                DataCell(
                                  Text(catalogItem?.ticket ?? ''),
                                ),
                                DataCell(
                                  Text(catalogItem?.tex ?? ''),
                                ),
                                DataCell(
                                  Text(shade),
                                ),
                                DataCell(
                                  Text(labdipTableRow?.permanentShade == null
                                      ? ''
                                      : '${labdipTableRow?.permanentShade} ${labdipTableRow?.reference}'),
                                ),
                                DataCell(
                                  Text(orderDetailLine.userComment),
                                ),
                                DataCell(
                                  Text(orderDetailLine.status),
                                ),
                                if (hasDispatchedLine)
                                  DataCell(
                                    !isDispatchedLine
                                        ? SizedBox()
                                        : feedback != null
                                            ? Text(
                                                feedback.reason,
                                                style: TextStyle(
                                                  color: feedback.isPositive
                                                      ? VardhmanColors.green
                                                      : VardhmanColors.red,
                                                ),
                                              )
                                            : Checkbox(
                                                fillColor:
                                                    WidgetStatePropertyAll(
                                                  Colors.white,
                                                ),
                                                checkColor: VardhmanColors.red,
                                                side: BorderSide(
                                                  color:
                                                      VardhmanColors.darkGrey,
                                                  width: 0.5,
                                                ),
                                                value: labdipController
                                                    .rxOrderDetailFeedbackMap
                                                    .keys
                                                    .contains(orderDetailLine),
                                                onChanged: (bool? value) {
                                                  if (value == true) {
                                                    labdipController
                                                                .rxOrderDetailFeedbackMap[
                                                            orderDetailLine] =
                                                        LabdipFeedback(
                                                      orderNumber:
                                                          orderDetailLine
                                                              .orderNumber,
                                                      lineNumber:
                                                          orderDetailLine
                                                              .lineNumber,
                                                      reason: '',
                                                      isPositive: false,
                                                      shouldRematch: false,
                                                    );
                                                  } else {
                                                    labdipController
                                                        .rxOrderDetailFeedbackMap
                                                        .remove(
                                                            orderDetailLine);
                                                  }
                                                },
                                              ),
                                  ),
                              ],
                            );
                          },
                        ).toList(),
                      ),
              ),
              if (labdipController.rxOrderDetailFeedbackMap.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: VardhmanColors.darkGrey,
                        width: 0.2,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          '${labdipController.rxOrderDetailFeedbackMap.length} line${labdipController.rxOrderDetailFeedbackMap.length > 1 ? 's' : ''} selected for feedback'),
                      PrimaryButton(
                        text: 'Submit Feedback',
                        onPressed: () async {
                          Get.dialog(FeedbackDialog());
                        },
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
