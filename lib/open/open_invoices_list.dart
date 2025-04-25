import 'dart:developer';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/invoice_info.dart';
import 'package:vardhman_b2b/common/rupee_text.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';

class OpenInvoicesList extends StatelessWidget {
  const OpenInvoicesList({
    super.key,
    required this.invoicesDetails,
    this.showHeader = true,
    this.canSelect = true,
    this.selectAllValue,
    this.onSelectAllChanged,
  });

  final bool showHeader, canSelect;

  final bool? selectAllValue;

  final void Function(bool?)? onSelectAllChanged;

  final List<InvoiceInfo> invoicesDetails;

  @override
  Widget build(BuildContext context) {
    final invoicesController = Get.find<InvoicesController>();

    return LayoutBuilder(
      builder: (context, constraints) {
        final tableWidth = constraints.maxWidth - 50;

        return DataTable(
          showCheckboxColumn: false,
          headingRowHeight: showHeader ? 40 : 0,
          dataRowMinHeight: 40,
          dataRowMaxHeight: 40,
          columnSpacing: 0,
          horizontalMargin: 0,
          dataTextStyle: const TextStyle(
            fontSize: 13,
            color: VardhmanColors.darkGrey,
          ),
          border: TableBorder.all(
            color: VardhmanColors.dividerGrey,
            width: 0.5,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          columns: [
            DataColumn(
              label: SizedBox(
                width: 50,
                child: !showHeader || onSelectAllChanged == null
                    ? null
                    : Checkbox(
                        tristate: true,
                        value: selectAllValue,
                        onChanged: onSelectAllChanged,
                        checkColor: VardhmanColors.darkGrey,
                        fillColor: WidgetStatePropertyAll(
                          Colors.white,
                        ),
                        side: WidgetStateBorderSide.resolveWith(
                          (states) => BorderSide(
                            color: VardhmanColors.darkGrey,
                            width: 1,
                          ),
                        ),
                      ),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: tableWidth * .25,
                child: const Text(
                  'Invoice No.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            DataColumn(
              label: Container(
                padding: const EdgeInsets.only(right: 4),
                width: tableWidth * .2,
                child: const Text(
                  'Created',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            DataColumn(
              label: Container(
                padding: const EdgeInsets.only(right: 4),
                width: tableWidth * .2,
                child: const Text(
                  'Due Date',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            DataColumn(
              label: Container(
                width: tableWidth * .35,
                padding: const EdgeInsets.only(right: 4),
                child: const Text(
                  'Amount',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
          rows: invoicesDetails.map(
            (invoiceInfo) {
              final isSelected = canSelect &&
                  invoicesController.rxSelectedInvoiceInfos
                      .contains(invoiceInfo);

              return DataRow(
                color: WidgetStatePropertyAll(
                  isSelected ? VardhmanColors.lightBlue : Colors.white,
                ),
                onSelectChanged: !canSelect
                    ? null
                    : (value) {
                        if (invoiceInfo.docType == 'RU') {
                          toastification.show(
                            autoCloseDuration: Duration(seconds: 3),
                            primaryColor: VardhmanColors.red,
                            title: Text(
                              'Unapplied reciept cannot be selected for payments',
                            ),
                          );
                        } else if (value ?? false) {
                          invoicesController.addInvoiceToSelected(invoiceInfo);
                        } else {
                          invoicesController
                              .removeInvoiceFromSelected(invoiceInfo);
                        }
                      },
                selected: isSelected,
                cells: [
                  DataCell(
                    SizedBox(
                      width: 50,
                      child: SecondaryButton(
                        text: '',
                        iconData: FontAwesomeIcons.filePdf,
                        onPressed: () async {
                          if (kIsWeb) {
                            final fileBytes = await Api.downloadInvoiceWeb(
                              invoiceNumber: invoiceInfo.invoiceNumber,
                              invoiceType: invoiceInfo.docType,
                            );

                            if (fileBytes != null) {
                              FileSaver.instance.saveFile(
                                name:
                                    '${invoiceInfo.invoiceNumber}_${invoiceInfo.docType}.pdf',
                                bytes: Uint8List.fromList(fileBytes),
                              );
                            } else {
                              toastification.show(
                                autoCloseDuration: Duration(seconds: 3),
                                primaryColor: VardhmanColors.red,
                                title: Text(
                                  'Invoice not found',
                                ),
                              );
                            }
                          } else {
                            final file = await Api.downloadInvoice(
                              invoiceNumber: invoiceInfo.invoiceNumber,
                              invoiceType: invoiceInfo.docType,
                            );

                            if (file != null) {
                              log('Invoice downloaded: $file');
                            } else {
                              toastification.show(
                                autoCloseDuration: Duration(seconds: 3),
                                primaryColor: VardhmanColors.red,
                                title: Text(
                                  'Invoice not found',
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  DataCell(
                    SizedBox(
                      width: tableWidth * .25,
                      child: Text(
                        "${invoiceInfo.invoiceNumber} ${invoiceInfo.docType}",
                        textAlign: TextAlign.center,
                        softWrap: false,
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.only(right: 4),
                      width: tableWidth * .2,
                      // color: Colors.deepOrange,
                      child: Text(
                        DateFormat('d MMM yy').format(invoiceInfo.date),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: VardhmanColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.only(right: 4),
                      width: tableWidth * .2,
                      child: invoiceInfo.status == InvoiceStatus.creditNote
                          ? null
                          : Text(
                              DateFormat('d MMM yy')
                                  .format(invoiceInfo.discountDueDate),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color:
                                    invoiceInfo.status == InvoiceStatus.overdue
                                        ? VardhmanColors.red
                                        : VardhmanColors.darkGrey,
                              ),
                            ),
                    ),
                  ),
                  DataCell(
                    Container(
                      width: tableWidth * .35,
                      padding: const EdgeInsets.only(right: 4),
                      child: Align(
                        alignment: Alignment.center,
                        child: RupeeText(
                          iconSize: 0,
                          fontSize: 13,
                          amount: invoiceInfo.openAmount,
                          discountAmount:
                              invoiceInfo.status == InvoiceStatus.discounted
                                  ? invoiceInfo.discountAmount
                                  : 0,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        );
      },
    );
  }
}
