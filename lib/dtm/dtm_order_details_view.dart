import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/dtm/dtm_controller.dart';

class DtmOrderDetailsView extends StatelessWidget {
  const DtmOrderDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final DtmController dtmController = Get.find<DtmController>();

    final CatalogController catalogController = Get.find<CatalogController>();

    return Obx(
      () => Container(
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            HeaderView(
              elevation: 1,
              trailing: SecondaryButton(
                iconData: Icons.refresh,
                text: 'Refresh',
                onPressed: dtmController.refreshSelectedOrderDetails,
              ),
              title: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 18,
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
                  : SingleChildScrollView(
                      child: DataTable(
                        columns: const [
                          DataColumn2(label: Text('Line'), size: ColumnSize.S),
                          DataColumn2(
                              label: Text('Article'), size: ColumnSize.M),
                          DataColumn2(label: Text('Brand'), size: ColumnSize.M),
                          DataColumn2(
                              label: Text('Ticket'), size: ColumnSize.S),
                          DataColumn2(label: Text('Tex'), size: ColumnSize.S),
                          DataColumn2(
                            label: Text('Shade'),
                            size: ColumnSize.M,
                          ),
                          DataColumn2(
                              label: Text('Quantity'), size: ColumnSize.M),
                          DataColumn2(
                              label: Text('Shipped'), size: ColumnSize.M),
                          DataColumn2(
                              label: Text('Comment'), size: ColumnSize.M),
                          DataColumn2(
                              label: Text('Status'), size: ColumnSize.M),
                        ],
                        rows: dtmController.primaryOrderDetailLines.map(
                          (orderDetail) {
                            final itemParts =
                                orderDetail.item.split(RegExp('\\s+'));

                            final String article = itemParts[0];
                            final String uom = itemParts[1];

                            final catalogItem =
                                catalogController.rxFilteredItems.firstWhere(
                              (itemCatalogInfo) =>
                                  itemCatalogInfo.article == article &&
                                  itemCatalogInfo.uom == uom,
                            );

                            final permanentShadeLine =
                                dtmController.getPermanentShadeLine(
                              orderDetail.workOrderNumber,
                            );

                            var permanentShade = 'SWT';

                            final quantityShipped = 0;

                            if (permanentShadeLine != null) {
                              final permanentShadeParts =
                                  permanentShadeLine.item.split(RegExp('\\s+'));

                              if (permanentShadeParts.length == 3) {
                                permanentShade = permanentShadeParts[2];
                              }
                            }

                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(orderDetail.lineNumber
                                      .toStringAsFixed(2)),
                                ),
                                DataCell(
                                  Text(article),
                                ),
                                DataCell(
                                  Text(catalogItem.brandDesc),
                                ),
                                DataCell(
                                  Text(catalogItem.ticket),
                                ),
                                DataCell(
                                  Text(catalogItem.tex),
                                ),
                                DataCell(
                                  Text(permanentShade),
                                ),
                                DataCell(
                                  Text(
                                    orderDetail.quantityOrdered.toString(),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    permanentShadeLine?.quantityShipped
                                            .toString() ??
                                        '',
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
