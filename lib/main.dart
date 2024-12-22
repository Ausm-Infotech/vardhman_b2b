import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/dashboard/dashboard_view.dart';
import 'package:vardhman_b2b/dtm/dtm_orders_view.dart';
import 'package:vardhman_b2b/invoices/paid_invoices_view.dart';
import 'package:vardhman_b2b/invoices/pending_invoices_view.dart';
import 'package:vardhman_b2b/labdip/labdip_orders_view.dart';
import 'package:vardhman_b2b/sample_data.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int mainViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/home_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/digital-nws.png',
                        width: 240,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Text(
                          'Dashboard',
                          style: TextStyle(
                            color: mainViewIndex == 0
                                ? VardhmanColors.red
                                : VardhmanColors.darkGrey,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            mainViewIndex = 0;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('ORDERS'),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Text(
                          'Labdip',
                          style: TextStyle(
                            color: mainViewIndex == 1
                                ? VardhmanColors.red
                                : VardhmanColors.darkGrey,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            mainViewIndex = 1;
                          });
                        },
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Text(
                          'DTM',
                          style: TextStyle(
                            color: mainViewIndex == 2
                                ? VardhmanColors.red
                                : VardhmanColors.darkGrey,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            mainViewIndex = 2;
                          });
                        },
                      ),
                    ),
                    const Text('Bulk'),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text('PAYMENTS'),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Text(
                          'Pending Payments',
                          style: TextStyle(
                            color: mainViewIndex == 3
                                ? VardhmanColors.red
                                : VardhmanColors.darkGrey,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            mainViewIndex = 3;
                          });
                        },
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: Text(
                          'Payment History',
                          style: TextStyle(
                            color: mainViewIndex == 4
                                ? VardhmanColors.red
                                : VardhmanColors.darkGrey,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            mainViewIndex = 4;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Flexible(
                child: mainViewIndex == 1
                    ? const LabdipOrdersView(
                        labdipOrders: labdipOrders,
                      )
                    : mainViewIndex == 2
                        ? const DtmOrdersView(
                            dtmOrders: dtmOrders,
                          )
                        : mainViewIndex == 3
                            ? PendingInvoicesView(
                                pendingInvoices: pendingInvoices)
                            : mainViewIndex == 4
                                ? PaidInvoicesView(paidInvoices: paidInvoices)
                                : const DashboardView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
