import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/invoices/invoices_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class AdvancePaymentDialog extends StatelessWidget {
  const AdvancePaymentDialog({
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
                height: 24,
              ),
              TextField(
                controller: invoicesController.advancePaymentInputController,
                onChanged: (value) {
                  invoicesController.rxAdvancePaymentAmount.value =
                      double.tryParse(value) ?? 0;
                },
                decoration: const InputDecoration(
                  isDense: true,
                  label: Text(
                    'Amount',
                  ),
                  hintText: 'Enter the advance payment amount',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: PrimaryButton(
                  iconData: Icons.done_outlined,
                  text: 'Proceed',
                  onPressed: invoicesController.rxAdvancePaymentAmount.value < 1
                      ? null
                      : () async {
                          final batchNumber =
                              await Api.fetchPaymentBatchNumber();

                          if (batchNumber != null) {
                            final receiptNumber = 'M$batchNumber';

                            final paymentEntryCreated =
                                await Api.createInvoicePaymentEntry(
                              paymentDetails: [
                                {
                                  "Batch_Number": batchNumber,
                                  "Company": userController
                                      .rxCustomerDetail.value.companyCode,
                                  "Source_Mobile_Portal": "B",
                                  "Customer_Number": userController
                                      .rxCustomerDetail.value.soldToNumber,
                                  "Receipt_Number": receiptNumber,
                                  "Payment_Amount": invoicesController
                                      .rxAdvancePaymentAmount.value,
                                  "Payment_Date": DateFormat('MM/dd/yyyy')
                                      .format(DateTime.now()),
                                },
                              ],
                            );

                            if (paymentEntryCreated) {
                              bool paymentSuccessful = false;

                              String walletTxnStatus = '',
                                  walletBankRefId = '',
                                  walletTxnRemarks = '';

                              var encryptedString =
                                  await Api.encryptInputString(
                                'txn-id=$receiptNumber|txn-datetime=${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now())}|txn-amount=${invoicesController.rxAdvancePaymentAmount.value}|txn-for=payment|wallet-payment-mode=2|return-url=https://www.vardhmanthreads.com|cancel-url=https://www.vardhmanthreads.com|',
                              );

                              log('Encrypted payment string: $encryptedString');

                              // if (encryptedString != null) {
                              //   paymentSuccessful = await Get.to<bool>(
                              //         () => Pay2corpView(
                              //           walletRequestMessage: encryptedString,
                              //         ),
                              //       ) ??
                              //       false;
                              // }

                              // final paymentStatus =
                              //     await Api.getPaymentStatus(receiptNumber);

                              // if (paymentStatus != null) {
                              //   walletTxnStatus =
                              //       RegExp(r'wallet-txn-status=([^|]+)')
                              //               .firstMatch(paymentStatus)
                              //               ?.group(1) ??
                              //           '';

                              //   walletBankRefId =
                              //       RegExp(r'wallet-bank-ref-id=([^|]+)')
                              //               .firstMatch(paymentStatus)
                              //               ?.group(1) ??
                              //           '';

                              //   walletTxnRemarks =
                              //       RegExp(r'wallet-txn-remarks=([^|]+)')
                              //               .firstMatch(paymentStatus)
                              //               ?.group(1) ??
                              //           '';

                              //   paymentSuccessful = walletTxnStatus == '100';
                              // }

                              // await Api.updateInvoicePaymentRequest(
                              //   batchNumber: batchNumber,
                              //   receiptNumber: receiptNumber,
                              //   company: userController
                              //       .rxCustomerDetail.value.companyCode,
                              //   customerNumber: userController
                              //       .rxCustomerDetail.value.soldToNumber,
                              //   sp: paymentSuccessful
                              //       ? ''
                              //       : walletTxnStatus == '106'
                              //           ? 'I'
                              //           : 'E',
                              //   paymentReference: walletBankRefId,
                              //   paymentRemark: walletTxnRemarks,
                              // );

                              // Get.back();

                              // if (paymentSuccessful) {
                              //   invoicesController.refreshInvoices();

                              //   invoicesController.rxSelectedInvoiceInfos
                              //       .clear();

                              //   Get.back();

                              //   Get.snackbar(
                              //     'Payment was successful',
                              //     '',
                              //     backgroundColor: Colors.white,
                              //     colorText: VardhmanColors.green,
                              //   );
                              // } else if (walletTxnStatus == '106') {
                              //   Get.snackbar(
                              //     'Awaiting payment',
                              //     '',
                              //     backgroundColor: Colors.white,
                              //     colorText: VardhmanColors.orange,
                              //   );
                              // } else {
                              //   Get.snackbar(
                              //     'Payment failed',
                              //     '',
                              //     backgroundColor: Colors.white,
                              //     colorText: VardhmanColors.red,
                              //   );
                              // }
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
