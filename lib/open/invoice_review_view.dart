import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/invoice_info.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/rupee_text.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/open/invoice_review_dialog.dart';
import 'package:vardhman_b2b/open/open_invoices_list.dart';

class InvoiceReviewView extends StatelessWidget {
  const InvoiceReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final invoicesController = Get.find<InvoicesController>();

    return Obx(
      () => Scaffold(
        backgroundColor: VardhmanColors.dividerGrey,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              HeaderView(
                leading: invoicesController.rxSelectedInvoiceInfos.isEmpty
                    ? null
                    : SecondaryButton(
                        iconData: Icons.close,
                        text: 'Clear',
                        onPressed: () async {
                          invoicesController.rxSelectedInvoiceInfos.clear();
                        },
                        wait: false,
                      ),
                title: RupeeText(
                  label: 'Total',
                  amount: invoicesController.selectedTotalAmount,
                  discountAmount: invoicesController.selectedDiscountedAmount ==
                          invoicesController.selectedTotalAmount
                      ? 0
                      : invoicesController.selectedDiscountedAmount,
                ),
                trailing: PrimaryButton(
                  text: 'Pay',
                  onPressed: invoicesController
                              .rxSelectedInvoiceInfos.isEmpty ||
                          invoicesController.selectedDiscountedAmount.isNegative
                      ? null
                      : () async {
                          final hasSelectedAllNotDue =
                              invoicesController.notDueInvoices.every(
                            (invoiceInfo) => invoicesController
                                .rxSelectedInvoiceInfos
                                .contains(invoiceInfo),
                          );

                          final hasSelectedAllOverdue =
                              invoicesController.overdueInvoices.every(
                            (invoiceInfo) => invoicesController
                                .rxSelectedInvoiceInfos
                                .contains(invoiceInfo),
                          );

                          if (!hasSelectedAllOverdue &&
                              invoicesController.rxSelectedInvoiceInfos.any(
                                  (invoiceInfo) =>
                                      invoiceInfo.status ==
                                          InvoiceStatus.notDue ||
                                      invoiceInfo.status ==
                                          InvoiceStatus.discounted)) {
                            toastification.show(
                              primaryColor: VardhmanColors.red,
                              title: Text(
                                'Please select all overdue invoices to proceed.',
                              ),
                            );

                            return;
                          } else if (!hasSelectedAllNotDue &&
                              invoicesController.rxSelectedInvoiceInfos.any(
                                (invoiceInfo) =>
                                    invoiceInfo.status ==
                                    InvoiceStatus.discounted,
                              )) {
                            toastification.show(
                              primaryColor: VardhmanColors.red,
                              title: Text(
                                'Please select all not due invoices to proceed.',
                              ),
                            );

                            return;
                          }

                          Get.dialog(
                            const InvoiceReviewDialog(),
                          );
                        },
                ),
              ),
              Expanded(
                child: invoicesController.rxSelectedInvoiceInfos.isEmpty
                    ? Center(
                        child: Text('No Invoices Selected'),
                      )
                    : Column(
                        children: [
                          const OpenInvoicesList(
                            invoicesDetails: [],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: OpenInvoicesList(
                                showHeader: false,
                                canSelect: false,
                                invoicesDetails:
                                    invoicesController.rxSelectedInvoiceInfos,
                              ),
                            ),
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
