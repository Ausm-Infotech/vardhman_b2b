import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/home/home_controller.dart';
import 'package:vardhman_b2b/home/nav_rail.dart';
import 'package:vardhman_b2b/bulk/bulk_view.dart';
import 'package:vardhman_b2b/dtm/dtm_view.dart';
import 'package:vardhman_b2b/labdip/labdip_view.dart';
import 'package:vardhman_b2b/open/open_view.dart';
import 'package:vardhman_b2b/paid/paid_view.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Scaffold(
      body: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const NavRail(),
            // VerticalDivider(
            //   thickness: 8,
            //   width: 8,
            //   color: VardhmanColors.darkGrey,
            // ),
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
      ),
    );
  }
}
