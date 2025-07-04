import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/common/header_view.dart';
import 'package:vardhman_b2b/common/new_order_date_field.dart';
import 'package:vardhman_b2b/common/new_order_text_field.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/home/home_controller.dart';
import 'package:vardhman_b2b/home/nav_rail.dart';
import 'package:vardhman_b2b/bulk/bulk_view.dart';
import 'package:vardhman_b2b/dtm/dtm_view.dart';
import 'package:vardhman_b2b/home/order_summary_controller.dart';
import 'package:vardhman_b2b/home/order_summary_view.dart';
import 'package:vardhman_b2b/labdip/labdip_view.dart';
import 'package:vardhman_b2b/open/open_view.dart';
import 'package:vardhman_b2b/paid/paid_view.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class HomeScaffold extends StatefulWidget {
  const HomeScaffold({super.key});

  @override
  State<HomeScaffold> createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold> {
  bool _isHoveringOnName = false;
  Timer? _hideContainerTimer;

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();
    final UserController userController = Get.find(tag: 'userController');

    return Scaffold(
      body: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const NavRail(),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(right: 16),
                        color: VardhmanColors.darkGrey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vardhman B2B Portal v1.0',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            MouseRegion(
                              onEnter: (_) => setState(() {
                                _isHoveringOnName = true;
                              }),
                              onExit: (_) {
                                _hideContainerTimer = Timer(
                                  const Duration(milliseconds: 500),
                                  () => setState(() {
                                    _isHoveringOnName = false;
                                  }),
                                );
                              },
                              child: Text(
                                'Welcome! ${userController.rxUserDetail.value.name}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: homeController.rxNavRailIndex.value == 0
                            ? const LabdipView()
                            : homeController.rxNavRailIndex.value == 1
                                ? const DtmView()
                                : homeController.rxNavRailIndex.value == 2
                                    ? const BulkView()
                                    : homeController.rxNavRailIndex.value == 3
                                        ? const OpenView()
                                        : const PaidView(),
                      ),
                    ],
                  ),
                  if (_isHoveringOnName) // Only show on LabdipView
                    Positioned(
                      top: 36,
                      right: 0,
                      child: MouseRegion(
                        onEnter: (_) {
                          if (_hideContainerTimer?.isActive ?? false) {
                            _hideContainerTimer?.cancel();
                          }
                        },
                        onExit: (_) {
                          _hideContainerTimer = Timer(
                            const Duration(milliseconds: 500),
                            () => setState(() {
                              _isHoveringOnName = false;
                            }),
                          );
                        },
                        child: _isHoveringOnName
                            ? Container(
                                width: userController.rxUserDetail.value.role !=
                                        'CUSTOMER'
                                    ? 380
                                    : 280,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(24)),
                                  color: VardhmanColors.darkGrey,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    userController.rxUserDetail.value.role !=
                                            'CUSTOMER'
                                        ? SecondaryButton(
                                            text: 'Order Summary',
                                            onPressed: () async {
                                              if (Get.isRegistered<
                                                  OrderSummaryController>()) {
                                                Get.delete<
                                                    OrderSummaryController>();
                                              }

                                              Get.put(
                                                OrderSummaryController(),
                                              );
                                              Get.dialog(
                                                const Dialog(
                                                  insetPadding:
                                                      EdgeInsets.symmetric(
                                                    horizontal: 40,
                                                    vertical: 24,
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: SizedBox(
                                                    width: 1000,
                                                    child: OrderSummaryView(),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : SizedBox(),
                                    SecondaryButton(
                                      text: 'Status Report',
                                      onPressed: () async {
                                        var email =
                                            await Api.fetchReportEmailAddress(
                                                userController.rxUserDetail
                                                    .value.soldToNumber);
                                        homeController.rxEmail.value = email;
                                        Get.dialog(
                                          Dialog(
                                            insetPadding: EdgeInsets.all(80),
                                            clipBehavior: Clip.antiAlias,
                                            child: SizedBox(
                                              width: 560,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  HeaderView(
                                                    elevation: 4,
                                                    leading: SecondaryButton(
                                                      wait: false,
                                                      iconData: Icons
                                                          .arrow_back_ios_new,
                                                      text: 'Back',
                                                      onPressed: () async {
                                                        Get.back();
                                                      },
                                                    ),
                                                    title: Text(
                                                      'Request Status Report',
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    trailing: DefaultTextStyle(
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      child: Obx(
                                                        () => PrimaryButton(
                                                          text: 'Submit',
                                                          onPressed: homeController
                                                                      .rxEmail
                                                                      .isEmpty ||
                                                                  !RegExp(
                                                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                                                  ).hasMatch(
                                                                    homeController
                                                                        .rxEmail
                                                                        .value,
                                                                  )
                                                              ? null
                                                              : () async {
                                                                  Api.submitStatusReport(
                                                                    email: homeController
                                                                        .rxEmail
                                                                        .value,
                                                                    fromDate: homeController
                                                                        .rxFromDate
                                                                        .value!,
                                                                    soldToNumber: userController
                                                                        .rxUserDetail
                                                                        .value
                                                                        .soldToNumber,
                                                                  );

                                                                  Get.back();

                                                                  toastification
                                                                      .show(
                                                                    autoCloseDuration:
                                                                        Duration(
                                                                            seconds:
                                                                                3),
                                                                    primaryColor:
                                                                        VardhmanColors
                                                                            .green,
                                                                    title: Text(
                                                                        'Request Submitted!'),
                                                                  );
                                                                },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        NewOrderTextField(
                                                            labelText: 'Email',
                                                            rxString:
                                                                homeController
                                                                    .rxEmail),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        NewOrderDateField(
                                                          labelText: 'From',
                                                          rxDate: homeController
                                                              .rxFromDate,
                                                          firstDate:
                                                              homeController
                                                                  .rxFromDate
                                                                  .value
                                                                  ?.subtract(
                                                            Duration(days: 60),
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
                                      },
                                    ),
                                    PrimaryButton(
                                      text: 'Logout',
                                      onPressed: () async {
                                        await userController.logOut();
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : null,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
