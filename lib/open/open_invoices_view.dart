import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/rupee_text.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/open/advance_payment_dialog.dart';
import 'package:vardhman_b2b/open/due_invoices_view.dart';
import 'package:vardhman_b2b/open/overdue_invoices_view.dart';
import 'package:vardhman_b2b/open/processing_invoices_view.dart';

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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RupeeText(
                      label: 'Net Overdue',
                      amount: invoicesController.totalOverdueAmount,
                    ),
                    RupeeText(
                      label: 'Net Outstanding',
                      amount: invoicesController.totalOpenAmount,
                    ),
                  ],
                ),
                trailing: Text(
                  '${invoicesController.rxSelectedInvoiceInfos.length} invoice${invoicesController.rxSelectedInvoiceInfos.length > 1 ? 's' : ''} selected',
                  textAlign: TextAlign.center,
                ),
              ),
              invoicesController.openInvoices.isEmpty
                  ? Container()
                  : Material(
                      elevation: 4,
                      child: Container(
                        color: Colors.white,
                        child: TabBar(
                          controller: invoicesController.tabController,
                          tabs: [
                            Tab(
                              text: 'Overdue',
                            ),
                            Tab(
                              text: 'Due',
                            ),
                            Tab(
                              text: 'Payment Processing',
                            ),
                          ],
                        ),
                      ),
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
                      : TabBarView(
                          controller: invoicesController.tabController,
                          children: [
                            invoicesController.overdueInvoices.isNotEmpty
                                ? OverdueInvoicesView()
                                : Center(
                                    child: Text(
                                      'No overdue invoices',
                                      style: const TextStyle(
                                        color: VardhmanColors.darkGrey,
                                      ),
                                    ),
                                  ),
                            invoicesController.dueInvoices.isNotEmpty
                                ? DueInvoicesView()
                                : Center(
                                    child: Text(
                                      'No due invoices',
                                      style: const TextStyle(
                                        color: VardhmanColors.darkGrey,
                                      ),
                                    ),
                                  ),
                            invoicesController.processingInvoices.isNotEmpty
                                ? ProcessingInvoicesView()
                                : Center(
                                    child: Text(
                                      'No invoices in processing',
                                      style: const TextStyle(
                                        color: VardhmanColors.darkGrey,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 16,
                  right: 8,
                  left: 8,
                  bottom: 8,
                ),
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
                    Flexible(
                      child: TextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (String numberOfDays) {
                          final int? days = int.tryParse(numberOfDays);

                          if (days != null) {
                            invoicesController.rxInvoiceToDate.value =
                                DateTime.now().subtract(Duration(days: days));
                          } else {
                            invoicesController.rxInvoiceToDate.value =
                                DateTime.now();
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          isDense: true,
                          label: Text('Invoices Older Than (days)'),
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
