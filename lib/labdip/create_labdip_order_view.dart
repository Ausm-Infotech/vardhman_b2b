import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/common/catalog_search_field.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/labdip/labdip_entry_controller.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';

class CreateLabdipOrderView extends StatelessWidget {
  const CreateLabdipOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final labdipEntryController = Get.find<LabdipEntryController>();

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
              'New Labdip Order : ${labdipEntryController.b2bOrderNumber}',
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
                onPressed: labdipEntryController.rxLabdipOrderLines.isEmpty
                    ? null
                    : labdipEntryController.submitOrder,
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
                                      labdipEntryController.rxMerchandiser,
                                  searchList:
                                      labdipEntryController.rxMerchandisers,
                                  shouldEnforceList: false,
                                  hasError: labdipEntryController
                                      .merchandiserHasError,
                                  inputFormatters: [capitalFormatter],
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
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
                                          inputFormatters: [capitalFormatter],
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
                                        inputFormatters: [capitalFormatter],
                                        isSearchboxEnabled: false,
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
                                        inputFormatters: [capitalFormatter],
                                        isSearchboxEnabled: false,
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
                                      flex: 2,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
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
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        isRequired: true,
                                        hasError:
                                            labdipEntryController.uomHasError,
                                        labelText: 'UOM',
                                        rxString:
                                            labdipEntryController.rxUomWithDesc,
                                        searchList: labdipEntryController
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
                                            labdipEntryController.rxTicket,
                                        searchList: labdipEntryController
                                            .uniqueFilteredTickets,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 3,
                                      child: CatalogSearchField(
                                        inputFormatters: [capitalFormatter],
                                        labelText: 'Brand',
                                        rxString: labdipEntryController.rxBrand,
                                        searchList: labdipEntryController
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
                                        rxString: labdipEntryController.rxTex,
                                        searchList: labdipEntryController
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
                                            labdipEntryController.rxSubstrate,
                                        searchList: labdipEntryController
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
                            onPressed: !labdipEntryController.canClearInputs
                                ? null
                                : () async {
                                    labdipEntryController.clearAllInputs();

                                    labdipEntryController
                                        .rxSelectedLabdipOrderLines
                                        .clear();
                                  },
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Add Line',
                            onPressed: labdipEntryController
                                    .rxSelectedLabdipOrderLines.isNotEmpty
                                ? null
                                : () async {
                                    labdipEntryController.addLapdipOrderLine();
                                  },
                          ),
                          Spacer(),
                          PrimaryButton(
                            text: 'Update',
                            onPressed: labdipEntryController
                                        .rxSelectedLabdipOrderLines.length ==
                                    1
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
                              hasError: labdipEntryController.shadeHasError,
                              labelText: 'Shade',
                              isRequired: true,
                              isEnabled:
                                  labdipEntryController.rxArticle.isNotEmpty &&
                                      labdipEntryController.rxUom.isNotEmpty,
                              rxString: labdipEntryController.rxShade,
                              searchList: labdipEntryController.rxShades,
                              shouldEnforceList: false,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: NewOrderTextField(
                              inputFormatters: [capitalFormatter],
                              hasError: labdipEntryController.colorHasError,
                              labelText: 'Color Name',
                              rxString: labdipEntryController.rxColor,
                              isRequired: labdipEntryController.isSwatchShade,
                              isEnabled: labdipEntryController.isSwatchShade,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: NewOrderTextField(
                              labelText: 'L',
                              rxString: labdipEntryController.rxL,
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
                              hasError: labdipEntryController.rxAHasError,
                              isEnabled: labdipEntryController.rxL.isNotEmpty,
                              isRequired: labdipEntryController.rxL.isNotEmpty,
                              rxString: labdipEntryController.rxA,
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
                              hasError: labdipEntryController.rxBHasError,
                              isEnabled: labdipEntryController.rxA.isNotEmpty,
                              isRequired: labdipEntryController.rxA.isNotEmpty,
                              rxString: labdipEntryController.rxB,
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
                              rxString: labdipEntryController.rxFileName,
                              hintText: 'no file chosen',
                              trailingWidget: labdipEntryController
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

                                          labdipEntryController
                                              .rxFileName.value = file.name;

                                          labdipEntryController
                                              .rxFileBytes.value = file.bytes;
                                        }
                                      },
                                    )
                                  : SecondaryButton(
                                      wait: false,
                                      iconData: Icons.clear,
                                      text: '',
                                      onPressed: () async {
                                        labdipEntryController.rxFileName.value =
                                            '';

                                        labdipEntryController
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
                        rxString: labdipEntryController.rxRemark,
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
                    fixedWidth: 50,
                    headingRowAlignment: MainAxisAlignment.end),
                DataColumn2(
                  label: Text('Merchandiser'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Buyer'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Article'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('UOM'),
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Ticket'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Brand'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Tex'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Substrate'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Shade'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Color'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('LAB'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('QTX/XML File'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Remark'),
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
              ],
              empty: Center(child: const Text('No Order Lines')),
              rows: labdipEntryController.rxLabdipOrderLines.map(
                (labdipOrderLine) {
                  final index = labdipEntryController.rxLabdipOrderLines
                      .indexOf(labdipOrderLine);

                  final uomDesc = orderReviewController
                      .getUomDescription(labdipOrderLine.uom);

                  return DataRow(
                    color: index.isEven
                        ? WidgetStatePropertyAll(Colors.white)
                        : WidgetStatePropertyAll(
                            VardhmanColors.dividerGrey.withAlpha(128)),
                    selected: labdipEntryController.rxSelectedLabdipOrderLines
                        .contains(labdipOrderLine),
                    onSelectChanged: (_) {
                      labdipEntryController
                          .selectLabdipOrderLine(labdipOrderLine);
                    },
                    cells: [
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            (index + 1).toString(),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.merchandiser,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.buyer,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.article,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${labdipOrderLine.uom} - $uomDesc",
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.ticket,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.brand,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.tex,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.substrate,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.shade,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.colorName,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.lab,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.qtxFileName,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            labdipOrderLine.remark,
                            textAlign: TextAlign.end,
                          ),
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
