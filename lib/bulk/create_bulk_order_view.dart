import 'package:data_table_2/data_table_2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/new_order_date_field.dart';
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
              'New Bulk Order : ${bulkEntryController.b2bOrderNumber}',
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
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                            (oldValue, newValue) {
                              return newValue.copyWith(
                                text: newValue.text.toUpperCase(),
                              );
                            },
                          ),
                        ],
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
                                inputFormatters: [
                                  TextInputFormatter.withFunction(
                                    (oldValue, newValue) {
                                      return newValue.copyWith(
                                        text: newValue.text.toUpperCase(),
                                      );
                                    },
                                  ),
                                ],
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
                                        isEnabled: false,
                                        labelText: 'Ticket',
                                        rxString: bulkEntryController.rxTicket,
                                        searchList: bulkEntryController
                                            .uniqueFilteredTickets,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: CatalogSearchField(
                                        labelText: 'Brand',
                                        rxString: bulkEntryController.rxBrand,
                                        searchList: bulkEntryController
                                            .uniqueFilteredBrands,
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
                                        labelText: 'Tex',
                                        isEnabled: false,
                                        rxString: bulkEntryController.rxTex,
                                        searchList: bulkEntryController
                                            .uniqueFilteredTexs,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: CatalogSearchField(
                                        isEnabled: false,
                                        labelText: 'Substrate',
                                        rxString:
                                            bulkEntryController.rxSubstrate,
                                        searchList: bulkEntryController
                                            .uniqueFilteredSubstrates,
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
                                            bulkEntryController.shadeHasError,
                                        labelText: 'Shade',
                                        isRequired: true,
                                        isEnabled: bulkEntryController
                                            .rxArticle.isNotEmpty,
                                        rxString: bulkEntryController.rxShade,
                                        searchList:
                                            bulkEntryController.rxShades,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: NewOrderTextField(
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
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('PO Number'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Merchandiser'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Buyer'),
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Article'),
                  size: ColumnSize.S,
                  fixedWidth: 80,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('UOM'),
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Shade'),
                  size: ColumnSize.S,
                  fixedWidth: 80,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Style/Part No.'),
                  size: ColumnSize.M,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Unit Price'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Quantity'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Total Price'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Remark'),
                  size: ColumnSize.L,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
                DataColumn2(
                  label: Text('Req Date'),
                  size: ColumnSize.S,
                  headingRowAlignment: MainAxisAlignment.end,
                ),
              ],
              empty: Center(child: const Text('No Order Lines')),
              rows: bulkEntryController.rxBulkOrderLines.map(
                (bulkOrderLine) {
                  final index = bulkEntryController.rxBulkOrderLines
                      .indexOf(bulkOrderLine);

                  final uomDesc = orderReviewController
                      .getUomDescription(bulkOrderLine.uom);

                  return DataRow(
                    color: index.isEven
                        ? WidgetStatePropertyAll(Colors.white)
                        : WidgetStatePropertyAll(VardhmanColors.dividerGrey),
                    selected: bulkEntryController.rxSelectedBulkOrderLines
                        .contains(bulkOrderLine),
                    onSelectChanged: (_) {
                      bulkEntryController.selectBulkOrderLine(bulkOrderLine);
                    },
                    cells: [
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text((index + 1).toString()),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(bulkOrderLine.poNumber),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(bulkOrderLine.merchandiser),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(bulkOrderLine.buyer),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(bulkOrderLine.article),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text("${bulkOrderLine.uom} - $uomDesc"),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(bulkOrderLine.shade),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(bulkOrderLine.colorName),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child:
                              Text(bulkOrderLine.unitPrice?.toString() ?? ''),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(bulkOrderLine.quantity.toString()),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            (bulkOrderLine.quantity *
                                    (bulkOrderLine.unitPrice ?? 0))
                                .toString(),
                          ),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(bulkOrderLine.remark),
                        ),
                      ),
                      DataCell(
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            bulkOrderLine.requestedDate == null
                                ? ''
                                : DateFormat('d MMM yyyy')
                                    .format(bulkOrderLine.requestedDate!),
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
