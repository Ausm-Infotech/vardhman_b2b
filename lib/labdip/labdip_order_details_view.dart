import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/api/labdip_feedback.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/order_detail_cell.dart';
import 'package:vardhman_b2b/common/order_detail_column_label.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/labdip/feedback_dialog.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class LabdipOrderDetailsView extends StatelessWidget {
  const LabdipOrderDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LabdipController labdipController = Get.find<LabdipController>();

    final CatalogController catalogController = Get.find<CatalogController>();

    final orderReviewController = Get.find<OrderReviewController>();

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
                trailing: labdipController.rxOrderDetailFeedbackMap.isEmpty
                    ? null
                    : PrimaryButton(
                        text: 'Submit Feedback',
                        onPressed: () async {
                          Get.dialog(FeedbackDialog());
                        },
                      ),
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
                        minWidth: 1200,
                        columnSpacing: 0,
                        showBottomBorder: true,
                        isHorizontalScrollBarVisible: true,
                        isVerticalScrollBarVisible: true,
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
                        headingRowHeight: 60,
                        dataRowHeight: 60,
                        headingRowColor:
                            WidgetStatePropertyAll(VardhmanColors.darkGrey),
                        headingTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        columns: [
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: '#'),
                            fixedWidth: 70,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Article'),
                            fixedWidth: 70,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'UOM'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Ticket'),
                            fixedWidth: 60,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Brand'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Tex'),
                            fixedWidth: 60,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label:
                                OrderDetailColumnLabel(labelText: 'Substrate'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Shade'),
                            fixedWidth: 70,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(
                                labelText: 'Final Shade'),
                            fixedWidth: 70,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Status'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Remark'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          if (hasDispatchedLine)
                            DataColumn2(
                              label:
                                  OrderDetailColumnLabel(labelText: 'Feedback'),
                              size: ColumnSize.S,
                              headingRowAlignment: MainAxisAlignment.end,
                            ),
                        ],
                        rows: labdipController.rxOrderDetailLines.map(
                          (orderDetailLine) {
                            final itemParts =
                                orderDetailLine.item.split(RegExp('\\s+'));

                            final String article = itemParts[0];
                            final String uom = itemParts[1];
                            final String shade = itemParts[2];

                            final catalogItem = catalogController.industryItems
                                .firstWhereOrNull(
                              (itemCatalogInfo) =>
                                  itemCatalogInfo.article == article &&
                                  itemCatalogInfo.uom == uom,
                            );

                            final labdipTableRows =
                                labdipController.getLabdipTableRows(
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

                            final textColor = feedback == null
                                ? VardhmanColors.darkGrey
                                : feedback.isPositive
                                    ? VardhmanColors.green
                                    : VardhmanColors.red;

                            final uomDesc =
                                orderReviewController.getUomDescription(uom);

                            return DataRow(
                              color: WidgetStatePropertyAll(
                                index.isEven
                                    ? Colors.white
                                    : VardhmanColors.dividerGrey.withAlpha(128),
                              ),
                              cells: [
                                DataCell(
                                  OrderDetailCell(
                                    cellText:
                                        orderDetailLine.lineNumber.toString(),
                                    textColor: textColor,
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: article,
                                    textColor: textColor,
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: "$uom - $uomDesc",
                                    textColor: textColor,
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: catalogItem?.ticket ?? '',
                                    textColor: textColor,
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: catalogItem?.brandDesc ?? '',
                                    textColor: textColor,
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: catalogItem?.tex ?? '',
                                    textColor: textColor,
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: catalogItem?.substrateDesc ?? '',
                                    textColor: textColor,
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: shade,
                                    textColor: textColor,
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText:
                                        labdipTableRows.map((labdipTableRow) {
                                      return '${labdipTableRow.permanentShade} ${labdipTableRow.reference}';
                                    }).join(', '),
                                    textColor: textColor,
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: orderDetailLine.status,
                                    textColor: textColor,
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: orderDetailLine.userComment,
                                    textColor: textColor,
                                  ),
                                ),
                                if (hasDispatchedLine)
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: !isDispatchedLine
                                          ? SizedBox()
                                          : feedback != null
                                              ? OrderDetailCell(
                                                  cellText: feedback.reason,
                                                  textColor: textColor,
                                                )
                                              : Checkbox(
                                                  fillColor:
                                                      WidgetStatePropertyAll(
                                                    Colors.white,
                                                  ),
                                                  checkColor:
                                                      VardhmanColors.red,
                                                  side: BorderSide(
                                                    color:
                                                        VardhmanColors.darkGrey,
                                                    width: 0.5,
                                                  ),
                                                  value: labdipController
                                                      .rxOrderDetailFeedbackMap
                                                      .keys
                                                      .contains(
                                                          orderDetailLine),
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
                                  ),
                              ],
                            );
                          },
                        ).toList(),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
