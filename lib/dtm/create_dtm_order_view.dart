import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/dtm/dtm_entry_controller.dart';
import 'package:vardhman_b2b/common/catalog_search_field.dart';
import 'package:vardhman_b2b/common/new_order_text_box.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';
import 'package:vardhman_b2b/nav_rail_container.dart';

class CreateDtmOrderView extends StatelessWidget {
  const CreateDtmOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final dtmEntryController = Get.find<DtmEntryController>();

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
                'New DTM Order : ', //TODO - B2BD-xxxx
                style: const TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              trailing: PrimaryButton(
                text: 'Submit',
                onPressed: dtmEntryController.submitOrder,
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
                              rxString: dtmEntryController.rxMerchandiser,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Billing Type',
                              rxString: dtmEntryController.rxBillingType,
                              searchList: dtmEntryController.billingTypes,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Shade',
                              rxString: dtmEntryController.rxShade,
                              searchList: dtmEntryController.shades,
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
                              rxString: dtmEntryController.rxBuyer,
                              searchList: dtmEntryController.rxBuyerInfos
                                  .map((buyerInfo) => buyerInfo.name)
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            child: NewOrderTextBox(
                              label: 'Light Source 1',
                              text: dtmEntryController
                                      .rxBuyerInfo.value?.firstLightSource ??
                                  '',
                            ),
                          ),
                          Expanded(
                            child: NewOrderTextBox(
                              label: 'Light Source 2',
                              text: dtmEntryController
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
                              rxString: dtmEntryController.rxSubstrate,
                              searchList:
                                  dtmEntryController.uniqueFilteredSubstrates,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Ticket',
                              rxString: dtmEntryController.rxTicket,
                              searchList:
                                  dtmEntryController.uniqueFilteredTickets,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Tex',
                              rxString: dtmEntryController.rxTex,
                              searchList: dtmEntryController.uniqueFilteredTexs,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Brand',
                              rxString: dtmEntryController.rxBrand,
                              searchList:
                                  dtmEntryController.uniqueFilteredBrands,
                            ),
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              labelText: 'Article',
                              rxString: dtmEntryController.rxArticle,
                              searchList:
                                  dtmEntryController.uniqueFilteredArticles,
                            ),
                          ),
                          Expanded(
                            child: NewOrderTextField(
                              labelText: 'Quantity',
                              rxString: dtmEntryController.rxQuantity,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            dtmEntryController.rxSelectedDtmEntryLines.isEmpty
                                ? PrimaryButton(
                                    text: 'Add Line',
                                    onPressed:
                                        !dtmEntryController.canAddOrderLine
                                            ? null
                                            : () async {
                                                dtmEntryController
                                                    .addDtmOrderLine();
                                              },
                                  )
                                : SecondaryButton(
                                    text: 'Update',
                                    onPressed: dtmEntryController
                                                .rxSelectedDtmEntryLines
                                                .length ==
                                            1
                                        ? () async {
                                            dtmEntryController
                                                .updateDtmOrderLine();
                                          }
                                        : null,
                                  ),
                            PrimaryButton(
                              text: 'Delete',
                              onPressed: dtmEntryController
                                      .rxSelectedDtmEntryLines.isEmpty
                                  ? null
                                  : () async {
                                      dtmEntryController.deleteSelectedLines();
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
                          rxString: dtmEntryController.rxColor,
                        ),
                        CatalogSearchField(
                          labelText: 'End Use',
                          rxString: dtmEntryController.rxEndUse,
                          searchList: dtmEntryController.endUseOptions,
                        ),
                        CatalogSearchField(
                          labelText: 'Request Type',
                          rxString: dtmEntryController.rxRequestType,
                          searchList: dtmEntryController.requestTypes,
                        ),
                        NewOrderTextField(
                          labelText: 'L A B',
                          rxString: dtmEntryController.rxLAB,
                        ),
                        NewOrderTextField(
                          labelText: 'Comment',
                          rxString: dtmEntryController.rxComment,
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
                rows: dtmEntryController.rxDtmEntryLines
                    .map(
                      (labdipOrderLine) => DataRow(
                        selected: dtmEntryController.rxSelectedDtmEntryLines
                            .contains(labdipOrderLine),
                        onSelectChanged: (isSelected) {
                          if (isSelected == true) {
                            dtmEntryController.rxSelectedDtmEntryLines
                                .add(labdipOrderLine);
                          } else {
                            dtmEntryController.rxSelectedDtmEntryLines
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
