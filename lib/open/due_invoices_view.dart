import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/invoice_info.dart';
import 'package:vardhman_b2b/common/label_row.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/open/open_invoices_list.dart';

class DueInvoicesView extends StatelessWidget {
  const DueInvoicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final invoicesController = Get.find<InvoicesController>();

    final selectedDueInvoices = invoicesController.dueInvoices
        .where((invoiceInfo) =>
            invoicesController.rxSelectedInvoiceInfos.contains(invoiceInfo))
        .toList();

    return Column(
      children: [
        OpenInvoicesList(
          invoicesDetails: [],
          selectAllValue: selectedDueInvoices.isEmpty
              ? false
              : selectedDueInvoices.length ==
                      invoicesController.dueInvoices.length
                  ? true
                  : null,
          onSelectAllChanged: (triStateBool) {
            if (selectedDueInvoices.length ==
                invoicesController.dueInvoices.length) {
              invoicesController.rxSelectedInvoiceInfos.removeWhere(
                (invoice) =>
                    invoice.status == InvoiceStatus.notDue ||
                    invoice.status == InvoiceStatus.discounted ||
                    invoice.status == InvoiceStatus.onHold,
              );
            } else {
              for (var invoiceInfo in invoicesController.dueInvoices) {
                if (!invoicesController.rxSelectedInvoiceInfos
                    .contains(invoiceInfo)) {
                  invoicesController.rxSelectedInvoiceInfos.add(invoiceInfo);
                }
              }
            }
          },
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (invoicesController.notDueInvoices.isNotEmpty)
                  OpenInvoicesList(
                    showHeader: false,
                    invoicesDetails: invoicesController.notDueInvoices,
                  ),
                if (invoicesController.discountedInvoices.isNotEmpty) ...[
                  LabelRow(
                    title: 'Discounted Invoices',
                    trailing:
                        '₹${invoicesController.totalDiscountedAmount.toStringAsFixed(2)}',
                    color: getInvoiceStatusColor(
                      InvoiceStatus.discounted,
                    ),
                  ),
                  OpenInvoicesList(
                    showHeader: false,
                    invoicesDetails: invoicesController.discountedInvoices,
                  ),
                ],
                if (invoicesController.heldInvoices.isNotEmpty) ...[
                  LabelRow(
                    title: 'Other Invoices',
                    trailing:
                        '₹${invoicesController.totalHeldAmount.toStringAsFixed(2)}',
                    color: getInvoiceStatusColor(
                      InvoiceStatus.onHold,
                    ),
                  ),
                  OpenInvoicesList(
                    showHeader: false,
                    invoicesDetails: invoicesController.heldInvoices,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
