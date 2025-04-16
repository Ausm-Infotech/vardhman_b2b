import 'package:flutter/material.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/open/invoice_review_view.dart';
import 'package:vardhman_b2b/open/open_invoices_view.dart';

class OpenView extends StatelessWidget {
  const OpenView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(child: OpenInvoicesView()),
          VerticalDivider(
            thickness: 8,
            color: VardhmanColors.darkGrey,
            width: 8,
          ),
          Expanded(child: InvoiceReviewView()),
        ],
      ),
    );
  }
}
