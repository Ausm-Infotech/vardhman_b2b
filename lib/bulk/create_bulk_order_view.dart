import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/bulk/bulk_entry_controller.dart';
import 'package:vardhman_b2b/common/catalog_search_field.dart';
import 'package:vardhman_b2b/common/new_order_text_box.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';
import 'package:vardhman_b2b/nav_rail_container.dart';

class CreateBulkOrderView extends StatelessWidget {
  const CreateBulkOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final bulkEntryController = Get.find<BulkEntryController>();

    return Obx(
      () => Container(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: <Widget>[
            HeaderView(
              elevation: 0,
              leading: SecondaryButton(
                wait: false,
                iconData: Icons.arrow_back_ios_new,
                text: 'Back',
                onPressed: () async {
                  Get.back();
                },
              ),
              title: Text(
                'New Bulk Order : ', // TODO - B2BB-xxxx
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              trailing: PrimaryButton(
                text: 'Submit',
                onPressed: bulkEntryController.submitOrder,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: NewOrderTextField(
                              labelText: 'Merchandiser',
                              rxString: bulkEntryController.rxMerchandiser,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Billing Type',
                              rxString: bulkEntryController.rxBillingType,
                              searchList: bulkEntryController.billingTypes,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Shade',
                              rxString: bulkEntryController.rxShade,
                              searchList: bulkEntryController.shades,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: CatalogSearchField(
                              labelText: 'Buyer',
                              rxString: bulkEntryController.rxBuyer,
                              searchList: bulkEntryController.rxBuyerInfos
                                  .map((buyerInfo) => buyerInfo.name)
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            child: NewOrderTextBox(
                              label: 'Light Source 1',
                              text: bulkEntryController
                                      .rxBuyerInfo.value?.firstLightSource ??
                                  '',
                            ),
                          ),
                          Expanded(
                            child: NewOrderTextBox(
                              label: 'Light Source 2',
                              text: bulkEntryController
                                      .rxBuyerInfo.value?.secondLightSource ??
                                  '',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: CatalogSearchField(
                              labelText: 'Substrate',
                              rxString: bulkEntryController.rxSubstrate,
                              searchList:
                                  bulkEntryController.uniqueFilteredSubstrates,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Ticket',
                              rxString: bulkEntryController.rxTicket,
                              searchList:
                                  bulkEntryController.uniqueFilteredTickets,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Tex',
                              rxString: bulkEntryController.rxTex,
                              searchList:
                                  bulkEntryController.uniqueFilteredTexs,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Brand',
                              rxString: bulkEntryController.rxBrand,
                              searchList:
                                  bulkEntryController.uniqueFilteredBrands,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Article',
                              rxString: bulkEntryController.rxArticle,
                              searchList:
                                  bulkEntryController.uniqueFilteredArticles,
                            ),
                          ),
                          Expanded(
                            child: NewOrderTextField(
                              labelText: 'Quantity',
                              rxString: bulkEntryController.rxQuantity,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            bulkEntryController.rxSelectedBulkEntryLines.isEmpty
                                ? PrimaryButton(
                                    text: 'Add Line',
                                    onPressed:
                                        !bulkEntryController.canAddOrderLine
                                            ? null
                                            : () async {
                                                bulkEntryController
                                                    .addBulkOrderLine();
                                              },
                                  )
                                : SecondaryButton(
                                    text: 'Update',
                                    onPressed: bulkEntryController
                                                .rxSelectedBulkEntryLines
                                                .length ==
                                            1
                                        ? () async {
                                            bulkEntryController
                                                .updateBulkOrderLine();
                                          }
                                        : null,
                                  ),
                            PrimaryButton(
                              text: 'Delete',
                              onPressed: bulkEntryController
                                      .rxSelectedBulkEntryLines.isEmpty
                                  ? null
                                  : () async {
                                      bulkEntryController.deleteSelectedLines();
                                    },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: NavRailContainer(
                    title: 'REMARKS',
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        NewOrderTextField(
                          labelText: 'Color Name',
                          rxString: bulkEntryController.rxColor,
                        ),
                        CatalogSearchField(
                          labelText: 'End Use',
                          rxString: bulkEntryController.rxEndUse,
                          searchList: bulkEntryController.endUseOptions,
                        ),
                        CatalogSearchField(
                          labelText: 'Request Type',
                          rxString: bulkEntryController.rxRequestType,
                          searchList: bulkEntryController.requestTypes,
                        ),
                        NewOrderTextField(
                          labelText: 'L A B',
                          rxString: bulkEntryController.rxLAB,
                        ),
                        NewOrderTextField(
                          labelText: 'Comment',
                          rxString: bulkEntryController.rxComment,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: DataTable2(
                columns: const [
                  DataColumn2(label: Text('Color'), size: ColumnSize.S),
                  DataColumn2(label: Text('Buyer'), size: ColumnSize.S),
                  DataColumn2(label: Text('Substrate'), size: ColumnSize.S),
                  DataColumn2(label: Text('Ticket'), size: ColumnSize.S),
                  DataColumn2(label: Text('Tex'), size: ColumnSize.S),
                  DataColumn2(label: Text('Brand'), size: ColumnSize.S),
                  DataColumn2(label: Text('Article'), size: ColumnSize.S),
                  DataColumn2(label: Text('Comment'), size: ColumnSize.L),
                ],
                rows: bulkEntryController.rxBulkEntryLines
                    .map(
                      (labdipOrderLine) => DataRow(
                        selected: bulkEntryController.rxSelectedBulkEntryLines
                            .contains(labdipOrderLine),
                        onSelectChanged: (isSelected) {
                          if (isSelected == true) {
                            bulkEntryController.rxSelectedBulkEntryLines
                                .add(labdipOrderLine);
                          } else {
                            bulkEntryController.rxSelectedBulkEntryLines
                                .remove(labdipOrderLine);
                          }
                        },
                        cells: [
                          DataCell(Text(labdipOrderLine.colorName)),
                          DataCell(Text(labdipOrderLine.buyerCode)),
                          DataCell(Text(labdipOrderLine.substrate)),
                          DataCell(Text(labdipOrderLine.ticket)),
                          DataCell(Text(labdipOrderLine.tex)),
                          DataCell(Text(labdipOrderLine.brand)),
                          DataCell(Text(labdipOrderLine.article)),
                          DataCell(Text(labdipOrderLine.comment)),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
