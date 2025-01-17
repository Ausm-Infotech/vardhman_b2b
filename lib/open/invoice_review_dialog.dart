import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/invoice_info.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/rupee_text.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/open/pay2corp_view.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class InvoiceReviewDialog extends StatelessWidget {
  const InvoiceReviewDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final invoicesController = Get.find<InvoicesController>();

    final UserController userController = Get.find<UserController>(
      tag: 'userController',
    );

    return Dialog(
      child: Obx(
        () => Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('You are about to initiate a payment of '),
              SizedBox(
                height: 8,
              ),
              RupeeText(
                amount: invoicesController.selectedDiscountedAmount,
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: PrimaryButton(
                  iconData: Icons.done_outlined,
                  text: 'Proceed',
                  onPressed: () async {
                    final batchNumber = await Api.fetchPaymentBatchNumber();

                    if (batchNumber != null) {
                      final receiptNumber = 'M$batchNumber';

                      final paymentEntryCreated =
                          await Api.createInvoicePaymentEntry(
                        paymentDetails: invoicesController
                            .rxSelectedInvoiceInfos
                            .map(
                              (invoiceInfo) => {
                                "Batch_Number": batchNumber,
                                "Company": invoiceInfo.company,
                                "Source_Mobile_Portal": "M",
                                "Customer_Number": invoiceInfo.customerNumber,
                                "Invoice_Number": invoiceInfo.invoiceNumber,
                                "Invoice_Type": invoiceInfo.docType,
                                "Invoice_Company": invoiceInfo.company,
                                "Receipt_Number": receiptNumber,
                                "Payment_Amount": invoiceInfo.status ==
                                        InvoiceStatus.discounted
                                    ? invoiceInfo.discountAmount.toString()
                                    : invoiceInfo.openAmount.toString(),
                                "Payment_Reference": "",
                                "Payment_Remark": "",
                                "Bank_Account": "",
                                "Payment_Date": DateFormat('MM/dd/yyyy')
                                    .format(DateTime.now()),
                              },
                            )
                            .toList(),
                      );

                      if (paymentEntryCreated) {
                        bool paymentSuccessful = false;

                        String walletTxnStatus = '',
                            walletBankRefId = '',
                            walletTxnRemarks = '';

                        if (invoicesController.selectedDiscountedAmount == 0) {
                          paymentSuccessful = true;
                        } else {
                          final encryptedString = await Api.encryptInputString(
                            'txn-id=$receiptNumber|txn-datetime=${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now())}|txn-amount=${invoicesController.selectedDiscountedAmount}|txn-for=payment|wallet-payment-mode=2|return-url=https://www.vardhmanthreads.com/|cancel-url=https://www.vardhmanthreads.com/|',
                          );

                          log('Encrypted String: $encryptedString');

                          if (encryptedString != null) {
                            paymentSuccessful = await Get.to<bool>(
                                  () => Pay2corpView(
                                    walletRequestMessage: encryptedString,
                                  ),
                                ) ??
                                false;
                          }

                          final paymentStatus =
                              await Api.getPaymentStatus(receiptNumber);

                          if (paymentStatus != null) {
                            walletTxnStatus =
                                RegExp(r'wallet-txn-status=([^|]+)')
                                        .firstMatch(paymentStatus)
                                        ?.group(1) ??
                                    '';

                            walletBankRefId =
                                RegExp(r'wallet-bank-ref-id=([^|]+)')
                                        .firstMatch(paymentStatus)
                                        ?.group(1) ??
                                    '';

                            walletTxnRemarks =
                                RegExp(r'wallet-txn-remarks=([^|]+)')
                                        .firstMatch(paymentStatus)
                                        ?.group(1) ??
                                    '';

                            paymentSuccessful = walletTxnStatus == '100';
                          }
                        }

                        await Api.updateInvoicePaymentRequest(
                          batchNumber: batchNumber,
                          receiptNumber: receiptNumber,
                          company:
                              userController.rxCustomerDetail.value.companyCode,
                          customerNumber: userController
                              .rxCustomerDetail.value.soldToNumber,
                          sp: paymentSuccessful
                              ? ''
                              : walletTxnStatus == '106'
                                  ? 'I'
                                  : 'E',
                          paymentReference: walletBankRefId,
                          paymentRemark: walletTxnRemarks,
                        );

                        Get.back();

                        if (paymentSuccessful) {
                          invoicesController.refreshInvoices();

                          invoicesController.rxSelectedInvoiceInfos.clear();

                          Get.back();

                          Get.snackbar(
                            'Payment was successful',
                            '',
                            backgroundColor: Colors.white,
                            colorText: VardhmanColors.green,
                          );
                        } else if (walletTxnStatus == '106') {
                          Get.snackbar(
                            'Awaiting payment',
                            '',
                            backgroundColor: Colors.white,
                            colorText: VardhmanColors.orange,
                          );
                        } else {
                          Get.snackbar(
                            'Payment failed',
                            '',
                            backgroundColor: Colors.white,
                            colorText: VardhmanColors.red,
                          );
                        }
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
