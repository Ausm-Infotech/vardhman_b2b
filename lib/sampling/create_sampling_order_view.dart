import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/order_detail_cell.dart';
import 'package:vardhman_b2b/common/order_detail_column_label.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/common/catalog_search_field.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/sampling/sampling_entry_controller.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';

class CreateSamplingOrderView extends StatelessWidget {
  const CreateSamplingOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final samplingEntryController = Get.find<SamplingEntryController>();

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
              'New Sampling Order',
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
                onPressed: samplingEntryController.rxSamplingOrderLines.isEmpty
                    ? null
                    : samplingEntryController.submitOrder,
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
                                      samplingEntryController.rxMerchandiser,
                                  searchList:
                                      samplingEntryController.rxMerchandisers,
                                  shouldEnforceList: false,
                                  hasError: samplingEntryController
                                      .merchandiserHasError,
                                  inputFormatters: [capitalFormatter],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        hasError: samplingEntryController
                                            .buyerNameHasError,
                                        labelText: 'Buyer',
                                        isRequired: true,
                                        rxString:
                                            samplingEntryController.rxBuyerName,
                                        searchList:
                                            samplingEntryController.buyerNames,
                                      ),
                                    ),
                                    if (samplingEntryController
                                        .isOtherBuyer) ...[
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: NewOrderTextField(
                                          inputFormatters: [capitalFormatter],
                                          hasError: samplingEntryController
                                              .otherBuyerNameHasError,
                                          labelText: 'Name',
                                          isRequired: true,
                                          rxString: samplingEntryController
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
                                        inputFormatters: [capitalFormatter],
                                        isSearchboxEnabled: false,
                                        hasError: samplingEntryController
                                            .firstLightSourceHasError,
                                        isRequired: true,
                                        isEnabled: samplingEntryController
                                            .isLightSource1Enabled,
                                        labelText: 'Light Source 1',
                                        rxString: samplingEntryController
                                            .rxFirstLightSource,
                                        searchList: samplingEntryController
                                            .firstLightSources,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        isSearchboxEnabled: false,
                                        isEnabled: samplingEntryController
                                            .isLightSource2Enabled,
                                        labelText: 'Light Source 2',
                                        rxString: samplingEntryController
                                            .rxSecondLightSource,
                                        searchList: samplingEntryController
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
                                      flex: 2,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        hasError: samplingEntryController
                                            .articleHasError,
                                        labelText: 'Article',
                                        isRequired: true,
                                        rxString:
                                            samplingEntryController.rxArticle,
                                        searchList: samplingEntryController
                                            .uniqueFilteredArticles,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        isRequired: true,
                                        hasError:
                                            samplingEntryController.uomHasError,
                                        labelText: 'UOM',
                                        rxString: samplingEntryController
                                            .rxUomWithDesc,
                                        searchList: samplingEntryController
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
                                        rxString:
                                            samplingEntryController.rxTicket,
                                        searchList: samplingEntryController
                                            .uniqueFilteredTickets,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        labelText: 'Brand',
                                        rxString:
                                            samplingEntryController.rxBrand,
                                        searchList: samplingEntryController
                                            .uniqueFilteredBrands,
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
                                        rxString: samplingEntryController.rxTex,
                                        searchList: samplingEntryController
                                            .uniqueFilteredTexs,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        labelText: 'Substrate',
                                        rxString:
                                            samplingEntryController.rxSubstrate,
                                        searchList: samplingEntryController
                                            .uniqueFilteredSubstrates,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
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
                            onPressed: !samplingEntryController.canClearInputs
                                ? null
                                : () async {
                                    samplingEntryController.clearAllInputs();

                                    samplingEntryController
                                        .rxSelectedSamplingOrderLines
                                        .clear();
                                  },
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Add Line',
                            onPressed: samplingEntryController
                                    .rxSelectedSamplingOrderLines.isNotEmpty
                                ? null
                                : () async {
                                    samplingEntryController
                                        .addLapdipOrderLine();
                                  },
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Update',
                            onPressed: samplingEntryController
                                        .rxSelectedSamplingOrderLines.length ==
                                    1
                                ? () async {
                                    samplingEntryController
                                        .updateLapdipOrderLine();
                                  }
                                : null,
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Delete',
                            onPressed: samplingEntryController
                                    .rxSelectedSamplingOrderLines.isEmpty
                                ? null
                                : () async {
                                    samplingEntryController
                                        .deleteSelectedLines();
                                  },
                          ),
                          Spacer(),
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
                              hasError: samplingEntryController.shadeHasError,
                              labelText: 'Shade',
                              isRequired: true,
                              isEnabled: samplingEntryController
                                      .rxArticle.isNotEmpty &&
                                  samplingEntryController.rxUom.isNotEmpty,
                              rxString: samplingEntryController.rxShade,
                              searchList: samplingEntryController.rxShades,
                              shouldEnforceList: false,
                              invalidList: samplingEntryController.skipShades,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: NewOrderTextField(
                              inputFormatters: [capitalFormatter],
                              hasError: samplingEntryController.colorHasError,
                              labelText: 'Color Name',
                              rxString: samplingEntryController.rxColor,
                              isRequired: samplingEntryController.isSwatchShade,
                              isEnabled: samplingEntryController.isSwatchShade,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: NewOrderTextField(
                              labelText: 'L',
                              rxString: samplingEntryController.rxL,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^-?\d*\.?\d*'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: NewOrderTextField(
                              labelText: 'A',
                              hasError: samplingEntryController.rxAHasError,
                              isEnabled: samplingEntryController.rxL.isNotEmpty,
                              isRequired:
                                  samplingEntryController.rxL.isNotEmpty,
                              rxString: samplingEntryController.rxA,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^-?\d*\.?\d*'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: NewOrderTextField(
                              labelText: 'B',
                              hasError: samplingEntryController.rxBHasError,
                              isEnabled: samplingEntryController.rxA.isNotEmpty,
                              isRequired:
                                  samplingEntryController.rxA.isNotEmpty,
                              rxString: samplingEntryController.rxB,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^-?\d*\.?\d*'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: NewOrderTextField(
                              isEnabled: false,
                              labelText: 'File Upload (QTX/XML Files Only)',
                              rxString: samplingEntryController.rxFileName,
                              hintText: 'no file chosen',
                              trailingWidget: samplingEntryController
                                      .rxFileName.isEmpty
                                  ? SecondaryButton(
                                      wait: false,
                                      text: 'Choose File',
                                      onPressed: () async {
                                        final FilePickerResult?
                                            filePickerResult =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['qtx', 'xml'],
                                          withData: true,
                                          readSequential: true,
                                        );

                                        if (filePickerResult != null) {
                                          final file =
                                              filePickerResult.files.single;

                                          samplingEntryController
                                              .rxFileName.value = file.name;

                                          samplingEntryController
                                              .rxFileBytes.value = file.bytes;
                                        }
                                      },
                                    )
                                  : SecondaryButton(
                                      wait: false,
                                      iconData: Icons.clear,
                                      text: '',
                                      onPressed: () async {
                                        samplingEntryController
                                            .rxFileName.value = '';

                                        samplingEntryController
                                            .rxFileBytes.value = null;
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                      NewOrderTextField(
                        labelText: 'Remark',
                        inputFormatters: [capitalFormatter],
                        rxString: samplingEntryController.rxRemark,
                        hintText: 'Mention Request Type, End Use....etc',
                      ),
                    ],
                  ),
                ),
                Spacer(),
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
                    headingRowAlignment: MainAxisAlignment.end),
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
                  label: OrderDetailColumnLabel(labelText: 'Color'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'LAB'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(labelText: 'QTX/XML File'),
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
              rows: samplingEntryController.samplingOrderLinesDescending.map(
                (samplingOrderLine) {
                  final index = samplingEntryController.rxSamplingOrderLines
                      .indexOf(samplingOrderLine);

                  final uomDesc = orderReviewController
                      .getUomDescription(samplingOrderLine.uom);

                  return DataRow(
                    color: index.isEven
                        ? WidgetStatePropertyAll(Colors.white)
                        : WidgetStatePropertyAll(
                            VardhmanColors.dividerGrey.withAlpha(128)),
                    selected: samplingEntryController
                        .rxSelectedSamplingOrderLines
                        .contains(samplingOrderLine),
                    onSelectChanged: (_) {
                      samplingEntryController
                          .selectSamplingOrderLine(samplingOrderLine);
                    },
                    cells: [
                      DataCell(
                        OrderDetailCell(
                          cellText: (index + 1).toString(),
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.merchandiser,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.buyer,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.article,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: "${samplingOrderLine.uom} - $uomDesc",
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.ticket,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.brand,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.tex,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.substrate,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.shade,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.colorName,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.lab,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.qtxFileName,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: samplingOrderLine.remark,
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
