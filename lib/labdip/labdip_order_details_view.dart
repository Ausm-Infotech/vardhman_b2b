import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
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
              trailing: SecondaryButton(
                iconData: Icons.refresh,
                text: 'Refresh',
                onPressed: labdipController.refreshSelectedOrderDetails,
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
                      columnSpacing: 16,
                      horizontalMargin: 16,
                      headingRowHeight: 40,
                      headingRowColor: WidgetStatePropertyAll(Colors.grey),
                      headingTextStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      dataRowHeight: 40,
                      dataTextStyle: TextStyle(
                        fontSize: 13,
                        color: VardhmanColors.darkGrey,
                      ),
                      border: TableBorder.all(
                        color: VardhmanColors.darkGrey,
                        width: 0.2,
                      ),
                      showBottomBorder: true,
                      columns: const [
                        DataColumn2(label: Text('Line'), size: ColumnSize.S),
                        DataColumn2(label: Text('Article'), size: ColumnSize.M),
                        DataColumn2(label: Text('Brand'), size: ColumnSize.M),
                        DataColumn2(label: Text('Ticket'), size: ColumnSize.S),
                        DataColumn2(label: Text('Tex'), size: ColumnSize.S),
                        DataColumn2(label: Text('Shade'), size: ColumnSize.M),
                        DataColumn2(
                          label: Text('Permanent\nShade'),
                          size: ColumnSize.M,
                        ),
                        DataColumn2(
                            label: Text('Reference'), size: ColumnSize.M),
                        DataColumn2(label: Text('Comment'), size: ColumnSize.M),
                        DataColumn2(label: Text('Status'), size: ColumnSize.M),
                      ],
                      rows: labdipController.rxSelectedOrderDetailLines.map(
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

                          return DataRow(
                            cells: [
                              DataCell(
                                Text(orderDetail.lineNumber.toStringAsFixed(2)),
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
          ],
        ),
      ),
    );
  }
}
