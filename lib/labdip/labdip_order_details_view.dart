import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/orders/orders_controller.dart';

class LabdipOrderDetailsView extends StatelessWidget {
  const LabdipOrderDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController = Get.find<OrdersController>();

    final CatalogController catalogController = Get.find<CatalogController>();

    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: <Widget>[
            Text(
              '${ordersController.rxSelectedLabdipOrder.value?.orderNumber} ${ordersController.rxSelectedLabdipOrder.value?.orderType}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: VardhmanColors.darkGrey,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Flexible(
              child: ordersController.rxSelectedLabdipOrderDetails.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : DataTable2(
                      columns: const [
                        DataColumn2(label: Text('Line'), size: ColumnSize.S),
                        DataColumn2(label: Text('Article'), size: ColumnSize.M),
                        DataColumn2(label: Text('Brand'), size: ColumnSize.M),
                        DataColumn2(label: Text('Ticket'), size: ColumnSize.S),
                        DataColumn2(label: Text('Tex'), size: ColumnSize.S),
                        DataColumn2(label: Text('Shade'), size: ColumnSize.M),
                        // DataColumn2(label: Text('Total'), size: ColumnSize.S),
                        // DataColumn2(
                        //     label: Text('Backordered'), size: ColumnSize.S),
                        // DataColumn2(
                        //     label: Text('Cancelled'), size: ColumnSize.S),
                      ],
                      rows: ordersController.rxSelectedLabdipOrderDetails.map(
                        (orderDetail) {
                          final itemParts =
                              orderDetail.item.split(RegExp('\\s+'));

                          final String article = itemParts[0];
                          final String uom = itemParts[1];
                          final String shade = itemParts[2];

                          final catalogItem =
                              catalogController.rxFilteredItems.firstWhere(
                            (itemCatalogInfo) =>
                                itemCatalogInfo.article == article &&
                                itemCatalogInfo.uom == uom,
                          );

                          return DataRow(
                            cells: [
                              DataCell(
                                Text(orderDetail.lineNumber.toStringAsFixed(2)),
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
                                Text(shade),
                              ),
                              // DataCell(
                              //   Text(orderDetail.quantityOrdered.toString()),
                              // ),
                              // DataCell(
                              //   Text(
                              //       orderDetail.quantityBackordered.toString()),
                              // ),
                              // DataCell(
                              //   Text(orderDetail.quantityCancelled.toString()),
                              // ),
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
