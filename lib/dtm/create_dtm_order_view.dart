import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/new_order_date_field.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/common/catalog_search_field.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/dtm/dtm_entry_controller.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';

class CreateDtmOrderView extends StatelessWidget {
  const CreateDtmOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final dtmEntryController = Get.find<DtmEntryController>();

    final OrderReviewController orderReviewController =
        Get.find<OrderReviewController>();

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
              'New DTM Order : ${dtmEntryController.b2bOrderNumber}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            trailing: DefaultTextStyle(
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              child: PrimaryButton(
                text: 'Submit Order',
                onPressed: dtmEntryController.rxDtmOrderLines.isEmpty
                    ? null
                    : dtmEntryController.submitOrder,
              ),
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
                                  rxString: dtmEntryController.rxMerchandiser,
                                  searchList:
                                      dtmEntryController.rxMerchandisers,
                                  shouldEnforceList: false,
                                  hasError:
                                      dtmEntryController.merchandiserHasError,
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: CatalogSearchField(
                                        hasError: dtmEntryController
                                            .buyerNameHasError,
                                        labelText: 'Buyer',
                                        isRequired: true,
                                        rxString:
                                            dtmEntryController.rxBuyerName,
                                        searchList:
                                            dtmEntryController.buyerNames,
                                      ),
                                    ),
                                    if (dtmEntryController.isOtherBuyer) ...[
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: NewOrderTextField(
                                          hasError: dtmEntryController
                                              .otherBuyerNameHasError,
                                          labelText: 'Name',
                                          isRequired: true,
                                          rxString: dtmEntryController
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
                                        isSearchboxEnabled: false,
                                        hasError: dtmEntryController
                                            .firstLightSourceHasError,
                                        isRequired: true,
                                        isEnabled: dtmEntryController
                                            .isLightSource1Enabled,
                                        labelText: 'Light Source 1',
                                        rxString: dtmEntryController
                                            .rxFirstLightSource,
                                        searchList: dtmEntryController
                                            .firstLightSources,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: CatalogSearchField(
                                        isSearchboxEnabled: false,
                                        isEnabled: dtmEntryController
                                            .isLightSource2Enabled,
                                        labelText: 'Light Source 2',
                                        rxString: dtmEntryController
                                            .rxSecondLightSource,
                                        searchList: dtmEntryController
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
                                        hasError:
                                            dtmEntryController.articleHasError,
                                        labelText: 'Article',
                                        isRequired: true,
                                        rxString: dtmEntryController.rxArticle,
                                        searchList: dtmEntryController
                                            .uniqueFilteredArticles,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: CatalogSearchField(
                                        isRequired: true,
                                        hasError:
                                            dtmEntryController.uomHasError,
                                        labelText: 'UOM',
                                        rxString:
                                            dtmEntryController.rxUomWithDesc,
                                        searchList: dtmEntryController
                                            .uniqueFilteredUoms
                                            .map(
                                          (uom) {
                                            return '$uom - ${orderReviewController.getUomDescription(uom)}';
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                if (dtmEntryController
                                    .rxArticle.isNotEmpty) ...[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: CatalogSearchField(
                                          labelText: 'Brand',
                                          rxString: dtmEntryController.rxBrand,
                                          searchList: dtmEntryController
                                              .uniqueFilteredBrands,
                                          isEnabled: false,
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
                                          rxString: dtmEntryController.rxTicket,
                                          searchList: dtmEntryController
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
                                          isEnabled: false,
                                          labelText: 'Substrate',
                                          rxString:
                                              dtmEntryController.rxSubstrate,
                                          searchList: dtmEntryController
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
                                          isEnabled: false,
                                          rxString: dtmEntryController.rxTex,
                                          searchList: dtmEntryController
                                              .uniqueFilteredTexs,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
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
                            onPressed: !dtmEntryController.canClearInputs
                                ? null
                                : () async {
                                    dtmEntryController.clearAllInputs();
                                  },
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Add Line',
                            onPressed: dtmEntryController
                                    .rxSelectedDtmOrderLines.isNotEmpty
                                ? null
                                : () async {
                                    dtmEntryController.addDtmOrderLine();
                                  },
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Update',
                            onPressed: dtmEntryController
                                        .rxSelectedDtmOrderLines.length ==
                                    1
                                ? () async {
                                    dtmEntryController.updateDtmOrderLine();
                                  }
                                : null,
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Delete',
                            onPressed: dtmEntryController
                                    .rxSelectedDtmOrderLines.isEmpty
                                ? null
                                : () async {
                                    dtmEntryController.deleteSelectedLines();
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
                            child: CatalogSearchField(
                              hasError: dtmEntryController.shadeHasError,
                              labelText: 'Shade',
                              isRequired: true,
                              isEnabled:
                                  dtmEntryController.rxArticle.isNotEmpty,
                              rxString: dtmEntryController.rxShade,
                              searchList: dtmEntryController.rxShades,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: NewOrderTextField(
                              hasError: dtmEntryController.colorHasError,
                              labelText: 'Color Name',
                              rxString: dtmEntryController.rxColor,
                              isRequired: true,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: NewOrderTextField(
                              labelText: 'Quantity',
                              rxString: dtmEntryController.rxQuantity,
                              hasError: dtmEntryController.quantityHasError,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: NewOrderDateField(
                              labelText: 'Requested Date',
                              rxDate: dtmEntryController.rxRequestedDate,
                              hintText: 'select',
                            ),
                          ),
                        ],
                      ),
                      NewOrderTextField(
                        labelText: 'Remark',
                        rxString: dtmEntryController.rxRemark,
                        hintText: 'enter remark',
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
                  label: Text('UOM'),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text('Shade'),
                  size: ColumnSize.S,
                  fixedWidth: 60,
                ),
                DataColumn2(label: Text('Color'), size: ColumnSize.M),
                DataColumn2(label: Text('Quantity'), size: ColumnSize.S),
                DataColumn2(label: Text('Remark'), size: ColumnSize.L),
                DataColumn2(label: Text('Req Date'), size: ColumnSize.S),
              ],
              empty: Center(child: const Text('No Order Lines')),
              rows: dtmEntryController.rxDtmOrderLines.map(
                (dtmOrderLine) {
                  final index =
                      dtmEntryController.rxDtmOrderLines.indexOf(dtmOrderLine);

                  final uomDesc =
                      orderReviewController.getUomDescription(dtmOrderLine.uom);

                  return DataRow(
                    color: index.isEven
                        ? WidgetStatePropertyAll(Colors.white)
                        : WidgetStatePropertyAll(VardhmanColors.dividerGrey),
                    selected: dtmEntryController.rxSelectedDtmOrderLines
                        .contains(dtmOrderLine),
                    onSelectChanged: (_) {
                      dtmEntryController.selectDtmOrderLine(dtmOrderLine);
                    },
                    cells: [
                      DataCell(Text((index + 1).toString())),
                      DataCell(Text(dtmOrderLine.buyer)),
                      DataCell(Text(dtmOrderLine.article)),
                      DataCell(Text("${dtmOrderLine.uom} - $uomDesc")),
                      DataCell(Text(dtmOrderLine.shade)),
                      DataCell(Text(dtmOrderLine.colorName)),
                      DataCell(Text(dtmOrderLine.quantity.toString())),
                      DataCell(Text(dtmOrderLine.remark)),
                      DataCell(
                        Text(
                          dtmOrderLine.requestedDate == null
                              ? ''
                              : DateFormat('d MMM yyyy')
                                  .format(dtmOrderLine.requestedDate!),
                        ),
                      ),
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
