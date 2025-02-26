import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/home/home_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class NavRail extends StatelessWidget {
  const NavRail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Obx(
      () {
        final ordersNavSelectedIndex = homeController.rxNavRailIndex.value < 3
            ? homeController.rxNavRailIndex.value
            : null;

        final paymentsNavSelectedIndex = homeController.rxNavRailIndex.value > 2
            ? homeController.rxNavRailIndex.value - 3
            : null;

        final UserController userController =
            Get.find<UserController>(tag: 'userController');

        return DefaultTextStyle(
          style: TextStyle(
            fontSize: 13,
            color: VardhmanColors.darkGrey,
            fontWeight: FontWeight.w500,
          ),
          child: Container(
            color: VardhmanColors.darkGrey,
            // color: Colors.grey,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 120,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/vytl_icon_white.png',
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: VardhmanColors.darkGrey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            userController.rxCustomerDetail.value.name,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          SecondaryButton(
                            text: 'Logout',
                            onPressed: () async {
                              Get.find<UserController>(tag: 'userController')
                                  .logOut();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 255,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: VardhmanColors.darkGrey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const Text('ORDERS'),
                          Divider(
                            height: 8,
                            thickness: 0.2,
                            color: VardhmanColors.darkGrey,
                          ),
                          Flexible(
                            child: NavigationRail(
                              selectedIndex: ordersNavSelectedIndex,
                              onDestinationSelected: (value) =>
                                  homeController.rxNavRailIndex.value = value,
                              groupAlignment: 0,
                              labelType: NavigationRailLabelType.all,
                              useIndicator: true,
                              backgroundColor: Colors.white,
                              indicatorColor: VardhmanColors.red,
                              selectedIconTheme: const IconThemeData(
                                color: Colors.white,
                              ),
                              selectedLabelTextStyle: const TextStyle(
                                color: VardhmanColors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              unselectedLabelTextStyle: const TextStyle(
                                color: VardhmanColors.darkGrey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              unselectedIconTheme: const IconThemeData(
                                color: VardhmanColors.darkGrey,
                              ),
                              destinations: const [
                                NavigationRailDestination(
                                  icon: FaIcon(
                                    FontAwesomeIcons.droplet,
                                    size: 13,
                                  ),
                                  label: Text('Labdip'),
                                ),
                                NavigationRailDestination(
                                  icon: Icon(Icons.factory),
                                  label: Text('DTM'),
                                ),
                                NavigationRailDestination(
                                  icon: Icon(Icons.shopping_bag_outlined),
                                  label: Text('Bulk'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      height: 190,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: VardhmanColors.darkGrey,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'INVOICES',
                          ),
                          Divider(
                            height: 8,
                            thickness: 0.2,
                            color: VardhmanColors.darkGrey,
                          ),
                          Flexible(
                            child: NavigationRail(
                              selectedIndex: paymentsNavSelectedIndex,
                              onDestinationSelected: (value) => homeController
                                  .rxNavRailIndex.value = value + 3,
                              groupAlignment: 0,
                              labelType: NavigationRailLabelType.all,
                              useIndicator: true,
                              backgroundColor: Colors.white,
                              indicatorColor: VardhmanColors.red,
                              selectedIconTheme: const IconThemeData(
                                color: Colors.white,
                              ),
                              selectedLabelTextStyle: const TextStyle(
                                color: VardhmanColors.red,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              unselectedLabelTextStyle: const TextStyle(
                                color: VardhmanColors.darkGrey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              unselectedIconTheme: const IconThemeData(
                                color: VardhmanColors.darkGrey,
                              ),
                              destinations: const [
                                NavigationRailDestination(
                                  icon: Icon(Icons.currency_rupee_rounded),
                                  label: Text('Open'),
                                ),
                                NavigationRailDestination(
                                  icon: Icon(Icons.menu_book_sharp),
                                  label: Text('Paid'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
