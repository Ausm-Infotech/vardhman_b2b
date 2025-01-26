import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/rupee_text.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/open/invoice_review_dialog.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
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
                title: Text(
                  '${invoicesController.rxSelectedInvoiceInfos.length} invoice${invoicesController.rxSelectedInvoiceInfos.length > 1 ? 's' : ''} selected',
                  textAlign: TextAlign.center,
                ),
                trailing: PrimaryButton(
                  text: 'Pay',
                  onPressed:
                      invoicesController.rxSelectedInvoiceInfos.isEmpty ||
                              invoicesController.selectedDiscountedAmount < 0
                          ? null
                          : () async {
                              Get.dialog(
                                const InvoiceReviewDialog(),
                              );
                            },
                ),
              ),
              Expanded(
                child: Column(
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
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: VardhmanColors.dividerGrey,
                    ),
                  ),
                ),
                child: RupeeText(
                  label: 'Total',
                  amount: invoicesController.selectedTotalAmount,
                  discountAmount: invoicesController.selectedDiscountedAmount ==
                          invoicesController.selectedTotalAmount
                      ? 0
                      : invoicesController.selectedDiscountedAmount,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
