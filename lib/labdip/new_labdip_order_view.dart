import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/labdip/catalog_search_field.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';
import 'package:vardhman_b2b/labdip/new_order_text_field.dart';

class NewLabdipOrderView extends StatelessWidget {
  const NewLabdipOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final labdipController = Get.find<LabdipController>();

    return Obx(
      () => Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            HeaderView(
              elevation: 0,
              leading: SecondaryButton(
                iconData: Icons.arrow_back_ios_new,
                text: 'Back',
                onPressed: () async {},
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: NewOrderTextField(
                    labelText: 'Merchandiser',
                    rxString: labdipController.rxMerchandiser,
                  ),
                ),
                Expanded(
                  child: NewOrderTextField(
                    labelText: 'Color',
                    rxString: labdipController.rxColor,
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
                  child: CatalogSearchField(
                    labelText: 'Buyer',
                    rxString: labdipController.rxBuyer,
                    searchList: labdipController.rxBuyerInfos
                        .map((buyerInfo) => buyerInfo.name)
                        .toList(),
                  ),
                ),
                Expanded(
                  child: NewOrderTextField(
                    labelText: 'Light Source 1',
                    rxString: labdipController.rxFirstLightSource,
                    enabled: false,
                  ),
                ),
                Expanded(
                  child: NewOrderTextField(
                    labelText: 'Light Source 2',
                    rxString: labdipController.rxSecondLightSource,
                    enabled: false,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: CatalogSearchField(
                    labelText: 'Substrate',
                    rxString: labdipController.rxSubstrate,
                    searchList: labdipController.uniqueFilteredSubstrates,
                  ),
                ),
                Expanded(
                  child: CatalogSearchField(
                    labelText: 'Ticket',
                    rxString: labdipController.rxTicket,
                    searchList: labdipController.uniqueFilteredTickets,
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
                  child: Column(
                    children: <Widget>[
                      CatalogSearchField(
                        labelText: 'Brand',
                        rxString: labdipController.rxBrand,
                        searchList: labdipController.uniqueFilteredBrands,
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: PrimaryButton(
                              wait: false,
                              text: 'Add Line',
                              onPressed: !labdipController.canAddOrderLine
                                  ? null
                                  : () async {},
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
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: NewOrderTextField(
                    labelText: 'Remark',
                    rxString: labdipController.rxRemark,
                    minLines: 4,
                  ),
                ),
              ],
            ),
            Expanded(
              child: DataTable2(
                columns: [
                  DataColumn2(label: Text('Color'), size: ColumnSize.S),
                  DataColumn2(label: Text('Buyer'), size: ColumnSize.S),
                  DataColumn2(label: Text('Substrate'), size: ColumnSize.S),
                  DataColumn2(label: Text('Ticket'), size: ColumnSize.S),
                  DataColumn2(label: Text('Tex'), size: ColumnSize.S),
                  DataColumn2(label: Text('Brand'), size: ColumnSize.S),
                  DataColumn2(label: Text('Article'), size: ColumnSize.S),
                  DataColumn2(label: Text('Remark'), size: ColumnSize.L),
                ],
                rows: labdipController.lapdipOrderLines
                    .map(
                      (element) => DataRow(
                        cells: [
                          DataCell(Text(element.color)),
                          DataCell(Text(element.buyer)),
                          DataCell(Text(element.substrate)),
                          DataCell(Text(element.ticket)),
                          DataCell(Text(element.tex)),
                          DataCell(Text(element.brand)),
                          DataCell(Text(element.article)),
                          DataCell(Text(element.remark)),
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
