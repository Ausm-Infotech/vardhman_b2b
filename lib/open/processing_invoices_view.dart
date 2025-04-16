import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/open/open_invoices_list.dart';

class ProcessingInvoicesView extends StatelessWidget {
  const ProcessingInvoicesView({super.key});

  @override
  Widget build(BuildContext context) {
    final invoicesController = Get.find<InvoicesController>();

    return Column(
      children: [
        const OpenInvoicesList(
          invoicesDetails: [],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                OpenInvoicesList(
                  canSelect: false,
                  showHeader: false,
                  invoicesDetails: invoicesController.processingInvoices,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
