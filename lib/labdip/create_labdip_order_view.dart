import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/common/catalog_search_field.dart';
import 'package:vardhman_b2b/labdip/labdip_entry_controller.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';
import 'package:vardhman_b2b/nav_rail_container.dart';

class CreateLabdipOrderView extends StatelessWidget {
  const CreateLabdipOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final labdipEntryController = Get.find<LabdipEntryController>();

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
                'New Labdip Order : ${labdipEntryController.orderNumber}',
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              trailing: PrimaryButton(
                text: 'Submit',
                onPressed: labdipEntryController.submitOrder,
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
                              rxString: labdipEntryController.rxMerchandiser,
                            ),
                          ),
                          // Expanded(
                          //   child: CatalogSearchField(
                          //     labelText: 'Billing Type',
                          //     rxString: labdipEntryController.rxBillingType,
                          //     searchList: labdipEntryController.billingTypes,
                          //   ),
                          // ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Shade',
                              rxString: labdipEntryController.rxShade,
                              searchList: labdipEntryController.shades,
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
                              rxString: labdipEntryController.rxBuyerName,
                              searchList: labdipEntryController.buyerNames,
                            ),
                          ),
                          if (labdipEntryController.isOtherBuyer)
                            Expanded(
                              child: NewOrderTextField(
                                labelText: 'Name',
                                rxString: labdipEntryController.rxOtherBuyer,
                              ),
                            ),
                          Expanded(
                            child: CatalogSearchField(
                              isEnabled: labdipEntryController.isOtherBuyer,
                              labelText: 'Light Source 1',
                              rxString:
                                  labdipEntryController.rxFirstLightSource,
                              searchList:
                                  labdipEntryController.firstLightSources,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              isEnabled: labdipEntryController.isOtherBuyer,
                              labelText: 'Light Source 2',
                              rxString:
                                  labdipEntryController.rxSecondLightSource,
                              searchList:
                                  labdipEntryController.secondLightSources,
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
                              rxString: labdipEntryController.rxSubstrate,
                              searchList: labdipEntryController
                                  .uniqueFilteredSubstrates,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              isEnabled: false,
                              labelText: 'Ticket',
                              rxString: labdipEntryController.rxTicket,
                              searchList:
                                  labdipEntryController.uniqueFilteredTickets,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Tex',
                              rxString: labdipEntryController.rxTex,
                              searchList:
                                  labdipEntryController.uniqueFilteredTexs,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Brand',
                              rxString: labdipEntryController.rxBrand,
                              searchList:
                                  labdipEntryController.uniqueFilteredBrands,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Article',
                              rxString: labdipEntryController.rxArticle,
                              searchList:
                                  labdipEntryController.uniqueFilteredArticles,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            labdipEntryController
                                    .rxSelectedLabdipOrderLines.isEmpty
                                ? PrimaryButton(
                                    text: 'Add Line',
                                    onPressed:
                                        !labdipEntryController.canAddOrderLine
                                            ? null
                                            : () async {
                                                labdipEntryController
                                                    .addLapdipOrderLine();
                                              },
                                  )
                                : SecondaryButton(
                                    text: 'Update',
                                    onPressed: labdipEntryController
                                                .rxSelectedLabdipOrderLines
                                                .length ==
                                            1
                                        ? () async {
                                            labdipEntryController
                                                .updateLapdipOrderLine();
                                          }
                                        : null,
                                  ),
                            PrimaryButton(
                              text: 'Delete',
                              onPressed: labdipEntryController
                                      .rxSelectedLabdipOrderLines.isEmpty
                                  ? null
                                  : () async {
                                      labdipEntryController
                                          .deleteSelectedLines();
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
                          rxString: labdipEntryController.rxColor,
                        ),
                        CatalogSearchField(
                          labelText: 'End Use',
                          rxString: labdipEntryController.rxEndUse,
                          searchList: labdipEntryController.endUseOptions,
                        ),
                        CatalogSearchField(
                          labelText: 'Request Type',
                          rxString: labdipEntryController.rxRequestType,
                          searchList: labdipEntryController.requestTypes,
                        ),
                        NewOrderTextField(
                          labelText: 'L A B',
                          rxString: labdipEntryController.rxLAB,
                        ),
                        NewOrderTextField(
                          labelText: 'Comment',
                          rxString: labdipEntryController.rxComment,
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
                rows: labdipEntryController.rxLabdipOrderLines
                    .map(
                      (labdipOrderLine) => DataRow(
                        selected: labdipEntryController
                            .rxSelectedLabdipOrderLines
                            .contains(labdipOrderLine),
                        onSelectChanged: (isSelected) {
                          if (isSelected == true) {
                            labdipEntryController.rxSelectedLabdipOrderLines
                                .add(labdipOrderLine);
                          } else {
                            labdipEntryController.rxSelectedLabdipOrderLines
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
