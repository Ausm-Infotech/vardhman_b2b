import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/api/invoice_info.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/label_row.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/rupee_text.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/open/advance_payment_dialog.dart';
import 'package:vardhman_b2b/open/invoice_review_view.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/open/open_invoices_list.dart';

class OpenInvoicesView extends StatelessWidget {
  const OpenInvoicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final invoicesController = Get.find<InvoicesController>();

    return Scaffold(
      backgroundColor: VardhmanColors.dividerGrey,
      body: DefaultTextStyle(
        style: const TextStyle(
          color: Colors.white,
        ),
        child: Obx(
          () => Column(
            children: <Widget>[
              HeaderView(
                leading: SecondaryButton(
                  iconData: FontAwesomeIcons.arrowRotateRight,
                  text: 'Refresh',
                  onPressed: invoicesController.refreshInvoices,
                ),
                title: RupeeText(
                  label: 'Net Outstanding',
                  amount: invoicesController.totalOpenAmount,
                ),
                // trailing: PrimaryButton(
                //   text: 'Pay',
                //   onPressed:
                //       invoicesController.rxSelectedInvoiceInfos.isEmpty ||
                //               invoicesController.selectedTotalAmount.isNegative
                //           ? null
                //           : () async {
                //               Get.to(() => const InvoiceReviewView());
                //             },
                // ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        color: VardhmanColors.dividerGrey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: invoicesController.openInvoices.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'No Open Invoices',
                              style: TextStyle(color: VardhmanColors.darkGrey),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            PrimaryButton(
                              text: 'Make Advance Payment',
                              onPressed: () async {
                                Get.dialog(const AdvancePaymentDialog());
                              },
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            const OpenInvoicesList(
                              invoicesDetails: [],
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    if (invoicesController
                                        .processingInvoices.isNotEmpty) ...[
                                      LabelRow(
                                        text: 'Processing Payment',
                                        color: getInvoiceStatusColor(
                                          InvoiceStatus.processing,
                                        ),
                                      ),
                                      OpenInvoicesList(
                                        showHeader: false,
                                        invoicesDetails: invoicesController
                                            .processingInvoices,
                                      ),
                                    ],
                                    if (invoicesController
                                        .creditNotes.isNotEmpty) ...[
                                      LabelRow(
                                        text: 'Credit Notes',
                                        color: getInvoiceStatusColor(
                                          InvoiceStatus.creditNote,
                                        ),
                                      ),
                                      OpenInvoicesList(
                                        showHeader: false,
                                        invoicesDetails:
                                            invoicesController.creditNotes,
                                      ),
                                    ],
                                    if (invoicesController
                                        .overdueInvoices.isNotEmpty) ...[
                                      LabelRow(
                                        text: 'Overdue Invoices',
                                        color: getInvoiceStatusColor(
                                          InvoiceStatus.overdue,
                                        ),
                                      ),
                                      OpenInvoicesList(
                                        showHeader: false,
                                        invoicesDetails:
                                            invoicesController.overdueInvoices,
                                      ),
                                    ],
                                    if (invoicesController
                                        .notDueInvoices.isNotEmpty) ...[
                                      LabelRow(
                                        text: 'Not Due Invoices',
                                        color: getInvoiceStatusColor(
                                            InvoiceStatus.notDue),
                                      ),
                                      OpenInvoicesList(
                                        showHeader: false,
                                        invoicesDetails:
                                            invoicesController.notDueInvoices,
                                      ),
                                    ],
                                    if (invoicesController
                                        .discountedInvoices.isNotEmpty) ...[
                                      LabelRow(
                                        text: 'Discounted Invoices',
                                        color: getInvoiceStatusColor(
                                            InvoiceStatus.discounted),
                                      ),
                                      OpenInvoicesList(
                                        showHeader: false,
                                        invoicesDetails: invoicesController
                                            .discountedInvoices,
                                      ),
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 16, right: 8, left: 8, bottom: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: invoicesController
                            .invoiceNumberTextEditingController,
                        onChanged: (String invoiceNumber) {
                          invoicesController.rxInvoiceNumberInput.value =
                              invoiceNumber;
                        },
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                          label: Text('Invoice No.'),
                          labelStyle: TextStyle(
                            color: VardhmanColors.darkGrey,
                            fontSize: 14,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: DateTimeField(
                        mode: DateTimeFieldPickerMode.date,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Invoices From',
                          border: const OutlineInputBorder(),
                          suffixIcon: Container(),
                          prefixText: DateFormat('d MMM yyyy').format(
                            invoicesController.rxInvoiceFromDate.value,
                          ),
                          prefixStyle: TextStyle(
                            color: invoicesController.rxInvoiceFromDate.value
                                    .isAtSameMomentAs(oldestDateTime)
                                ? Colors.white
                                : VardhmanColors.darkGrey,
                          ),
                        ),
                        dateFormat: DateFormat('d MMM yyyy'),
                        firstDate:
                            invoicesController.rxEarliestInvoiceDate.value,
                        lastDate: invoicesController.rxInvoiceToDate.value,
                        value: invoicesController.rxInvoiceFromDate.value,
                        onChanged: (DateTime? date) {
                          if (date != null) {
                            invoicesController.rxInvoiceFromDate.value = date;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: DateTimeField(
                        mode: DateTimeFieldPickerMode.date,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: 'Invoices Till',
                          border: const OutlineInputBorder(),
                          suffixIcon: Container(),
                          prefixText: DateFormat('d MMM yyyy').format(
                            invoicesController.rxInvoiceToDate.value,
                          ),
                          prefixStyle: const TextStyle(
                            color: VardhmanColors.darkGrey,
                          ),
                        ),
                        dateFormat: DateFormat('d MMM yyyy'),
                        firstDate: invoicesController.rxInvoiceFromDate.value,
                        lastDate: DateTime.now(),
                        value: invoicesController.rxInvoiceToDate.value,
                        initialPickerDateTime:
                            invoicesController.rxInvoiceToDate.value,
                        onChanged: (DateTime? date) {
                          if (date != null) {
                            invoicesController.rxInvoiceToDate.value = date;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    SecondaryButton(
                      text: '',
                      onPressed: invoicesController.hasFilters
                          ? null
                          : () async {
                              invoicesController.clearOpenFilters();
                            },
                      iconData: FontAwesomeIcons.arrowRotateLeft,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
