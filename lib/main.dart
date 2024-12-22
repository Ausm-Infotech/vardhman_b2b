import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/dtm/dtm_orders_view.dart';
import 'package:vardhman_b2b/labdip/labdip_orders_view.dart';

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
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: <Widget>[
            Column(
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
                const Text('MAIN'),
                const Text('Dashboard'),
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
                const Text('ACCOUNT DETAILS'),
                const Text('My Account Details'),
                const Text('Update Password'),
                const SizedBox(
                  height: 16,
                ),
                const Text('PAYMENTS'),
                const Text('Pending Payments'),
                const Text('Payment History'),
              ],
            ),
            Flexible(
              child: mainViewIndex == 1
                  ? LabdipOrdersView()
                  : mainViewIndex == 2
                      ? DtmOrdersView()
                      : Center(
                          child: Text('Main Dashboard'),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

// Order Date	Order Id	Order Line	Article	tex	Ticket	Quantity	Brand	End Use	Shade	QTX/XML File	Buyer Name	Order Status
