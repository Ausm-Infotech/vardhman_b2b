@JS()
library stringify;

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
import 'package:vardhman_b2b/user/user_controller.dart';
import 'package:js/js.dart';
import 'dart:html' as html;
import 'package:web/web.dart' as web;

@JS('JSON.stringify')
external String stringify(Object obj);

@JS('alert')
external void alert(String message);

@JS('open')
external void open(String url, String target);

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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('You are about to initiate a payment of '),
              const SizedBox(
                height: 8,
              ),
              RupeeText(
                amount: invoicesController.selectedDiscountedAmount,
              ),
              const SizedBox(
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
                          final plainText =
                              'txn-id=$receiptNumber|txn-datetime=${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now())}|txn-amount=${invoicesController.selectedDiscountedAmount}|txn-for=payment|wallet-payment-mode=2|return-url=http://localhost:8000|cancel-url=http://localhost:8000|';

                          // const encryptedString =
                          //     'FhpljUfUCmCkqJ2ezhpH0TtvgIjbrg6vTP88k30RN+pAm9kdBlX2yxCuIvCP+3RNaVmCSJhc13RAoBFz1Bm5U5SzMps/DaNNkpURTPnzd2KJC4HnlmFmwK2FyQXIznnPBzFYst/4zot/RfDmKMEvMrC+socWc/T4WoW7sLsv0B6gaHmgDlTY3A3SrHOAlpfBYjHgWBVb2d3sdtEnZqNEwYequd0alFGbV0eyTzzGPf7wMLGeoI96M5b6al4VOL0E0jkX0i0iDjadS1+JM0EH6JbU8FywO1fjy2eWCIUGMKYZXg4H9Y0p/g93Zuo5ZgfeG5lsLRbGsbgzkQoIKhyxqLXuCoSavK7H+8VZwdTvTcj7cglajB36pGFDikDSjTxlUbLVlMYIyMCarxrg1BOaUyB5JlC+cwQd6LevjC3ZQq80k7pwnjCasu6hszAEvExzVmT20HPXYQTMS8mWutkPbMEggzP48mozW2DgyoS2f7NBSusxtxwqw0SBxs+cwd2g3SEpirrafxD9pJwdREXdEOJKrzOOrBXnaGq5xMMsDWU69rcHkYbWzwlrXECW7Q37OsAhDLQE+y05Oqq+LzKIdjN2/eOHWE5EBqiJ7wtw5hSsgISpYM3Tpsupwub/l1mQgp7Nd5NsY1baBbd+1nC7iN/Sj9lm84GQ8Kl7f+CfZjo=';
                          final encryptedString =
                              await Api.encryptInputString(plainText);

                          log('Encrypted String: $encryptedString');

                          if (encryptedString != null) {
                            final paymentFormElement =
                                web.document.createElement('form')
                                  ..setAttribute('id', 'paymentForm')
                                  ..setAttribute('method', "POST")
                                  ..setAttribute('action',
                                      "https://demo.b2biz.co.in/ws/payment")
                                  ..setAttribute('target', '_self');

                            final walletClientCodeInput =
                                web.document.createElement('input')
                                  ..setAttribute('type', 'text')
                                  ..setAttribute('name', 'walletClientCode')
                                  ..setAttribute('value', 'WT-1474');

                            paymentFormElement
                                .appendChild(walletClientCodeInput);

                            final walletRequestMessageInput =
                                web.document.createElement('input')
                                  ..setAttribute('type', 'text')
                                  ..setAttribute('name', 'walletRequestMessage')
                                  ..setAttribute(
                                    'value',
                                    encryptedString,
                                  );

                            paymentFormElement
                                .appendChild(walletRequestMessageInput);

                            // final submitButton =
                            //     web.document.createElement('button')
                            //       ..setAttribute('type', 'submit')
                            //       ..text = 'Submit';

                            // paymentFormElement.appendChild(submitButton);

                            final paymentForm = web.document.body
                                    ?.appendChild(paymentFormElement)
                                as html.FormElement;

                            paymentForm.submit();
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
