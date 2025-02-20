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
            elevation: 4,
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
              onPressed: labdipEntryController.rxLabdipOrderLines.isEmpty
                  ? null
                  : labdipEntryController.submitOrder,
            ),
          ),
          Container(
            color: VardhmanColors.dividerGrey.withAlpha(128),
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: <Widget>[
                                CatalogSearchField(
                                  isRequired: true,
                                  labelText: 'Merchandiser',
                                  rxString:
                                      labdipEntryController.rxMerchandiser,
                                  searchList:
                                      labdipEntryController.rxMerchandisers,
                                  shouldEnforceList: false,
                                  hasError: labdipEntryController
                                      .merchandiserHasError,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: CatalogSearchField(
                                        hasError: labdipEntryController
                                            .buyerNameHasError,
                                        labelText: 'Buyer',
                                        isRequired: true,
                                        rxString:
                                            labdipEntryController.rxBuyerName,
                                        searchList:
                                            labdipEntryController.buyerNames,
                                      ),
                                    ),
                                    if (labdipEntryController.isOtherBuyer) ...[
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: NewOrderTextField(
                                          hasError: labdipEntryController
                                              .otherBuyerNameHasError,
                                          labelText: 'Name',
                                          isRequired: true,
                                          rxString: labdipEntryController
                                              .rxOtherBuyerName,
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: CatalogSearchField(
                                        hasError: labdipEntryController
                                            .firstLightSourceHasError,
                                        isRequired: true,
                                        isEnabled: labdipEntryController
                                            .isLightSource1Enabled,
                                        labelText: 'Light Source 1',
                                        rxString: labdipEntryController
                                            .rxFirstLightSource,
                                        searchList: labdipEntryController
                                            .firstLightSources,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: CatalogSearchField(
                                        isEnabled: labdipEntryController
                                            .isLightSource2Enabled,
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
                          Spacer(),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: CatalogSearchField(
                                        hasError: labdipEntryController
                                            .articleHasError,
                                        labelText: 'Article',
                                        isRequired: true,
                                        rxString:
                                            labdipEntryController.rxArticle,
                                        searchList: labdipEntryController
                                            .uniqueFilteredArticles,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: CatalogSearchField(
                                        hasError:
                                            labdipEntryController.shadeHasError,
                                        labelText: 'Shade',
                                        isRequired: true,
                                        isEnabled: labdipEntryController
                                            .rxArticle.isNotEmpty,
                                        rxString: labdipEntryController.rxShade,
                                        searchList:
                                            labdipEntryController.rxShades,
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
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CatalogSearchField(
                                        isEnabled: false,
                                        labelText: 'Ticket',
                                        rxString:
                                            labdipEntryController.rxTicket,
                                        searchList: labdipEntryController
                                            .uniqueFilteredTickets,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
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
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CatalogSearchField(
                                        labelText: 'Tex',
                                        rxString: labdipEntryController.rxTex,
                                        searchList: labdipEntryController
                                            .uniqueFilteredTexs,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: ' required field',
                                  style: TextStyle(
                                    color: VardhmanColors.darkGrey,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          SecondaryButton(
                            wait: false,
                            text: 'Clear Inputs',
                            onPressed: !labdipEntryController.canClearInputs
                                ? null
                                : () async {
                                    labdipEntryController.clearAllInputs();
                                  },
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Add Line',
                            onPressed: () async {
                              labdipEntryController.addLapdipOrderLine();
                            },
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Update',
                            onPressed: labdipEntryController
                                            .rxSelectedLabdipOrderLines
                                            .length ==
                                        1 &&
                                    labdipEntryController.canAddOrderLine
                                ? () async {
                                    labdipEntryController
                                        .updateLapdipOrderLine();
                                  }
                                : null,
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Delete',
                            onPressed: labdipEntryController
                                    .rxSelectedLabdipOrderLines.isEmpty
                                ? null
                                : () async {
                                    labdipEntryController.deleteSelectedLines();
                                  },
                          ),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: NewOrderTextField(
                              hasError: labdipEntryController.colorHasError,
                              labelText: 'Color Name',
                              rxString: labdipEntryController.rxColor,
                              isRequired: labdipEntryController.isSwatchShade,
                              isEnabled: labdipEntryController.isSwatchShade,
                            ),
                          ),
                          SizedBox(
                            width: 8,
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
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: NewOrderTextField(
                              labelText: 'A',
                              rxString: labdipEntryController.rxA,
                            ),
                          ),
                          SizedBox(
                            width: 8,
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
                        rxString: labdipEntryController.rxRemark,
                        hintText: 'Remark',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: DataTable2(
              columnSpacing: 16,
              showBottomBorder: true,
              border: TableBorder.symmetric(
                inside: BorderSide(color: VardhmanColors.darkGrey, width: 0.2),
                outside: BorderSide(color: VardhmanColors.darkGrey, width: 0.2),
              ),
              headingCheckboxTheme: CheckboxThemeData(
                fillColor: WidgetStatePropertyAll(Colors.white),
                checkColor: WidgetStatePropertyAll(VardhmanColors.red),
              ),
              datarowCheckboxTheme: CheckboxThemeData(
                fillColor: WidgetStatePropertyAll(Colors.white),
                checkColor: WidgetStatePropertyAll(VardhmanColors.red),
              ),
              dataTextStyle: TextStyle(
                color: VardhmanColors.darkGrey,
                fontSize: 13,
              ),
              checkboxHorizontalMargin: 0,
              headingRowHeight: 40,
              dataRowHeight: 40,
              headingRowColor: WidgetStatePropertyAll(VardhmanColors.darkGrey),
              headingTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              columns: const [
                DataColumn2(
                  label: Text('#'),
                  size: ColumnSize.S,
                  fixedWidth: 30,
                  numeric: true,
                ),
                DataColumn2(label: Text('Buyer'), size: ColumnSize.M),
                DataColumn2(
                  label: Text('Article'),
                  size: ColumnSize.S,
                  fixedWidth: 60,
                ),
                DataColumn2(
                  label: Text('Shade'),
                  size: ColumnSize.S,
                  fixedWidth: 60,
                ),
                DataColumn2(
                  label: Text('Brand'),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text('Ticket'),
                  numeric: true,
                  size: ColumnSize.S,
                  fixedWidth: 50,
                ),
                DataColumn2(
                  label: Text('Substrate'),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text('Tex'),
                  size: ColumnSize.S,
                  numeric: true,
                  fixedWidth: 40,
                ),
                DataColumn2(label: Text('Color'), size: ColumnSize.M),
                DataColumn2(label: Text('LAB'), size: ColumnSize.S),
                DataColumn2(label: Text('Remark'), size: ColumnSize.L),
              ],
              empty: Center(child: const Text('No Order Lines')),
              rows: labdipEntryController.rxLabdipOrderLines.map(
                (labdipOrderLine) {
                  final index = labdipEntryController.rxLabdipOrderLines
                      .indexOf(labdipOrderLine);

                  return DataRow(
                    color: index.isEven
                        ? WidgetStatePropertyAll(Colors.white)
                        : WidgetStatePropertyAll(VardhmanColors.dividerGrey),
                    selected: labdipEntryController.rxSelectedLabdipOrderLines
                        .contains(labdipOrderLine),
                    onSelectChanged: (_) {
                      labdipEntryController
                          .selectLabdipOrderLine(labdipOrderLine);
                    },
                    cells: [
                      DataCell(Text((index + 1).toString())),
                      DataCell(Text(labdipOrderLine.buyer)),
                      DataCell(Text(labdipOrderLine.article)),
                      DataCell(Text(labdipOrderLine.shade)),
                      DataCell(Text(labdipOrderLine.brand)),
                      DataCell(Text(labdipOrderLine.ticket)),
                      DataCell(Text(labdipOrderLine.substrate)),
                      DataCell(Text(labdipOrderLine.tex)),
                      DataCell(Text(labdipOrderLine.colorName)),
                      DataCell(Text(labdipOrderLine.lab)),
                      DataCell(Text(labdipOrderLine.remark)),
                    ],
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
