import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
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
import 'package:vardhman_b2b/bulk/bulk_entry_controller.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';

class CreateBulkOrderView extends StatelessWidget {
  const CreateBulkOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final bulkEntryController = Get.find<BulkEntryController>();

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
              'New Bulk Order',
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
                onPressed: bulkEntryController.rxBulkOrderLines.isEmpty
                    ? null
                    : () async {
                        Get.dialog(
                          AlertDialog(
                            title: Text('Vardhman B2B Terms and Conditions'),
                            content: Text(
                                'By submitting you agree to our Terms and Conditions'),
                            actions: <Widget>[
                              SecondaryButton(
                                text: 'Cancel',
                                onPressed: () async {
                                  Get.back();
                                },
                              ),
                              PrimaryButton(
                                text: 'Submit',
                                onPressed: () async {
                                  await bulkEntryController.submitOrder();

                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        );
                      },
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
                              isRequired: true,
                              hasError: bulkEntryController.poNumberHasError,
                              labelText: 'PO Number',
                              minLines: 1,
                              rxString: bulkEntryController.rxPoNumber,
                              inputFormatters: [capitalFormatter],
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
                              rxString: bulkEntryController.rxPoFileName,
                              hintText: 'no file chosen',
                              trailingWidget: bulkEntryController
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

                                          bulkEntryController
                                              .rxPoFileName.value = file.name;

                                          bulkEntryController
                                              .rxPoFileBytes.value = file.bytes;
                                        }
                                      },
                                    )
                                  : SecondaryButton(
                                      wait: false,
                                      iconData: Icons.clear,
                                      text: '',
                                      onPressed: () async {
                                        bulkEntryController.rxPoFileName.value =
                                            '';

                                        bulkEntryController
                                            .rxPoFileBytes.value = null;
                                      },
                                    ),
                            ),
                          ),
                        ],
                      ),
                      CatalogSearchField(
                        isRequired: true,
                        labelText: 'Merchandiser',
                        rxString: bulkEntryController.rxMerchandiser,
                        searchList: bulkEntryController.rxMerchandisers,
                        shouldEnforceList: false,
                        hasError: bulkEntryController.merchandiserHasError,
                        inputFormatters: [capitalFormatter],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: CatalogSearchField(
                              hasError: bulkEntryController.buyerNameHasError,
                              labelText: 'Buyer',
                              isRequired: true,
                              rxString: bulkEntryController.rxBuyerName,
                              searchList: bulkEntryController.buyerNames,
                              inputFormatters: [capitalFormatter],
                            ),
                          ),
                          if (bulkEntryController.isOtherBuyer) ...[
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: NewOrderTextField(
                                hasError:
                                    bulkEntryController.otherBuyerNameHasError,
                                labelText: 'Name',
                                isRequired: true,
                                rxString: bulkEntryController.rxOtherBuyerName,
                                inputFormatters: [capitalFormatter],
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
                                  bulkEntryController.firstLightSourceHasError,
                              isRequired: true,
                              isEnabled:
                                  bulkEntryController.isLightSource1Enabled,
                              labelText: 'Light Source 1',
                              rxString: bulkEntryController.rxFirstLightSource,
                              searchList: bulkEntryController.firstLightSources,
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
                                  bulkEntryController.isLightSource2Enabled,
                              labelText: 'Light Source 2',
                              rxString: bulkEntryController.rxSecondLightSource,
                              searchList:
                                  bulkEntryController.secondLightSources,
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
                                        inputFormatters: [capitalFormatter],
                                        hasError:
                                            bulkEntryController.articleHasError,
                                        labelText: 'Article',
                                        isRequired: true,
                                        rxString: bulkEntryController.rxArticle,
                                        searchList: bulkEntryController
                                            .uniqueFilteredArticles,
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
                                            bulkEntryController.uomHasError,
                                        labelText: 'UOM',
                                        rxString:
                                            bulkEntryController.rxUomWithDesc,
                                        searchList: bulkEntryController
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
                                        rxString: bulkEntryController.rxTicket,
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
                                        rxString: bulkEntryController.rxBrand,
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
                                        rxString: bulkEntryController.rxTex,
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
                                            bulkEntryController.rxSubstrate,
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
                                            bulkEntryController.shadeHasError,
                                        labelText: 'Shade',
                                        isRequired: true,
                                        isEnabled: bulkEntryController
                                                .rxArticle.isNotEmpty &&
                                            bulkEntryController
                                                .rxUom.isNotEmpty,
                                        rxString: bulkEntryController.rxShade,
                                        searchList:
                                            bulkEntryController.rxShades,
                                        shouldEnforceList: false,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: NewOrderTextField(
                                        inputFormatters: [capitalFormatter],
                                        labelText: 'Style No./Part No.',
                                        rxString: bulkEntryController.rxColor,
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
                                        rxString:
                                            bulkEntryController.rxQuantity,
                                        hasError: bulkEntryController
                                            .quantityHasError,
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
                                            bulkEntryController.rxRequestedDate,
                                        hintText: 'select',
                                      ),
                                    ),
                                  ],
                                ),
                                NewOrderTextField(
                                  labelText: 'Unit Price',
                                  isEnabled: false,
                                  rxString: bulkEntryController.rxUnitPrice,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          SecondaryButton(
                            wait: false,
                            text: 'Clear Inputs',
                            onPressed: !bulkEntryController.canClearInputs
                                ? null
                                : () async {
                                    bulkEntryController.clearAllInputs();

                                    bulkEntryController.rxSelectedBulkOrderLines
                                        .clear();
                                  },
                          ),
                          PrimaryButton(
                            text: 'Add Line',
                            onPressed: bulkEntryController
                                    .rxSelectedBulkOrderLines.isNotEmpty
                                ? null
                                : () async {
                                    bulkEntryController.addBulkOrderLine();
                                  },
                          ),
                          PrimaryButton(
                            text: 'Update',
                            onPressed: bulkEntryController
                                        .rxSelectedBulkOrderLines.length ==
                                    1
                                ? () async {
                                    bulkEntryController.updateBulkOrderLine();
                                  }
                                : null,
                          ),
                          PrimaryButton(
                            text: 'Delete',
                            onPressed: bulkEntryController
                                    .rxSelectedBulkOrderLines.isEmpty
                                ? null
                                : () async {
                                    bulkEntryController.deleteSelectedLines();
                                  },
                          ),
                          SecondaryButton(
                            text: 'Sample Excel',
                            onPressed: () async {
                              final ByteData data = await rootBundle
                                  .load('assets/bulk_import.xlsx');

                              final Uint8List bytes = data.buffer.asUint8List();

                              await FileSaver.instance.saveFile(
                                name: 'bulk_import',
                                bytes: bytes,
                                ext: 'xlsx',
                                mimeType: MimeType.microsoftExcel,
                              );
                            },
                          ),
                          SecondaryButton(
                            text: 'Import Excel',
                            onPressed: bulkEntryController.importExcel,
                          ),
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
                  size: ColumnSize.S,
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
                  label: OrderDetailColumnLabel(labelText: 'Unit Price'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: OrderDetailColumnLabel(
                      labelText: 'Total Pre-GST\nAmount in INR'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
              ],
              empty: Center(child: const Text('No Order Lines')),
              rows: bulkEntryController.bulkOrderLinesDescending.map(
                (bulkOrderLine) {
                  final index = bulkEntryController.rxBulkOrderLines
                      .indexOf(bulkOrderLine);

                  final uomDesc = orderReviewController
                      .getUomDescription(bulkOrderLine.uom);

                  final totalPrice =
                      bulkOrderLine.quantity * (bulkOrderLine.unitPrice ?? 0);

                  return DataRow(
                    color: index.isEven
                        ? WidgetStatePropertyAll(Colors.white)
                        : WidgetStatePropertyAll(
                            VardhmanColors.dividerGrey.withAlpha(128)),
                    selected: bulkEntryController.rxSelectedBulkOrderLines
                        .contains(bulkOrderLine),
                    onSelectChanged: (_) {
                      bulkEntryController.selectBulkOrderLine(bulkOrderLine);
                    },
                    cells: [
                      DataCell(
                        OrderDetailCell(
                          cellText: (index + 1).toString(),
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.merchandiser,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.buyer,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.article,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: "${bulkOrderLine.uom} - $uomDesc",
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.ticket,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.brand,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.tex,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.substrate,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.shade,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.colorName,
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.quantity.toString(),
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: bulkOrderLine.requestedDate == null
                              ? ''
                              : DateFormat('d MMM yyyy')
                                  .format(bulkOrderLine.requestedDate!),
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText:
                              bulkOrderLine.unitPrice?.toStringAsFixed(2) ?? '',
                        ),
                      ),
                      DataCell(
                        OrderDetailCell(
                          cellText: totalPrice > 0
                              ? totalPrice.toStringAsFixed(2)
                              : '',
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
