import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/common/catalog_search_field.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/labdip/labdip_entry_controller.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';

class CreateLabdipOrderView extends StatelessWidget {
  const CreateLabdipOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final labdipEntryController = Get.find<LabdipEntryController>();

    return Obx(
      () => Column(
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
              'New Labdip Order : ${labdipEntryController.b2bOrderNumber}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            trailing: PrimaryButton(
              text: 'Submit',
              onPressed: labdipEntryController.submitOrder,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 400),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: CatalogSearchField(
                                      labelText: 'Merchandiser',
                                      isRequired: true,
                                      rxString:
                                          labdipEntryController.rxMerchandiser,
                                      searchList: labdipEntryController
                                          .merchandiserNames,
                                    ),
                                  ),
                                  if (labdipEntryController.isOtherMerchandiser)
                                    Expanded(
                                      flex: 3,
                                      child: NewOrderTextField(
                                        isRequired: true,
                                        labelText: 'Name',
                                        rxString: labdipEntryController
                                            .rxOtherMerchandiser,
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
                                      isRequired: true,
                                      rxString:
                                          labdipEntryController.rxBuyerName,
                                      searchList:
                                          labdipEntryController.buyerNames,
                                    ),
                                  ),
                                  if (labdipEntryController.isOtherBuyer)
                                    Expanded(
                                      flex: 3,
                                      child: NewOrderTextField(
                                        labelText: 'Name',
                                        isRequired: true,
                                        rxString:
                                            labdipEntryController.rxOtherBuyer,
                                      ),
                                    ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: CatalogSearchField(
                                      isRequired: true,
                                      isEnabled:
                                          labdipEntryController.isOtherBuyer,
                                      labelText: 'Light Source 1',
                                      rxString: labdipEntryController
                                          .rxFirstLightSource,
                                      searchList: labdipEntryController
                                          .firstLightSources,
                                    ),
                                  ),
                                  Expanded(
                                    child: CatalogSearchField(
                                      isRequired: true,
                                      isEnabled:
                                          labdipEntryController.isOtherBuyer,
                                      labelText: 'Light Source 2',
                                      rxString: labdipEntryController
                                          .rxSecondLightSource,
                                      searchList: labdipEntryController
                                          .secondLightSources,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 400),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: CatalogSearchField(
                                      labelText: 'Article',
                                      isRequired: true,
                                      rxString: labdipEntryController.rxArticle,
                                      searchList: labdipEntryController
                                          .uniqueFilteredArticles,
                                    ),
                                  ),
                                  Expanded(
                                    child: CatalogSearchField(
                                      labelText: 'Shade',
                                      isRequired: true,
                                      rxString: labdipEntryController.rxShade,
                                      searchList: labdipEntryController.shades,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 3,
                                    child: CatalogSearchField(
                                      labelText: 'Brand',
                                      rxString: labdipEntryController.rxBrand,
                                      searchList: labdipEntryController
                                          .uniqueFilteredBrands,
                                    ),
                                  ),
                                  Expanded(
                                    child: CatalogSearchField(
                                      isEnabled: false,
                                      labelText: 'Ticket',
                                      rxString: labdipEntryController.rxTicket,
                                      searchList: labdipEntryController
                                          .uniqueFilteredTickets,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: CatalogSearchField(
                                      labelText: 'Tex',
                                      rxString: labdipEntryController.rxTex,
                                      searchList: labdipEntryController
                                          .uniqueFilteredTexs,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: CatalogSearchField(
                                      labelText: 'Substrate',
                                      rxString:
                                          labdipEntryController.rxSubstrate,
                                      searchList: labdipEntryController
                                          .uniqueFilteredSubstrates,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: '*',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: ' required field',
                                style: TextStyle(
                                  color: VardhmanColors.darkGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        PrimaryButton(
                          text: 'Add Line',
                          onPressed: !labdipEntryController.canAddOrderLine ||
                                  labdipEntryController
                                      .rxSelectedLabdipOrderLines.isNotEmpty
                              ? null
                              : () async {
                                  labdipEntryController.addLapdipOrderLine();
                                },
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        PrimaryButton(
                          text: 'Update',
                          onPressed: labdipEntryController
                                      .rxSelectedLabdipOrderLines.length ==
                                  1
                              ? () async {
                                  labdipEntryController.updateLapdipOrderLine();
                                }
                              : null,
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        PrimaryButton(
                          text: 'Delete',
                          onPressed: labdipEntryController
                                  .rxSelectedLabdipOrderLines.isEmpty
                              ? null
                              : () async {
                                  labdipEntryController.deleteSelectedLines();
                                },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: NewOrderTextField(
                            labelText: 'Color Name',
                            rxString: labdipEntryController.rxColor,
                          ),
                        ),
                        Expanded(
                          child: CatalogSearchField(
                            labelText: 'Request Type',
                            rxString: labdipEntryController.rxRequestType,
                            searchList: labdipEntryController.requestTypes,
                          ),
                        ),
                      ],
                    ),
                    CatalogSearchField(
                      labelText: 'End Use',
                      rxString: labdipEntryController.rxEndUse,
                      searchList: labdipEntryController.endUseOptions,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: NewOrderTextField(
                            labelText: 'L',
                            rxString: labdipEntryController.rxL,
                          ),
                        ),
                        Expanded(
                          child: NewOrderTextField(
                            labelText: 'A',
                            rxString: labdipEntryController.rxA,
                          ),
                        ),
                        Expanded(
                          child: NewOrderTextField(
                            labelText: 'B',
                            rxString: labdipEntryController.rxB,
                          ),
                        ),
                      ],
                    ),
                    NewOrderTextField(
                      labelText: 'Remark',
                      rxString: labdipEntryController.rxComment,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: DataTable2(
              headingRowColor:
                  WidgetStatePropertyAll(VardhmanColors.dividerGrey),
              border: TableBorder.symmetric(
                  outside: BorderSide(color: VardhmanColors.darkGrey),
                  borderRadius: BorderRadius.circular(8)),
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
              empty: Center(child: const Text('No Order Lines')),
              rows: labdipEntryController.rxLabdipOrderLines
                  .map(
                    (labdipOrderLine) => DataRow(
                      selected: labdipEntryController.rxSelectedLabdipOrderLines
                          .contains(labdipOrderLine),
                      onSelectChanged: (_) {
                        labdipEntryController
                            .selectLabdipOrderLine(labdipOrderLine);
                      },
                      cells: [
                        DataCell(Text(labdipOrderLine.colorName)),
                        DataCell(Text(labdipOrderLine.buyer)),
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
    );
  }
}
