import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
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
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Column(
          children: <Widget>[
            HeaderView(
              trailing: SecondaryButton(
                iconData: Icons.refresh,
                text: 'Refresh',
                onPressed: ordersController.refreshSelectedOrderDetails,
              ),
              title: Text(
                ordersController.rxSelectedOrder.value == null
                    ? 'Order Details'
                    : '${ordersController.rxSelectedOrder.value?.orderNumber} ${ordersController.rxSelectedOrder.value?.orderType}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: VardhmanColors.darkGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(
              child: ordersController.rxSelectedOrder.value == null
                  ? const Center(
                      child: Text('No Order Selected'),
                    )
                  : DataTable2(
                      columns: const [
                        DataColumn2(label: Text('Line'), size: ColumnSize.S),
                        DataColumn2(label: Text('Article'), size: ColumnSize.M),
                        DataColumn2(label: Text('Brand'), size: ColumnSize.M),
                        DataColumn2(label: Text('Ticket'), size: ColumnSize.S),
                        DataColumn2(label: Text('Tex'), size: ColumnSize.S),
                        DataColumn2(label: Text('Shade'), size: ColumnSize.M),
                      ],
                      rows: ordersController.rxSelectedOrderDetails.map(
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
