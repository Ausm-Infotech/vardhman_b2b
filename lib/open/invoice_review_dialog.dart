import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/invoice_info.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/rupee_text.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';
import 'package:universal_html/html.dart' as html;

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
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
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
                      final receiptNumber = 'P$batchNumber';

                      final paymentEntryCreated =
                          await Api.createInvoicePaymentEntry(
                        paymentDetails: invoicesController
                            .rxSelectedInvoiceInfos
                            .map(
                              (invoiceInfo) => {
                                "Batch_Number": batchNumber,
                                "Company": invoiceInfo.company,
                                "Source_Mobile_Portal": "P",
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
                        if (invoicesController.selectedDiscountedAmount == 0) {
                          await Api.updateInvoicePaymentRequest(
                            batchNumber: batchNumber,
                            receiptNumber: receiptNumber,
                            company: userController
                                .rxCustomerDetail.value.companyCode,
                            customerNumber: userController
                                .rxCustomerDetail.value.soldToNumber,
                            sp: '',
                            paymentReference: '',
                            paymentRemark: '',
                          );
                        } else {
                          final plainText =
                              'txn-id=$receiptNumber|txn-datetime=${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now())}|txn-amount=${invoicesController.selectedDiscountedAmount.toStringAsFixed(2)}|txn-for=payment|wallet-payment-mode=2|return-url=https://www.vardhmanthreads.com|cancel-url=https://www.vardhmanthreads.com|';

                          final encryptedString =
                              await Api.encryptInputString(plainText);

                          log('Encrypted String: $encryptedString');

                          if (encryptedString != null) {
                            // for PD
                            // final paymentFormElement = html.document
                            //     .createElement('form')
                            //   ..setAttribute('id', 'paymentForm')
                            //   ..setAttribute('method', "POST")
                            //   ..setAttribute(
                            //       'action', "https://b2biz.co.in/ws/payment")
                            //   ..setAttribute('target', '_self');

                            // final walletClientCodeInput =
                            //     html.document.createElement('input')
                            //       ..setAttribute('type', 'text')
                            //       ..setAttribute('name', 'walletClientCode')
                            //       ..setAttribute('value', 'WT-1573');
                            // for PD

                            // for PY
                            final paymentFormElement =
                                html.document.createElement('form')
                                  ..setAttribute('id', 'paymentForm')
                                  ..setAttribute('method', "POST")
                                  ..setAttribute('action',
                                      "https://generic.ipay2corpuat.icicibank.com/gp2c-api/ws/payment")
                                  ..setAttribute('target', '_self');

                            final walletClientCodeInput =
                                html.document.createElement('input')
                                  ..setAttribute('type', 'text')
                                  ..setAttribute('name', 'walletClientCode')
                                  ..setAttribute('value', 'WT-1474');
                            // for PY

                            paymentFormElement.append(walletClientCodeInput);

                            final walletRequestMessageInput =
                                html.document.createElement('input')
                                  ..setAttribute('type', 'text')
                                  ..setAttribute('name', 'walletRequestMessage')
                                  ..setAttribute(
                                    'value',
                                    encryptedString,
                                  );

                            paymentFormElement
                                .append(walletRequestMessageInput);

                            final paymentForm =
                                html.document.body?.append(paymentFormElement)
                                    as html.FormElement;

                            paymentForm.submit();
                          }
                        }

                        Get.back();

                        Get.back();

                        toastification.show(
                          autoCloseDuration: Duration(seconds: 3),
                          primaryColor: VardhmanColors.green,
                          title: Text(
                            'Navigating to Payment Gateway, payment confirmation will be sent via E-mail/SMS in some time. ',
                          ),
                        );

                        return;
                      }
                    }

                    toastification.show(
                      autoCloseDuration: Duration(seconds: 3),
                      primaryColor: VardhmanColors.red,
                      title: Text(
                        'Some error initiating payment, please try later.',
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                  'Payment confirmation will be sent via E-mail/SMS in some time.'),
            ],
          ),
        ),
      ),
    );
  }
}
