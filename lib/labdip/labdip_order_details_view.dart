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
                        minWidth: 1600,
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
                            fixedWidth: 50,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: Text('Article'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: Text('UOM'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: Text('Ticket'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: Text('Brand'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: Text('Tex'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: Text('Substrate'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: Text('Shade'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: Text('Final Shade'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: Text('Remark'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: Text('Status'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          if (hasDispatchedLine)
                            DataColumn2(
                              label: Text('Feedback'),
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
                                    : VardhmanColors.dividerGrey,
                              ),
                              cells: [
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      orderDetailLine.lineNumber.toString(),
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      article,
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "$uom - $uomDesc",
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      catalogItem?.ticket ?? '',
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      catalogItem?.brandDesc ?? '',
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      catalogItem?.tex ?? '',
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      catalogItem?.substrateDesc ?? '',
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      shade,
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      labdipTableRow?.permanentShade == null
                                          ? ''
                                          : '${labdipTableRow?.permanentShade} ${labdipTableRow?.reference}',
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      orderDetailLine.userComment,
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      orderDetailLine.status,
                                      style: TextStyle(color: textColor),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                                if (hasDispatchedLine)
                                  DataCell(
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: !isDispatchedLine
                                          ? SizedBox()
                                          : feedback != null
                                              ? Text(
                                                  feedback.reason,
                                                  style: TextStyle(
                                                    color: textColor,
                                                  ),
                                                  textAlign: TextAlign.end,
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
