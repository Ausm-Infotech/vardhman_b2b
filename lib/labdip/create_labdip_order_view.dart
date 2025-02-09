import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/common/catalog_search_field.dart';
import 'package:vardhman_b2b/labdip/labdip_entry_controller.dart';
import 'package:vardhman_b2b/common/new_order_text_box.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';
import 'package:vardhman_b2b/nav_rail_container.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';

class CreateLabdipOrderView extends StatelessWidget {
  const CreateLabdipOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final labdipController = Get.find<LabdipEntryController>();

    final OrderReviewController orderReviewController =
        Get.find<OrderReviewController>();

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
                'New Labdip Order : ${orderReviewController.b2bOrderNumber}',
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              trailing: PrimaryButton(
                text: 'Submit',
                onPressed: labdipController.submitOrder,
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
                              rxString: labdipController.rxMerchandiser,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Billing Type',
                              rxString: labdipController.rxBillingType,
                              searchList: labdipController.billingTypes,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Shade',
                              rxString: labdipController.rxShade,
                              searchList: labdipController.shades,
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
                              rxString: labdipController.rxBuyer,
                              searchList: labdipController.rxBuyerInfos
                                  .map((buyerInfo) => buyerInfo.name)
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            child: NewOrderTextBox(
                              label: 'Light Source 1',
                              text: labdipController
                                      .rxBuyerInfo.value?.firstLightSource ??
                                  '',
                            ),
                          ),
                          Expanded(
                            child: NewOrderTextBox(
                              label: 'Light Source 2',
                              text: labdipController
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
                              rxString: labdipController.rxSubstrate,
                              searchList:
                                  labdipController.uniqueFilteredSubstrates,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Ticket',
                              rxString: labdipController.rxTicket,
                              searchList:
                                  labdipController.uniqueFilteredTickets,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Tex',
                              rxString: labdipController.rxTex,
                              searchList: labdipController.uniqueFilteredTexs,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Brand',
                              rxString: labdipController.rxBrand,
                              searchList: labdipController.uniqueFilteredBrands,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Article',
                              rxString: labdipController.rxArticle,
                              searchList:
                                  labdipController.uniqueFilteredArticles,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            labdipController.rxSelectedLabdipOrderLines.isEmpty
                                ? PrimaryButton(
                                    text: 'Add Line',
                                    onPressed: !labdipController.canAddOrderLine
                                        ? null
                                        : () async {
                                            labdipController
                                                .addLapdipOrderLine();
                                          },
                                  )
                                : SecondaryButton(
                                    text: 'Update',
                                    onPressed: labdipController
                                                .rxSelectedLabdipOrderLines
                                                .length ==
                                            1
                                        ? () async {
                                            labdipController
                                                .updateLapdipOrderLine();
                                          }
                                        : null,
                                  ),
                            PrimaryButton(
                              text: 'Delete',
                              onPressed: labdipController
                                      .rxSelectedLabdipOrderLines.isEmpty
                                  ? null
                                  : () async {
                                      labdipController.deleteSelectedLines();
                                    },
                            ),
                          ],
                        ),
                      )
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
                          rxString: labdipController.rxColor,
                        ),
                        CatalogSearchField(
                          labelText: 'End Use',
                          rxString: labdipController.rxEndUse,
                          searchList: labdipController.endUseOptions,
                        ),
                        CatalogSearchField(
                          labelText: 'Request Type',
                          rxString: labdipController.rxRequestType,
                          searchList: labdipController.requestTypes,
                        ),
                        NewOrderTextField(
                          labelText: 'L A B',
                          rxString: labdipController.rxLAB,
                        ),
                        NewOrderTextField(
                          labelText: 'Comment',
                          rxString: labdipController.rxComment,
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
                rows: labdipController.rxLabdipOrderLines
                    .map(
                      (labdipOrderLine) => DataRow(
                        selected: labdipController.rxSelectedLabdipOrderLines
                            .contains(labdipOrderLine),
                        onSelectChanged: (isSelected) {
                          if (isSelected == true) {
                            labdipController.rxSelectedLabdipOrderLines
                                .add(labdipOrderLine);
                          } else {
                            labdipController.rxSelectedLabdipOrderLines
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
