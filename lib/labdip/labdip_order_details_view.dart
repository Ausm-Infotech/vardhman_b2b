import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';

class LabdipOrderDetailsView extends StatelessWidget {
  const LabdipOrderDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LabdipController labdipController = Get.find<LabdipController>();

    final CatalogController catalogController = Get.find<CatalogController>();

    return Obx(
      () => Container(
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
                      columnSpacing: 16,
                      showBottomBorder: true,
                      border: TableBorder.symmetric(
                        inside: BorderSide(
                            color: VardhmanColors.darkGrey, width: 0.2),
                        outside: BorderSide(
                            color: VardhmanColors.darkGrey, width: 0.2),
                      ),
                      headingCheckboxTheme: CheckboxThemeData(
                        fillColor: WidgetStatePropertyAll(Colors.white),
                        checkColor: WidgetStatePropertyAll(VardhmanColors.red),
                      ),
                      datarowCheckboxTheme: CheckboxThemeData(
                        fillColor: WidgetStatePropertyAll(Colors.white),
                        checkColor: WidgetStatePropertyAll(VardhmanColors.red),
                      ),
                      dataTextStyle: TextStyle(
                        color: VardhmanColors.darkGrey,
                        fontSize: 13,
                      ),
                      checkboxHorizontalMargin: 0,
                      headingRowHeight: 40,
                      dataRowHeight: 40,
                      headingRowColor:
                          WidgetStatePropertyAll(VardhmanColors.darkGrey),
                      headingTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      columns: const [
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
                          label: Text('Final\nShade'),
                          fixedWidth: 60,
                        ),
                        DataColumn2(
                            label: Text('Reference'), size: ColumnSize.M),
                        DataColumn2(label: Text('Comment'), size: ColumnSize.M),
                        DataColumn2(label: Text('Status'), size: ColumnSize.M),
                      ],
                      rows: labdipController.rxOrderDetailLines.map(
                        (orderDetail) {
                          final itemParts =
                              orderDetail.item.split(RegExp('\\s+'));

                          final String article = itemParts[0];
                          final String uom = itemParts[1];
                          final String shade = itemParts[2];

                          final catalogItem = catalogController.rxFilteredItems
                              .firstWhereOrNull(
                            (itemCatalogInfo) =>
                                itemCatalogInfo.article == article &&
                                itemCatalogInfo.uom == uom,
                          );

                          final labdipTableRow = labdipController
                              .getLabdipTableRow(orderDetail.workOrderNumber);

                          final index = labdipController.rxOrderDetailLines
                              .indexOf(orderDetail);

                          return DataRow(
                            selected: labdipController
                                .rxSelectedOrderDetailLinesReasonMap.keys
                                .contains(orderDetail),
                            onSelectChanged: orderDetail.status != 'Dispatched'
                                ? null
                                : (_) {
                                    labdipController
                                        .selectOrderDetailLine(orderDetail);
                                  },
                            color: WidgetStatePropertyAll(
                              index.isEven
                                  ? Colors.white
                                  : VardhmanColors.dividerGrey,
                            ),
                            cells: [
                              DataCell(
                                Text(orderDetail.lineNumber.toString()),
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
                                Text(labdipTableRow?.permanentShade ?? ''),
                              ),
                              DataCell(
                                Text(labdipTableRow?.reference ?? ''),
                              ),
                              DataCell(
                                Text(orderDetail.userComment),
                              ),
                              DataCell(
                                Text(orderDetail.status),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    ),
            ),
            if (labdipController.rxSelectedOrderDetailLinesReasonMap.isNotEmpty)
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
                        '${labdipController.rxSelectedOrderDetailLinesReasonMap.length} line${labdipController.rxSelectedOrderDetailLinesReasonMap.length > 1 ? 's' : ''} selected'),
                    PrimaryButton(
                      text: 'Rematch',
                      onPressed: () async {},
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
