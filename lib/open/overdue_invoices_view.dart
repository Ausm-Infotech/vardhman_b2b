import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/invoice_info.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/open/open_invoices_list.dart';

class OverdueInvoicesView extends StatelessWidget {
  const OverdueInvoicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final invoicesController = Get.find<InvoicesController>();

    final selectedOverdueInvoices = invoicesController.rxSelectedInvoiceInfos
        .where((invoice) => invoice.status == InvoiceStatus.overdue)
        .toList();

    return Column(
      children: [
        OpenInvoicesList(
          invoicesDetails: [],
          selectAllValue: selectedOverdueInvoices.isEmpty
              ? false
              : selectedOverdueInvoices.length ==
                      invoicesController.overdueInvoices.length
                  ? true
                  : null,
          onSelectAllChanged: (triStateBool) {
            if (selectedOverdueInvoices.length ==
                invoicesController.overdueInvoices.length) {
              invoicesController.rxSelectedInvoiceInfos.removeWhere(
                (invoice) => invoice.status == InvoiceStatus.overdue,
              );
            } else {
              for (var invoiceInfo in invoicesController.overdueInvoices) {
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
                OpenInvoicesList(
                  showHeader: false,
                  invoicesDetails: invoicesController.overdueInvoices,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
