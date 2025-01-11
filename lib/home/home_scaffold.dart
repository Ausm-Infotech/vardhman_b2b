import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/app_nav_rail/app_nav_controller.dart';
import 'package:vardhman_b2b/home/nav_rail.dart';
import 'package:vardhman_b2b/bulk/bulk_view.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/dtm/dtm_view.dart';
import 'package:vardhman_b2b/labdip/labdip_view.dart';
import 'package:vardhman_b2b/open/open_view.dart';
import 'package:vardhman_b2b/paid/paid_view.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final AppNavController appNavController = Get.find();

    return GetMaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/home_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const NavRail(),
                const VerticalDivider(
                  thickness: 0.5,
                  width: 1,
                  color: VardhmanColors.dividerGrey,
                ),
                Expanded(
                  child: appNavController.selectedIndex.value == 0
                      ? const LabdipView()
                      : appNavController.selectedIndex.value == 1
                          ? const DtmView()
                          : appNavController.selectedIndex.value == 2
                              ? const BulkView()
                              : appNavController.selectedIndex.value == 3
                                  ? const OpenView()
                                  : const PaidView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
