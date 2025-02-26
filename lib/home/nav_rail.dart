import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
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
                    const SizedBox(
                      height: 12,
                    ),
                    SecondaryButton(
                      text: 'Test',
                      onPressed: () async {
                        try {
                          var data = dio.FormData.fromMap(
                            {
                              'file': dio.MultipartFile.fromString(
                                'ABCD',
                                filename: 'UploadTest3.txt',
                              ),
                              'moAdd': dio.MultipartFile.fromString(
                                jsonEncode(
                                  {
                                    "moStructure": "GT00092",
                                    "moKey": ["QTX|QT|||1011|0|LD|B2BL-90920"],
                                    "file": {"fileName": "UploadTest3.txt"},
                                  },
                                ),
                                contentType:
                                    MediaType.parse('application/json'),
                              ),
                            },
                          );

                          var _dio = dio.Dio();

                          var response = await _dio.request(
                            'https://erpdev.vardhmanthreads.in/jderest/v2/file/upload',
                            options: dio.Options(
                              method: 'POST',
                              headers: {
                                'Authorization':
                                    'Basic SkRFTUFQUE5QOkFwcFNlY3VyZSMx',
                              },
                            ),
                            data: data,
                          );

                          if (response.statusCode == 200) {
                            log(json.encode(response.data));
                          } else {
                            log(response.statusMessage ?? 'Error');
                          }
                        } catch (e) {
                          log(e.toString());
                        }

                        // var request = MultipartRequest(
                        //     'POST',
                        //     Uri.parse(
                        //         'https://erpdev.vardhmanthreads.in/jderest/v2/file/upload'));

                        // request.fields.addAll(
                        //   {
                        //     'file': 'ABCD',
                        //     'moAdd': jsonEncode(
                        //       {
                        //         "moStructure": "GT00092",
                        //         "moKey": ["QTX|QT|||1011|0|LD|B2BL-90920"],
                        //         "file": {
                        //           "fileName": "UploadTest3.txt",
                        //         }
                        //       },
                        //     ),
                        //   },
                        // );

                        // request.headers.addAll(
                        //   {
                        //     'JDE-AIS-Auth':
                        //         '044HorQ0bqZ3K3J97At6RWNJsnfwOnLoIcFq5o1wRIQRD4=MDE5MDA4NDY2MTQ2MTQ0MDAwMTM5MjA0MVBvc3RtYW4xMTc0MDQ4OTc1Mjg5MQ==',
                        //     'JDE-AIS-Auth-Device': 'Postman1',
                        //   },
                        // );

                        // StreamedResponse response = await request.send();

                        // if (response.statusCode == 200) {
                        //   print(await response.stream.bytesToString());
                        // } else {
                        //   print(response.reasonPhrase);
                        // }
                      },
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
