import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/common/primary_button.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/home/home_controller.dart';
import 'package:vardhman_b2b/nav_rail_container.dart';
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

        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          width: 150,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/vytl_icon_white.png',
                  width: 100,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 240,
                  child: NavRailContainer(
                    title: 'ORDERS',
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
                      ),
                      unselectedLabelTextStyle: const TextStyle(
                        color: VardhmanColors.darkGrey,
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
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  height: 170,
                  child: NavRailContainer(
                    title: 'PAYMENTS',
                    child: NavigationRail(
                      selectedIndex: paymentsNavSelectedIndex,
                      onDestinationSelected: (value) =>
                          homeController.rxNavRailIndex.value = value + 3,
                      labelType: NavigationRailLabelType.all,
                      backgroundColor: Colors.white,
                      indicatorColor: VardhmanColors.red,
                      selectedIconTheme: const IconThemeData(
                        color: Colors.white,
                      ),
                      useIndicator: true,
                      selectedLabelTextStyle:
                          const TextStyle(color: VardhmanColors.red),
                      unselectedLabelTextStyle: const TextStyle(
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
                ),
                const SizedBox(
                  height: 32,
                ),
                NavRailContainer(
                  title: 'USER',
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        userController.rxCustomerDetail.value.name,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      PrimaryButton(
                        iconData: Icons.logout,
                        text: 'Logout',
                        onPressed: () async {
                          Get.find<UserController>(tag: 'userController')
                              .logOut();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
