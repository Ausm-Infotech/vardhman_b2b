import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/new_order_date_field.dart';
import 'package:vardhman_b2b/common/order_detail_cell.dart';
import 'package:vardhman_b2b/common/order_detail_column_label.dart';
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
                Spacer(),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: NewOrderTextField(
                              inputFormatters: [capitalFormatter],
                              labelText: 'PO Number',
                              isRequired: true,
                              hasError: dtmEntryController.poNumberHasError,
                              rxString: dtmEntryController.rxPoNumber,
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            flex: 2,
                            child: NewOrderTextField(
                              isEnabled: false,
                              labelText: 'Upload PO Document',
                              rxString: dtmEntryController.rxPoFileName,
                              hintText: 'no file chosen',
                              trailingWidget: dtmEntryController
                                      .rxPoFileName.isEmpty
                                  ? SecondaryButton(
                                      wait: false,
                                      text: 'Choose File',
                                      onPressed: () async {
                                        final FilePickerResult?
                                            filePickerResult =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['pdf', 'xlsx'],
                                          withData: true,
                                          readSequential: true,
                                        );

                                        if (filePickerResult != null) {
                                          final file =
                                              filePickerResult.files.single;

                                          dtmEntryController
                                              .rxPoFileName.value = file.name;

                                          dtmEntryController
                                              .rxPoFileBytes.value = file.bytes;
                                        }
                                      },
                                    )
                                  : SecondaryButton(
                                      wait: false,
                                      iconData: Icons.clear,
                                      text: '',
                                      onPressed: () async {
                                        dtmEntryController.rxPoFileName.value =
                                            '';

                                        dtmEntryController.rxPoFileBytes.value =
                                            null;
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                      CatalogSearchField(
                        isRequired: true,
                        labelText: 'Merchandiser',
                        rxString: dtmEntryController.rxMerchandiser,
                        searchList: dtmEntryController.rxMerchandisers,
                        shouldEnforceList: false,
                        hasError: dtmEntryController.merchandiserHasError,
                        inputFormatters: [capitalFormatter],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CatalogSearchField(
                              hasError: dtmEntryController.buyerNameHasError,
                              labelText: 'Buyer',
                              isRequired: true,
                              rxString: dtmEntryController.rxBuyerName,
                              searchList: dtmEntryController.buyerNames,
                              inputFormatters: [capitalFormatter],
                            ),
                          ),
                          if (dtmEntryController.isOtherBuyer) ...[
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: NewOrderTextField(
                                inputFormatters: [capitalFormatter],
                                hasError:
                                    dtmEntryController.otherBuyerNameHasError,
                                labelText: 'Name',
                                isRequired: true,
                                rxString: dtmEntryController.rxOtherBuyerName,
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
                              hasError:
                                  dtmEntryController.firstLightSourceHasError,
                              isRequired: true,
                              isEnabled:
                                  dtmEntryController.isLightSource1Enabled,
                              labelText: 'Light Source 1',
                              rxString: dtmEntryController.rxFirstLightSource,
                              searchList: dtmEntryController.firstLightSources,
                              inputFormatters: [capitalFormatter],
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: CatalogSearchField(
                              isSearchboxEnabled: false,
                              isEnabled:
                                  dtmEntryController.isLightSource2Enabled,
                              labelText: 'Light Source 2',
                              rxString: dtmEntryController.rxSecondLightSource,
                              searchList: dtmEntryController.secondLightSources,
                              inputFormatters: [capitalFormatter],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                          Spacer(),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: CatalogSearchField(
                                        hasError:
                                            dtmEntryController.articleHasError,
                                        labelText: 'Article',
                                        isRequired: true,
                                        rxString: dtmEntryController.rxArticle,
                                        searchList: dtmEntryController
                                            .uniqueFilteredArticles,
                                        inputFormatters: [capitalFormatter],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
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
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        isEnabled: false,
                                        labelText: 'Ticket',
                                        rxString: dtmEntryController.rxTicket,
                                        searchList: [],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        labelText: 'Brand',
                                        rxString: dtmEntryController.rxBrand,
                                        searchList: [],
                                        isEnabled: false,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        labelText: 'Tex',
                                        isEnabled: false,
                                        rxString: dtmEntryController.rxTex,
                                        searchList: [],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        isEnabled: false,
                                        labelText: 'Substrate',
                                        rxString:
                                            dtmEntryController.rxSubstrate,
                                        searchList: [],
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
                                        inputFormatters: [capitalFormatter],
                                        hasError:
                                            dtmEntryController.shadeHasError,
                                        labelText: 'Shade',
                                        isRequired: true,
                                        isEnabled: dtmEntryController
                                                .rxArticle.isNotEmpty &&
                                            dtmEntryController.rxUom.isNotEmpty,
                                        rxString: dtmEntryController.rxShade,
                                        searchList: dtmEntryController.rxShades,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: NewOrderTextField(
                                        inputFormatters: [capitalFormatter],
                                        hasError:
                                            dtmEntryController.colorHasError,
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
                                        isRequired: true,
                                        maxLength: 10,
                                        rxString: dtmEntryController.rxQuantity,
                                        hasError:
                                            dtmEntryController.quantityHasError,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'^[1-9]\d*'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: NewOrderDateField(
                                        labelText: 'Requested Date',
                                        rxDate:
                                            dtmEntryController.rxRequestedDate,
                                        hintText: 'select',
                                      ),
                                    ),
                                  ],
                                ),
                                NewOrderTextField(
                                  inputFormatters: [capitalFormatter],
                                  labelText: 'Remark',
                                  rxString: dtmEntryController.rxRemark,
                                  hintText: 'Enter Remark',
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
                          Spacer(),
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

                                    dtmEntryController.rxSelectedDtmOrderLines
                                        .clear();
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
              ],
            ),
          ),
          Expanded(
            child: DataTable2(
              minWidth: 1600,
              columnSpacing: 0,
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
              horizontalMargin: 16,
              headingRowHeight: 60,
              dataRowHeight: 60,
              headingRowColor: WidgetStatePropertyAll(VardhmanColors.darkGrey),
              headingTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              columns: const [
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: '#'),
                  fixedWidth: 50,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Merchandiser'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Buyer'),
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Article'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'UOM'),
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Ticket'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Brand'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Tex'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Substrate'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Shade'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Style/Part No.'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Quantity'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Requested Date'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'Remark'),
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
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
                        : WidgetStatePropertyAll(
                            VardhmanColors.dividerGrey.withAlpha(128)),
                    selected: dtmEntryController.dtmOrderLinesDescending
                        .contains(dtmOrderLine),
                    onSelectChanged: (_) {
                      dtmEntryController.selectDtmOrderLine(dtmOrderLine);
                    },
                    cells: [
                      DataCell(
                        OrderDetailCell(
                          cellText: (index + 1).toString(),
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.merchandiser,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.buyer,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.article,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: "${dtmOrderLine.uom} - $uomDesc",
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.ticket,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.brand,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.tex,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.substrate,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.shade,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.colorName,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.quantity.toString(),
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.requestedDate == null
                              ? ''
                              : DateFormat('d MMM yyyy')
                                  .format(dtmOrderLine.requestedDate!),
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: dtmOrderLine.remark,
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
