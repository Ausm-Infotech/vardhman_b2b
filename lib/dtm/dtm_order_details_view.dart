import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/order_detail_cell.dart';
import 'package:vardhman_b2b/common/order_detail_column_label.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/dtm/dtm_controller.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';

class DtmOrderDetailsView extends StatelessWidget {
  const DtmOrderDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DtmController dtmController = Get.find<DtmController>();

    final CatalogController catalogController = Get.find<CatalogController>();

    final OrderReviewController orderReviewController =
        Get.find<OrderReviewController>();

    return Obx(
      () {
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
                        if (dtmController.rxSelectedOrderHeaderLine.value !=
                            null) ...[
                          Text(
                            'Order Details for ${dtmController.rxSelectedOrderHeaderLine.value!.orderReference}',
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'JDE order no. ${dtmController.rxSelectedOrderHeaderLine.value!.orderNumber}',
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Dated ${DateFormat('dd/MM/yyyy').format(dtmController.rxSelectedOrderHeaderLine.value!.orderDate)}',
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: dtmController.rxSelectedOrderHeaderLine.value == null
                    ? const Center(
                        child: Text('No Order Selected'),
                      )
                    : DataTable2(
                        minWidth: 1600,
                        isHorizontalScrollBarVisible: true,
                        isVerticalScrollBarVisible: true,
                        columnSpacing: 0,
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
                            fixedWidth: 60,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Article'),
                            fixedWidth: 60,
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
                            label:
                                OrderDetailColumnLabel(labelText: 'Quantity'),
                            fixedWidth: 70,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(
                                labelText: 'Quantity Shipped'),
                            fixedWidth: 70,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label:
                                OrderDetailColumnLabel(labelText: 'Unit Price'),
                            fixedWidth: 80,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(
                                labelText: 'Total Price'),
                            fixedWidth: 80,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Status'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Invoice'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                          DataColumn2(
                            label: OrderDetailColumnLabel(labelText: 'Remark'),
                            size: ColumnSize.S,
                            headingRowAlignment: MainAxisAlignment.end,
                          ),
                        ],
                        rows: dtmController.primaryOrderDetailLines.map(
                          (orderDetail) {
                            final itemParts =
                                orderDetail.item.split(RegExp('\\s+'));

                            final String article = itemParts[0];
                            final String uom = itemParts[1];
                            final String shade = itemParts[2];

                            final catalogItem = catalogController.industryItems
                                .firstWhereOrNull(
                              (itemCatalogInfo) =>
                                  itemCatalogInfo.article == article &&
                                  itemCatalogInfo.uom == uom,
                            );

                            final index = dtmController.rxOrderDetailLines
                                .indexOf(orderDetail);

                            final permanentShadeLine =
                                dtmController.getPermanentShadeLine(
                              orderDetail.workOrderNumber,
                            );

                            var permanentShade = '';

                            var status = orderDetail.status;

                            var quantityShipped = 0;

                            double unitPrice = 0, extendedPrice = 0;

                            var invoicedLines = <OrderDetailLine>[];

                            if (permanentShadeLine != null) {
                              final permanentShadeParts =
                                  permanentShadeLine.item.split(RegExp('\\s+'));

                              if (permanentShadeParts.length == 3) {
                                permanentShade = permanentShadeParts[2];
                              }

                              invoicedLines = dtmController
                                  .getInvoicedLines(permanentShadeLine.item);

                              quantityShipped = invoicedLines.fold(
                                quantityShipped,
                                (previousValue, orderDetailLine) =>
                                    previousValue +
                                    orderDetailLine.quantityShipped,
                              );

                              unitPrice =
                                  invoicedLines.firstOrNull?.unitPrice ?? 0;

                              extendedPrice = invoicedLines.fold(
                                extendedPrice,
                                (previousValue, orderDetailLine) =>
                                    previousValue +
                                    orderDetailLine.extendedPrice,
                              );

                              if (invoicedLines.isNotEmpty) {
                                status = 'Dispatched';
                              } else {
                                status = permanentShadeLine.status;
                              }
                            }

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
                                    cellText: orderDetail.lineNumber.toString(),
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(cellText: article),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: "$uom - $uomDesc",
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: catalogItem?.ticket ?? '',
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: catalogItem?.brandDesc ?? '',
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: catalogItem?.tex ?? '',
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: catalogItem?.substrateDesc ?? '',
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(cellText: shade),
                                ),
                                DataCell(
                                  OrderDetailCell(cellText: permanentShade),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText:
                                        orderDetail.quantityOrdered.toString(),
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: quantityShipped.toString(),
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: unitPrice.toString(),
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: extendedPrice.toString(),
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(cellText: status),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: invoicedLines.firstOrNull != null
                                        ? "${invoicedLines.first.invoiceNumber} ${invoicedLines.first.invoiceType}"
                                        : '',
                                  ),
                                ),
                                DataCell(
                                  OrderDetailCell(
                                    cellText: orderDetail.userComment,
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
