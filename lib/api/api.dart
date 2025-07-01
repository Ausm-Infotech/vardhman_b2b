import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart' as getx;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vardhman_b2b/api/buyer_info.dart';
import 'package:vardhman_b2b/api/invoice_info.dart';
import 'package:vardhman_b2b/api/item_catalog_info.dart';
import 'package:vardhman_b2b/api/labdip_feedback.dart';
import 'package:vardhman_b2b/api/labdip_table_row.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/api/order_summary.dart';
import 'package:vardhman_b2b/api/user_address.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/labdip/labdip_controller.dart';
import 'dart:developer';
import 'package:vardhman_b2b/sample_data.dart';

class Api {
  static final _fileDio = Dio(
    BaseOptions(
      // baseUrl: 'https://localhost:8081',
      baseUrl: 'https://b2b.amefird.in:8081',
      headers: {'Authorization': 'Basic dnl0bDpPQUlJSkRvaWpmQCM='},
    ),
  );
  // ..httpClientAdapter = IOHttpClientAdapter(
  //     createHttpClient: () =>
  //         HttpClient()..badCertificateCallback = (_, __, ___) => true,
  //   );

  static final _dio = Dio(
    BaseOptions(
      baseUrl:
          'https://erptest.vardhmanthreads.in/jderest', // TODO - Change this as per environment - erpdev / erptest / erp
      headers: {
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept': '*/*',
      },
      sendTimeout: const Duration(seconds: 180),
      connectTimeout: const Duration(seconds: 180),
      receiveTimeout: const Duration(seconds: 180),
      validateStatus: (status) => true,
      receiveDataWhenStatusError: true,
    ),
  )
    // ..httpClientAdapter = IOHttpClientAdapter(
    //   createHttpClient: () => HttpClient()
    //     ..badCertificateCallback =
    //         (X509Certificate cert, String host, int port) => true,
    // )
    ..interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          if (response.statusCode == 444) {
            log('Token expired');

            // if (getx.Get.isRegistered<UserController>(tag: 'userController')) {
            //   final UserController userController =
            //       getx.Get.find<UserController>(tag: 'userController');

            //   userController.logOut();

            //   toastification.show(
            //     autoCloseDuration: Duration(seconds: 3),
            //     primaryColor: VardhmanColors.red,
            //     title: Text('Session Expired'),
            //   );
            // }
          }

          handler.next(response);
        },
      ),
    );

  static Future<bool> fetchToken(String deviceName) async {
    try {
      final response = await _dio.post(
        '/v2/tokenrequest',
        data: {
          // "username": "DEV14",
          // "password": "Secure@3",
          "username": "JDEMAPP",
          "password": "AppSecure#2",
          "deviceName": deviceName,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['userInfo']['token'];

        _dio.options.headers['JDE-AIS-Auth'] = token;
        _dio.options.headers['JDE-AIS-Auth-Device'] = deviceName;

        return true;
      }
    } catch (e) {
      log('fetchToken error - $e');
    }

    return false;
  }

  static Future<bool> logout() async {
    try {
      final response = await _dio.post(
        '/v2/tokenrequest/logout',
        data: {},
      );
      final sharedPrefs = getx.Get.find<SharedPreferences>();
      if (response.statusCode == 200) {
        _dio.options.headers.remove('JDE-AIS-Auth');
        _dio.options.headers.remove('JDE-AIS-Auth-Device');
        sharedPrefs.clear();

        return true;
      }
    } catch (e) {
      log('logout error - $e');
    }

    return false;
  }

  static Future<String> generateAndSendOtp(String mobileNumber) async {
    final String otp = math.Random().nextInt(9999).toString().padLeft(4, '0');

    try {
      await Dio().post(
        'https://digimate.airtel.in:15443/BULK_API/InstantJsonPushV2',
        data: {
          "keyword": "OTP - VYTL Mobile App",
          "timeStamp": DateTime.now().millisecondsSinceEpoch.toString(),
          "dataSet": [
            {
              "UNIQUE_ID": "AIR8409265571",
              "OA": "VYTLMA",
              "MESSAGE":
                  "use <$otp>  as one time password  (OTP) to login to Vardhman MobileApp account.  Do not share this OTP to anyone for security reason.  Valid for 15 minutes.",
              "MSISDN": mobileNumber,
              "CHANNEL": "SMS",
              "CAMPAIGN_NAME": "vardhmant_hu",
              "CIRCLE_NAME": "DLT_SERVICE_EXPLICT",
              "USER_NAME": "vardhmant_hse",
              "DLT_TM_ID": "1001096933494158",
              "DLT_CT_ID": "1007356769817351570",
              "DLT_PE_ID": "1001749328801829990"
            }
          ]
        },
      );
    } catch (e) {
      log(e.toString());
    }

    return otp;
  }

  static Future<void> sendOrderEntrySMS(
      {required String orderNumber, required String mobileNumber}) async {
    try {
      await Dio().post(
        'https://digimate.airtel.in:15443/BULK_API/InstantJsonPushV2',
        data: {
          "keyword": "New Order - VYTL Mobile App",
          "timeStamp": DateTime.now().millisecondsSinceEpoch.toString(),
          "dataSet": [
            {
              "UNIQUE_ID": "AIR8409265571",
              "OA": "VYTLMA",
              "MESSAGE":
                  "Your order with Order No.<$orderNumber> has been successfully placed. Thank you for using Vardhman MobileApp",
              "MSISDN": mobileNumber,
              "CHANNEL": "SMS",
              "CAMPAIGN_NAME": "vardhmant_hu",
              "CIRCLE_NAME": "DLT_SERVICE_EXPLICT",
              "USER_NAME": "vardhmant_hse",
              "DLT_TM_ID": "1001096933494158",
              "DLT_CT_ID": "1007532797482167224",
              "DLT_PE_ID": "1001749328801829990"
            }
          ]
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> sendOrderEntryWhatsApp({
    required String orderNumber,
    required String mobileNumber,
  }) async {
    try {
      final response = await Dio(
        BaseOptions(
          headers: {'Authorization': 'Basic TVNfVkFSREhNOlZhcmRobUAyMCMj'},
        ),
      ).post(
        'https://iqwhatsapp.airtel.in/gateway/airtel-xchange/basic/whatsapp-manager/v1/template/send',
        data: {
          "templateId": "01jj1c8ddqvjdd5v9hp63d850p",
          "to": mobileNumber,
          "from": "9313503051",
          "message": {
            "headerVars": [orderNumber],
            "variables": [orderNumber]
          }
        },
      );

      log(response.data.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<bool> submitStatusReport({
    required String email,
    required DateTime fromDate,
    required String soldToNumber,
  }) async {
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55_EmailOrderDetailsWrapper',
        data: {
          "Customer": soldToNumber,
          "OrderDate": DateFormat('MM/dd/yyyy').format(fromDate),
          "EmailID": email,
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      log('submitStatusReport error - $e');
      return false;
    }
  }

  static Future<List<String>> fetchShades({
    required String article,
    required String uom,
    String shadeStartsWith = '',
  }) async {
    final shades = <String>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "maxPageSize": "No Max",
          "targetName": "F4101",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F4101.SEG3",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "controlId": "F4101.SEG1",
                "operator": "EQUAL",
                "value": [
                  {
                    "specialValueId": "LITERAL",
                    "content": article,
                  }
                ],
              },
              {
                "controlId": "F4101.SEG2",
                "operator": "EQUAL",
                "value": [
                  {
                    "specialValueId": "LITERAL",
                    "content": uom,
                  }
                ],
              },
              if (shadeStartsWith.isNotEmpty)
                {
                  "controlId": "F4101.SEG3",
                  "operator": "STR_START_WITH",
                  "value": [
                    {
                      "specialValueId": "LITERAL",
                      "content": shadeStartsWith,
                    }
                  ],
                },
              {
                "controlId": "F4101.SRP1",
                "operator": "EQUAL",
                "value": [
                  {"specialValueId": "LITERAL", "content": "IND"}
                ]
              },
              {
                "controlId": "F4101.PRP1",
                "operator": "LIST",
                "value": [
                  {"specialValueId": "LITERAL", "content": "Z"},
                  {"specialValueId": "LITERAL", "content": "M"}
                ]
              },
              {
                "controlId": "F4101.STKT",
                "operator": "NOT_EQUAL",
                "value": [
                  {"specialValueId": "LITERAL", "content": "O"}
                ]
              }
            ],
          },
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F4101']['data']['gridData']
            ['rowset'] as List;
        for (var row in rowset) {
          shades.add(row['F4101_SEG3']);
        }
      }
    } catch (e) {
      log('fetchShades error - $e');
    }

    return shades;
  }

  static Future<double?> fetchUnitPrice({
    required String soldToNumber,
    required String shipToNumber,
    required String itemNumber,
    required String businessUnit,
    required DateTime effectiveDate,
  }) async {
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH554074_GetUnitPrice',
        data: {
          "Address_Number": soldToNumber,
          "Ship_To": shipToNumber,
          "Item_Number": itemNumber,
          "Business_Unit": businessUnit,
          "Price_Effective": DateFormat('MM/dd/yyyy').format(effectiveDate),
          "P4074_Version": "ZJDE0001"
        },
      );

      if (response.statusCode == 200) {
        final unitPrices = response.data['GetUnitPrice'] as List;
        double totalUnitPrice = 0.0;

        for (var unitPrice in unitPrices) {
          if (['SBP', 'DISC1', 'DISC2', 'CDIS']
              .contains(unitPrice['Adj Name'])) {
            totalUnitPrice += unitPrice['Unit Price'];
          }
        }

        return totalUnitPrice;
      }
    } catch (e) {
      log('fetchUnitPrice error - $e');
    }

    return null;
  }

  static Future<UserDetailsCompanion?> fetchUserData(
    String userId,
  ) async {
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH5541001_GetUserData',
        data: {
          'User': userId,
        },
      );

      if (response.statusCode == 200) {
        final userData = response.data['Get_User_Data'][0];

        return UserDetailsCompanion(
          soldToNumber: (userData['UserRole'] == 'CUSTOMER')
              ? Value(userData['User'])
              : Value(userData['UserName']),
          isMobileUser: Value(userData['MobileOrPortalFlag'] == 'M'),
          mobileNumber: Value(userData['MobileNumber']),
          canSendSMS: Value(userData['SendSMSYN'] == 'Y'),
          whatsAppNumber: Value(userData['WhatAppNumber']),
          canSendWhatsApp: Value(userData['SendWAPYN'] == 'Y'),
          email: Value(userData['EmailAddresses']),
          name: Value(userData['UserName']),
          companyCode: Value(userData['Company Code']),
          companyName: Value(userData['Company']),
          role: Value(userData['UserRole']),
          category: Value(userData['UserCategory']),
          discountPercent: Value(
              double.tryParse(userData['DiscountPercent'].toString()) ?? 0),
        );
      }
    } catch (e) {
      log(e.toString());
    }

    return null;
  }

  static Future<String> fetchLabdipEmailAddresses() async {
    String emails = '';
    final sharedPrefs = getx.Get.find<SharedPreferences>();
    var ac01 = sharedPrefs.getString('rxZoneAC01');
    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "targetName": "F5501002",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F5501002.EMAL",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "value": [
                  {"content": "P", "specialValueId": "LITERAL"}
                ],
                "controlId": "F5501002.FLAG",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "LAB", "specialValueId": "LITERAL"}
                ],
                "controlId": "F5501002.DL011",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "BRANCH", "specialValueId": "LITERAL"}
                ],
                "controlId": "F5501002.A100",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": ac01, "specialValueId": "LITERAL"}
                ],
                "controlId": "F5501002.AA10",
                "operator": "EQUAL"
              },
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F5501002']['data']
            ['gridData']['rowset'] as List;
        emails = rowset.map((row) => row['F5501002_EMAL']).join(',');
        return emails;
      }
    } catch (e) {
      log('fetchEmailAddresses error - $e');
    }

    return '';
  }

  static Future<String> fetchBulkDtmEmailAddresses() async {
    String emails = '';
    final sharedPrefs = getx.Get.find<SharedPreferences>();
    var ac01 = sharedPrefs.getString('rxZoneAC01');
    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "targetName": "F5501002",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F5501002.EMAL",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "value": [
                  {"content": "P", "specialValueId": "LITERAL"}
                ],
                "controlId": "F5501002.FLAG",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "PODOC", "specialValueId": "LITERAL"}
                ],
                "controlId": "F5501002.DL011",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "BRANCH", "specialValueId": "LITERAL"}
                ],
                "controlId": "F5501002.A100",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": ac01, "specialValueId": "LITERAL"}
                ],
                "controlId": "F5501002.AA10",
                "operator": "EQUAL"
              },
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F5501002']['data']
            ['gridData']['rowset'] as List;
        emails = rowset.map((row) => row['F5501002_EMAL']).join(',');
        return emails;
      }
    } catch (e) {
      log('fetchEmailAddresses error - $e');
    }

    return '';
  }

  static Future<String> fetchReportEmailAddress(String userID) async {
    String email = '';

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "targetName": "F01151",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F01151.EMAL",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "value": [
                  {"content": "E", "specialValueId": "LITERAL"}
                ],
                "controlId": "F01151.ETP",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": 1, "specialValueId": "LITERAL"}
                ],
                "controlId": "F01151.RCK7",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": 0, "specialValueId": "LITERAL"}
                ],
                "controlId": "F01151.IDLN",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": userID, "specialValueId": "LITERAL"}
                ],
                "controlId": "F01151.AN8",
                "operator": "EQUAL"
              },
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F01151']['data']['gridData']
            ['rowset'] as List;

        if (rowset.isNotEmpty) {
          email = rowset[0]['F01151_EMAL'];
        }
        // email = rowset.map((row) => row['F01151_EMAL']);
        return email;
      }
    } catch (e) {
      log('fetchEmailAddresses error - $e');
    }

    return '';
  }

  static Future<UserAddress?> fetchBillingAddress(
    String addressNumber,
  ) async {
    final sharedPrefs = getx.Get.find<SharedPreferences>();
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH550116_Get_SoldTo_Address ',
        data: {
          'Address Number Input': addressNumber,
        },
      );

      if (response.statusCode == 200) {
        final ac01 = response.data['ORCH550005_GetUDC_Repeating'][0]
            ['ORCH550005_GetUDC']['AC01'];

        sharedPrefs.setString('rxZoneAC01', ac01);

        final branchUserDetailsCompanion = await fetchUserData(ac01);

        final soldToData = response.data['Get_SoldTo_Address '][0];

        return UserAddress(
          alphaName: soldToData['Alpha Name'],
          addressLine1: soldToData['Address Line 1'],
          addressLine2: soldToData['Address Line 2'],
          addressLine3: soldToData['Address Line 3'],
          addressLine4: soldToData['Address Line 4'],
          city: soldToData['City'],
          postalCode: soldToData['Postal Code'],
          state: soldToData['State'],
          stateCode: soldToData['State Code'],
          country: soldToData['Country'],
          countryCode: soldToData['Country Code'],
          deliveryAddressNumber: 0,
          branchPlant: response.data['ORCH550005_GetUDC_Repeating'][0]
              ['ORCH550005_GetUDC']['Branch Plant'],
          branchPlantEmail: branchUserDetailsCompanion?.email.value,
          branchPlantPhone: branchUserDetailsCompanion?.mobileNumber.value,
          branchPlantWhatsApp: branchUserDetailsCompanion?.whatsAppNumber.value,
        );
      }
    } catch (e) {
      log('fetchBillingAddress error - $e');
    }

    return null;
  }

  static Future<List<UserAddress>> fetchDeliveryAddresses({
    required String soldToNumber,
    required String company,
  }) async {
    final deliveryAddresses = <UserAddress>[];

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH550101K_GetDeliveryAddress',
        data: {
          'SoldToAddress': soldToNumber,
          'Company': company,
        },
      );

      if (response.statusCode == 200) {
        final deliveryAddressesData = response.data['DeliveryAddress'] ?? [];

        for (var deliveryAddressData in deliveryAddressesData) {
          deliveryAddresses.add(
            UserAddress(
              alphaName: deliveryAddressData['Alpha Name'],
              addressLine1: deliveryAddressData['Address Line 1'],
              addressLine2: deliveryAddressData['Address Line 2'],
              addressLine3: deliveryAddressData['Address Line 3'],
              addressLine4: deliveryAddressData['Address Line 4'],
              city: deliveryAddressData['City'],
              postalCode: deliveryAddressData['Postal Code'],
              state: deliveryAddressData['State'],
              stateCode: deliveryAddressData['State Code'],
              country: deliveryAddressData['Country'],
              countryCode: deliveryAddressData['Country Code'],
              deliveryAddressNumber:
                  deliveryAddressData['DeliveryAddressNumber'],
            ),
          );
        }
      }
    } catch (e) {
      log('fetchDeliveryAddresses error - $e');
    }

    return deliveryAddresses;
  }

  static Future<List<LabdipFeedback>> fetchLabdipFeedback(
      List<int> orderNumbers) async {
    final labdipFeedbacks = <LabdipFeedback>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "targetName": "F00092",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F00092.SBN1|F00092.SBA1|F00092.SBA2|F00092.RMK",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "value": [
                  {"content": "LDF", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.SDB",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "LD", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.TYDT",
                "operator": "EQUAL"
              },
              {
                "value": orderNumbers
                    .map(
                      (orderNumber) =>
                          {"content": orderNumber, "specialValueId": "LITERAL"},
                    )
                    .toList(),
                "controlId": "F00092.SBN1",
                "operator": "LIST"
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F00092']['data']['gridData']
            ['rowset'] as List;
        for (var row in rowset) {
          labdipFeedbacks.add(
            LabdipFeedback(
              orderNumber: row['F00092_SBN1'],
              lineNumber: double.tryParse(row['F00092_SBA2']) ?? 0.0,
              reason: row['F00092_RMK'],
              isPositive: row['F00092_SBA1'] == 'A',
              shouldRematch: false,
            ),
          );
        }
      }
    } catch (e) {
      log('fetchLabdipFeedback error - $e');
    }

    return labdipFeedbacks;
  }

  static Future<List<LabdipFeedback>> fetchLabdipRejectionCount(
      String b2bOrderReference) async {
    final labdipRejections = <LabdipFeedback>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "targetName": "F00092",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F00092.RMK2",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "value": [
                  {"content": "LDF", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.SDB",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "LD", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.TYDT",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": b2bOrderReference, "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.RMK2",
                "operator": "EQUAL"
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F00092']['data']['gridData']
            ['rowset'] as List;
        for (var row in rowset) {
          labdipRejections.add(
            LabdipFeedback(
              reason: row['F00092_RMK2'],
              orderNumber: 0,
              lineNumber: 0,
              isPositive: false,
              shouldRematch: false,
            ),
          );
        }
      }
    } catch (e) {
      log('fetchLabdipRejectionCount error - $e');
    }

    return labdipRejections;
  }

  static Future<List<OrderHeaderLine>> fetchOrders({
    required String soldToNumber,
  }) async {
    final orderHeaderLines = <OrderHeaderLine>[];

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH5542001_GetOrderStatus',
        data: {
          "SoldTo": soldToNumber,
          "FromOrderDate": DateFormat('MM/dd/yyyy')
              .format(DateTime.now().subtract(Duration(days: 180))),
          "ToOrderDate": DateFormat('MM/dd/yyyy').format(DateTime.now()),
        },
      );

      if (response.statusCode == 200) {
        for (var orderStatus in response.data["GetOrderStatus"]) {
          final OrderHeaderLine orderHeaderLine = OrderHeaderLine(
            orderNumber: orderStatus['OrderNumber'],
            orderType: orderStatus['OrTy'],
            orderCompany: orderStatus['OrderCo'],
            orderDate: DateFormat('MM/dd/yyyy').parse(
              orderStatus['OrderDate'],
            ),
            orderReference: orderStatus['OrderReference'],
            holdCode: orderStatus['HoldCode'],
            shipTo: orderStatus['ShipTo'],
            quantityOrdered: orderStatus['QuantityOrdered'],
            quantityShipped: orderStatus['QuantityShipped'],
            quantityCancelled: orderStatus['QuantityCanceled'],
            orderStatus: orderStatus['OrderStatus'],
            orderAmount:
                double.tryParse(orderStatus['OrderAmount'].toString()) ?? 0.0,
            isDTM: orderStatus['DTMOrderYN'].toString().trim() == 'Y',
            canIndent: orderStatus['InderntOrderYN'].toString().trim() == 'Y',
            quantityBackOrdered: orderStatus['QuantityBackOrder'],
            poNumber: orderStatus['CustomerPO'],
            merchandiser: orderStatus['MerchandiserName'],
          );

          orderHeaderLines.add(orderHeaderLine);
        }
      }
    } catch (e) {
      log('fetchOrders error - $e');
    }

    return orderHeaderLines;
  }

  static Future<List<OrderDetailLine>> fetchOrderDetails({
    required int orderNumber,
    required String orderType,
    required String orderCompany,
  }) async {
    final orderDetailLines = <OrderDetailLine>[];

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH5542002_GetOrderDetail',
        data: {
          "Order Number": orderNumber,
          "OrderType": orderType,
          "OrderCompany": orderCompany,
        },
      );

      if (response.statusCode == 200) {
        for (var orderDetailData in response.data["OrderDetail"]) {
          orderDetailLines.add(
            OrderDetailLine(
              company: orderDetailData['Company'],
              orderNumber: orderDetailData['Order'],
              orderType: orderDetailData['Type'],
              lineNumber:
                  double.parse(orderDetailData['Line Number'].toString()),
              dateShipped: orderDetailData['Date Shipped'] != "null"
                  ? DateFormat('MM/dd/yyyy')
                      .parse(orderDetailData['Date Shipped'])
                  : null,
              dateInvoiced: orderDetailData['Date Invoiced'] != "null"
                  ? DateFormat('MM/dd/yyyy')
                      .parse(orderDetailData['Date Invoiced'])
                  : null,
              item: orderDetailData['Item'],
              itemDescription: orderDetailData['Item Description'],
              userComment: orderDetailData['Description2'],
              nextStatus: orderDetailData['Next Status'],
              nextStatusDescription: orderDetailData['Next Status Desc'],
              lastStatus: orderDetailData['Last Status'],
              lastStatusDescription: orderDetailData['Last Status Desc'],
              quantityOrdered: orderDetailData['Quantity Ordered'],
              quantityShipped: orderDetailData['Quantity Shipped'],
              quantityCancelled: orderDetailData['Quantity Canceled'],
              quantityBackordered: orderDetailData['Quantity Backordered'],
              invoiceNumber: orderDetailData['Invoice'],
              invoiceType: orderDetailData['Invoice Type'],
              invoiceCompany: orderDetailData['Invoice Company'],
              workOrderNumber: int.tryParse(orderDetailData['WorkOrder']) ?? 0,
              catalogName: orderDetailData['Catalog Name'],
              woStatus: orderDetailData['WOStatus'],
              orderLineReference: orderDetailData['OrderLineReference'],
              workOrderType: orderDetailData['WorkOrderType'],
              buyerCode: orderDetailData['End Use'],
              unitPrice:
                  double.tryParse(orderDetailData['Unit Price'].toString()) ??
                      0.0,
              extendedPrice: double.tryParse(
                      orderDetailData['Extended Price'].toString()) ??
                  0.0,
              lightSource1: orderDetailData['Print Message'],
              shipToAttention: orderDetailData['ShipToAttention'],
            ),
          );
        }
      }
    } catch (e) {
      log('fetchOrderDetails error - $e');
    }

    return orderDetailLines;
  }

  static Future<List<String>> validateItemNumbers(
      List<String> itemNumbers) async {
    final validItemNumbers = <String>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "targetName": "F4101",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F4101.LITM",
          "maxPageSize": "No Max",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "controlId": "F4101.LITM",
                "operator": "LIST",
                "value": itemNumbers
                    .map(
                      (itemNumber) => {
                        "specialValueId": "LITERAL",
                        "content": itemNumber,
                      },
                    )
                    .toList(),
              },
              {
                "controlId": "F4101.SRP1",
                "operator": "EQUAL",
                "value": [
                  {"specialValueId": "LITERAL", "content": "IND"}
                ]
              },
              {
                "controlId": "F4101.PRP1",
                "operator": "LIST",
                "value": [
                  {"specialValueId": "LITERAL", "content": "Z"},
                  {"specialValueId": "LITERAL", "content": "M"}
                ]
              },
              {
                "controlId": "F4101.STKT",
                "operator": "NOT_EQUAL",
                "value": [
                  {"specialValueId": "LITERAL", "content": "O"}
                ]
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F4101']['data']['gridData']
            ['rowset'] as List;
        for (var row in rowset) {
          validItemNumbers.add(row['F4101_LITM']);
        }
      }
    } catch (e) {
      log('fetchItemNumbers error - $e');
    }

    return validItemNumbers;
  }

  static Future<List<LabdipTableRow>> fetchLabdipTableRows(
      {required List<int> workOrderNumbers}) async {
    final labdipTableRows = <LabdipTableRow>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "maxPageSize": "No Max",
          "targetName": "F5630111",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F5630111.WCP3|F5630111.REFERENC|F5630111.DOCO",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "controlId": "F5630111.DOCO",
                "operator": "LIST",
                "value": workOrderNumbers
                    .map(
                      (workOrderNumber) => {
                        "specialValueId": "LITERAL",
                        "content": workOrderNumber
                      },
                    )
                    .toList()
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F5630111']['data']
            ['gridData']['rowset'] as List;

        for (var row in rowset) {
          labdipTableRows.add(
            LabdipTableRow(
              reference: row['F5630111_REFERENC'],
              workOrderNumber: row['F5630111_DOCO'],
              permanentShade: row['F5630111_WCP3'],
            ),
          );
        }
      }
    } catch (e) {
      log('fetchLabdipTableRows error - $e');
    }

    return labdipTableRows;
  }

  static Future<List<ItemCatalogInfo>> fetchItemCatalogInfo() async {
    final itemCatalogInfos = <ItemCatalogInfo>[];

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55_GetItemCatalogInfo',
        data: {},
      );

      if (response.statusCode == 200) {
        for (var itemCatalogInfoData in response.data["GetItemCatalogInfo"]) {
          try {
            final itemCatalogInfo = ItemCatalogInfo(
              article: itemCatalogInfoData['Article'],
              uom: itemCatalogInfoData['UOM'],
              category: itemCatalogInfoData['Category'],
              categoryDesc: itemCatalogInfoData['Category_Desc'],
              subSegment: itemCatalogInfoData['SubSegment'],
              subSegmentDesc: itemCatalogInfoData['SubSegment_Desc'],
              brand: itemCatalogInfoData['Brand'],
              brandDesc: itemCatalogInfoData['Brand_Desc'],
              substrate: itemCatalogInfoData['Substrate'],
              substrateDesc: itemCatalogInfoData['Substrate_Desc'],
              count: itemCatalogInfoData['Value_1'],
              length: itemCatalogInfoData['Value_2'],
              ticket: itemCatalogInfoData['Value_3'],
              tex: itemCatalogInfoData['Value_4'],
              variant: itemCatalogInfoData['Value_5'],
            );

            itemCatalogInfos.add(itemCatalogInfo);

            // log('fetchItemCatalogInfo - addItem - $itemCatalogInfo');
          } catch (e) {
            log('fetchItemCatalogInfo - addItem error - $e');
          }
        }
      }
    } catch (e) {
      log('fetchItemCatalogInfo error - $e');
    }

    return itemCatalogInfos;
  }

  static Future<bool> supplementalDataEntry({
    required String databaseCode,
    required int orderNumber,
    required int lineNumber,
    required String dataType,
    required String b2bOrderNumber,
    required String soldToNumber,
    required String userName,
  }) async {
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH5500092_SupplementalDataEntry',
        data: {
          "szSupplementalDatabaseCode": databaseCode,
          "cActionCode": "1",
          "mnNumericKey1": orderNumber,
          "szAlphaKey1": lineNumber,
          "szDataType": dataType,
          "jdEndingEffectiveDate":
              DateFormat('MM/dd/yyyy').format(DateTime.now()),
          "szRemark1": b2bOrderNumber,
          "mnNumericKey2": soldToNumber,
          "jdEffectiveDate": DateFormat('MM/dd/yyyy').format(DateTime.now()),
          "szRemark2": userName,
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      log('supplementalDataEntry error - $e');
      return false;
    }
  }

  static Future<bool> supplementalDataWrapper({
    required String databaseCode,
    required String dataType,
    required int orderNumber,
    required int lineNumber,
    required String soldTo,
    required String fileType,
    required String emailAddresses,
  }) async {
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55_SupplementalDataWrapper',
        data: {
          "SDB Code 1": databaseCode,
          "Ty Dt 1": dataType,
          "LineNo": lineNumber.toString(),
          "OrderNo": orderNumber.toString(),
          "Customer": soldTo,
          "EmailAddress": emailAddresses,
          "filetype": fileType,
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      log('supplementalDataWrapper error - $e');
      return false;
    }
  }

  static Future<bool> uploadMediaAttachment({
    required Uint8List fileBytes,
    required String fileName,
    required String moKey,
    required String moStructure,
    required String version,
    required String formName,
  }) async {
    try {
      var data = FormData.fromMap(
        {
          'file': MultipartFile.fromBytes(fileBytes),
          'moAdd': MultipartFile.fromString(
            json.encode(
              {
                'moStructure': moStructure,
                'moKey': [moKey],
                'formName': formName,
                'version': version,
                "file": {"fileName": fileName},
              },
            ),
            contentType: MediaType.parse('application/json'),
          ),
        },
      );

      var response = await _dio.request(
        '/v2/file/upload',
        options: Options(method: 'POST', contentType: 'multipart/form-data'),
        data: data,
      );

      if (response.statusCode == 200) {
        log(json.encode(response.data));

        return true;
      } else {
        log(response.statusMessage ?? 'Error');
      }
    } catch (e) {
      log('uploadMediaAttachment error - $e');
    }

    return false;
  }

  static Future<int?> fetchOrderNumber() async {
    int? nextNumber;

    try {
      final response = await _dio.post(
        '/v2/bsfnservice',
        data: {
          "name": "X0010GetNextNumber",
          "isAsync": false,
          "inParams": [
            {"id": 1, "value": "47"},
            {"id": 2, "value": "10"}
          ],
          "outputIds": [8]
        },
      );

      if (response.statusCode == 200) {
        nextNumber = response.data["result"]["output"][0]["value"];
      }
    } catch (e) {
      log('fetchOrderNumber error - $e');
    }

    return nextNumber;
  }

  static Future<int?> fetchPaymentBatchNumber() async {
    int? nextNumber;

    try {
      final response = await _dio.post(
        '/v2/bsfnservice',
        data: {
          "name": "X0010GetNextNumber",
          "isAsync": false,
          "inParams": [
            {"id": 1, "value": "03B"},
            {"id": 2, "value": "05"}
          ],
          "outputIds": [8]
        },
      );

      if (response.statusCode == 200) {
        nextNumber = response.data["result"]["output"][0]["value"];
      }
    } catch (e) {
      log('fetchPaymentNumber error - $e');
    }

    return nextNumber;
  }

  static Future<bool> createInvoicePaymentEntry({
    required List<Map<String, dynamic>> paymentDetails,
  }) async {
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55_CreateInvoicePaymentEntry',
        data: {
          "InvoicePayment": paymentDetails,
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log('createInvoicePaymentEntry error - $e');
    }

    return false;
  }

  static Future<List<BuyerInfo>> fetchBuyerInfos() async {
    final buyerInfos = <BuyerInfo>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "maxPageSize": "No Max",
          "targetName": "F00092",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F00092.KY|F00092.RMK|F00092.RMK2|F00092.RMK3",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "value": [
                  {"content": "BY", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.TYDT",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "BY", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.SDB",
                "operator": "EQUAL"
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F00092']['data']['gridData']
            ['rowset'] as List;

        for (var row in rowset) {
          buyerInfos.add(
            BuyerInfo(
              code: row['F00092_KY'],
              firstLightSource: row['F00092_RMK'],
              secondLightSource: row['F00092_RMK2'],
              name: row['F00092_RMK3'],
            ),
          );
        }
      }
    } catch (e) {
      log('fetchBuyerInfos error - $e');
    }

    return buyerInfos;
  }

  static Future<List<String>> fetchMerchandiserNames(
      {required String soldToNumber}) async {
    final merchandiserNames = <String>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "maxPageSize": "No Max",
          "targetName": "F00092",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F00092.RMK",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "value": [
                  {"content": "MR", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.TYDT",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "MR", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.SDB",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": soldToNumber, "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.SBN1",
                "operator": "EQUAL"
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F00092']['data']['gridData']
            ['rowset'] as List;

        for (var row in rowset) {
          merchandiserNames.add(row['F00092_RMK']);
        }
      }
    } catch (e) {
      log('fetchBuyerInfos error - $e');
    }

    return merchandiserNames;
  }

  static Future<List<int>> fetchInvoicesInProcessing(
      String soldToNumber) async {
    final docNumbers = <int>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "maxPageSize": "No Max",
          "targetName": "F550313Z",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F550313Z.DOC",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "value": [
                  {"content": soldToNumber, "specialValueId": "LITERAL"}
                ],
                "controlId": "F550313Z.AN8",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "P", "specialValueId": "LITERAL"}
                ],
                "controlId": "F550313Z.EDSP",
                "operator": "NOT_EQUAL"
              },
              {
                "value": [
                  {"content": "E", "specialValueId": "LITERAL"}
                ],
                "controlId": "F550313Z.EDSP",
                "operator": "NOT_EQUAL"
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F550313Z']['data']
            ['gridData']['rowset'] as List;

        for (var row in rowset) {
          docNumbers.add(row['F550313Z_DOC']);
        }
      }
    } catch (e) {
      log('fetchDocumentNumbers error - $e');
    }

    return docNumbers;
  }

  static Future<Map<int, Map<String, dynamic>>> fetchInvoiceReceiptDetailsMap(
      String addressNumber) async {
    final invoiceReceiptDetailsMap = <int, Map<String, dynamic>>{};

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "maxPageSize": "No Max",
          "targetName": "F03B14",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F03B14.CKNU|F03B14.DOC|F03B14.DMTJ",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "value": [
                  {"content": addressNumber, "specialValueId": "LITERAL"}
                ],
                "controlId": "F03B14.AN8",
                "operator": "EQUAL"
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F03B14']['data']['gridData']
            ['rowset'] as List;

        for (var row in rowset) {
          var dateString = row['F03B14_DMTJ'];

          dateString =
              '${dateString.substring(0, 4)}/${dateString.substring(4, 6)}/${dateString.substring(6, 8)}';

          final receiptDate = DateFormat('yyyy/MM/dd').parse(dateString);
          invoiceReceiptDetailsMap[row['F03B14_DOC']] = {
            'receiptNumber': row['F03B14_CKNU'],
            'receiptDate': receiptDate,
          };
        }
      }
    } catch (e) {
      log('fetchReceiptNumbers error - $e');
    }

    return invoiceReceiptDetailsMap;
  }

  static Future<List<InvoiceInfo>> fetchInvoices({
    required String customerNumber,
    required String company,
  }) async {
    final invoiceDetailsCompanions = <InvoiceInfo>[];

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH5503B11A_GetInvoices',
        data: {
          "CustomerNumber": customerNumber,
          "Company": company,
        },
      );

      if (response.statusCode == 200) {
        final invoiceReceiptNumbersMap =
            await fetchInvoiceReceiptDetailsMap(customerNumber);

        final openInvoicesData = response.data['OpenInvoices'] as List;

        for (final openInvoiceData in openInvoicesData) {
          final openInvoiceInfo = InvoiceInfo(
            openAmount: openInvoiceData['InvoiceOpenAmount'] + .0,
            grossAmount: openInvoiceData['InvoiceGrossAmount'] + .0,
            discountAmount: openInvoiceData['InvoiceDiscountAvailable'] + .0,
            taxableAmount: openInvoiceData['InvoiceTaxableAmount'] + .0,
            tax: openInvoiceData['InvoiceTax'] + .0,
            customerNumber: openInvoiceData['Customer'].toString(),
            company: openInvoiceData['InvoiceCompany'],
            docType: openInvoiceData['InvoiceDocType'],
            invoiceNumber: openInvoiceData['InvoiceNumber'],
            salesOrderNumber: openInvoiceData['SalesOrderNumber'],
            salesOrderType: openInvoiceData['SalesOrderType'],
            date: DateFormat('MM/dd/yyyy').parse(
              openInvoiceData['InvoiceDate'],
            ),
            discountDueDate: DateFormat('MM/dd/yyyy').parse(
              openInvoiceData['DiscountDueDate'],
            ),
            isOpen: true,
            status: InvoiceStatus.processing,
            receiptNumber:
                invoiceReceiptNumbersMap[openInvoiceData['InvoiceNumber']]
                        ?['receiptNumber'] ??
                    '',
            receiptDate:
                invoiceReceiptNumbersMap[openInvoiceData['InvoiceNumber']]
                        ?['receiptDate'] ??
                    DateTime.now(),
          );

          invoiceDetailsCompanions.add(openInvoiceInfo);
        }

        final paidInvoicesData = response.data['PaidInvoice'] as List;

        for (final paidInvoiceData in paidInvoicesData) {
          final paidInvoiceInfo = InvoiceInfo(
            openAmount: paidInvoiceData['InvoiceOpenAmount'] + .0,
            grossAmount: paidInvoiceData['InvoiceGrossAmount'] + .0,
            discountAmount: paidInvoiceData['InvoiceDiscountAmount'] + .0,
            taxableAmount: paidInvoiceData['InvoiceTaxableAmount'] + .0,
            tax: paidInvoiceData['InvoiceTax'] + .0,
            customerNumber: paidInvoiceData['CustomerNumber'].toString(),
            company: paidInvoiceData['InvoiceCompany'],
            docType: paidInvoiceData['InvoiceDocType'],
            invoiceNumber: paidInvoiceData['InvoiceNumber'],
            salesOrderNumber: paidInvoiceData['SalesOrderNumber'],
            salesOrderType: paidInvoiceData['SalesOrderType'],
            date: DateFormat('MM/dd/yyyy').parse(
              paidInvoiceData['InvoiceDate'],
            ),
            discountDueDate: DateFormat('MM/dd/yyyy').parse(
              paidInvoiceData['DiscountDueDate'],
            ),
            isOpen: false,
            status: InvoiceStatus.processing,
            receiptNumber:
                invoiceReceiptNumbersMap[paidInvoiceData['InvoiceNumber']]
                        ?['receiptNumber'] ??
                    '',
            receiptDate:
                invoiceReceiptNumbersMap[paidInvoiceData['InvoiceNumber']]
                        ?['receiptDate'] ??
                    DateTime.now(),
          );

          invoiceDetailsCompanions.add(paidInvoiceInfo);
        }

        final holdInvoicesData = response.data['HoldInvoice'] as List;

        for (final holdInvoiceData in holdInvoicesData) {
          final holdInvoiceInfo = InvoiceInfo(
            openAmount: holdInvoiceData['InvoiceOpenAmount'] + .0,
            grossAmount: holdInvoiceData['InvoiceGrossAmount'] + .0,
            discountAmount: holdInvoiceData['InvoiceDiscountAvailable'] + .0,
            taxableAmount: holdInvoiceData['InvoiceTaxableAmount'] + .0,
            tax: holdInvoiceData['InvoiceTax'] + .0,
            customerNumber: holdInvoiceData['Customer'].toString(),
            company: holdInvoiceData['InvoiceCompany'],
            docType: holdInvoiceData['InvoiceDocType'],
            invoiceNumber: holdInvoiceData['InvoiceNumber'],
            salesOrderNumber: holdInvoiceData['SalesOrderNumber'],
            salesOrderType: holdInvoiceData['SalesOrderType'],
            date: DateFormat('MM/dd/yyyy').parse(
              holdInvoiceData['InvoiceDate'],
            ),
            discountDueDate: DateFormat('MM/dd/yyyy').parse(
              holdInvoiceData['DiscountDueDate'],
            ),
            isOpen: true,
            status: InvoiceStatus.onHold,
            receiptNumber:
                invoiceReceiptNumbersMap[holdInvoiceData['InvoiceNumber']]
                        ?['receiptNumber'] ??
                    '',
            receiptDate:
                invoiceReceiptNumbersMap[holdInvoiceData['InvoiceNumber']]
                        ?['receiptDate'] ??
                    DateTime.now(),
          );

          invoiceDetailsCompanions.add(holdInvoiceInfo);
        }
      }
    } catch (e) {
      log(
        'Fetch invoices error',
        error: e,
      );
    }

    return invoiceDetailsCompanions;
  }

  static Future<bool> updateInvoicePaymentRequest({
    required int batchNumber,
    required String receiptNumber,
    required String company,
    required String customerNumber,
    required String sp,
    required String paymentReference,
    required String paymentRemark,
  }) async {
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55_InvoicePaymentReqUpdate',
        data: {
          "Batch_Number": batchNumber,
          "Receipt_Number": receiptNumber,
          "Company": company,
          "Customer_Number": customerNumber,
          "S_P": sp,
          "Payment_Reference": paymentReference,
          "Payment_Remark": paymentRemark,
          "Source_Mobile_Portal": "M",
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log('updateInvoicePaymentRequest error - $e');
    }

    return false;
  }

  static Future<bool> submitLabdipOrder({
    required String merchandiserName,
    required String b2bOrderNumber,
    required String soldTo,
    required String shipTo,
    required String branchPlant,
    required String company,
    required String orderTakenBy,
    required List<DraftTableData> labdipOrderLines,
  }) async {
    final payload = {
      "Detail": labdipOrderLines.map(
        (labdipOrderLine) {
          final isOtherBuyer = labdipOrderLine.buyerCode.isEmpty;

          return {
            "BatchNumber": b2bOrderNumber,
            "Company": company,
            "SoldTo": soldTo,
            "ShipTo": shipTo,
            "BranchPlant": branchPlant,
            "ItemNumber": getItemNumber(
              article: labdipOrderLine.article,
              uom: labdipOrderLine.uom,
              shade: labdipOrderLine.shade,
            ),
            "Quantity": 1,
            "OrderTakenBy": orderTakenBy,
            "LineNumber":
                (labdipOrderLines.indexOf(labdipOrderLine) + 1) + 1000,
            "DocumentType": "LD",
            "SourceFlag": "B",
            "MerchandiserName": '$merchandiserName|$b2bOrderNumber',
            "LightSourceRemark": labdipOrderLine.firstLightSource,
            "ColorRemark": labdipOrderLine.colorRemark,
            "EndUse": isOtherBuyer ? 'OTH' : labdipOrderLine.buyerCode,
            "RelatedOrder":
                "| | | |${isOtherBuyer ? 'OTH-${labdipOrderLine.buyer}' : ''}",
            "BillingType": labdipOrderLine.billingType == "Branch" ? "B" : "D",
          };
        },
      ).toList(),
    };

    log(jsonEncode(payload));

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55CreateStagingData',
        data: payload,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(
        'Submit order error',
        error: e,
      );
    }

    return false;
  }

  static Future<bool> submitLabdipFeedback({
    required OrderDetailLine orderDetailLine,
    required LabdipFeedback labdipFeedback,
    required String orderReferenceNumber,
  }) async {
    return await _dio.post(
      '/orchestrator/ORCH5500092_SupplementalDataEntry',
      data: {
        "szSupplementalDatabaseCode": "LDF",
        "cActionCode": "A",
        "mnNumericKey1": "${orderDetailLine.orderNumber}",
        "szAlphaKey1": labdipFeedback.isPositive ? 'A' : 'N',
        "szAlphaKey2": "${orderDetailLine.lineNumber}",
        "szDataType": "LD",
        "szRemark1": labdipFeedback.reason,
        "szRemark2": orderReferenceNumber,
      },
    ).then((response) {
      return response.statusCode == 200;
    }).catchError((e) {
      log('submitFeedback error - $e');
      return false;
    });
  }

  static Future<bool> submitRematchOrder({
    required String merchandiserName,
    required String b2bOrderNumber,
    required String soldTo,
    required String shipTo,
    required String branchPlant,
    required String company,
    required String orderTakenBy,
    required Map<OrderDetailLine, String> orderDetailLinesReasonMap,
  }) async {
    final orderDetailLines = orderDetailLinesReasonMap.keys.toList();

    final LabdipController labdipController = getx.Get.find();

    final payload = {
      "Detail": orderDetailLines.map(
        (orderDetailLine) {
          final labdipTableRows = labdipController
              .getLabdipTableRows(orderDetailLine.workOrderNumber);

          final finalShades = labdipTableRows.map((labdipTableRow) {
            return '${labdipTableRow.permanentShade}-${labdipTableRow.reference}';
          }).join(',');

          return {
            "BatchNumber": b2bOrderNumber,
            "Company": company,
            "SoldTo": soldTo,
            "ShipTo": shipTo,
            "BranchPlant": branchPlant,
            "ItemNumber": orderDetailLine.item,
            "Quantity": 1,
            "OrderTakenBy": orderTakenBy,
            "LineNumber":
                (orderDetailLines.indexOf(orderDetailLine) + 1) + 1000,
            "DocumentType": "LD",
            "SourceFlag": "B",
            "MerchandiserName": '$merchandiserName|$b2bOrderNumber',
            "LightSourceRemark": orderDetailLine.lightSource1,
            "ColorRemark":
                '${orderDetailLine.orderNumber}-$finalShades-${orderDetailLinesReasonMap[orderDetailLine]!}',
            "EndUse": orderDetailLine.buyerCode,
            "BillingType": "B",
            "RelatedOrder":
                "${orderDetailLine.orderNumber}|${orderDetailLine.orderType}|${orderDetailLine.company}|${orderDetailLine.lineNumber}|${orderDetailLine.shipToAttention}",
          };
        },
      ).toList(),
    };

    log(jsonEncode(payload));

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55CreateStagingData',
        data: payload,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(
        'Submit order error',
        error: e,
      );
    }

    return false;
  }

  static Future<List<dynamic>> getBillingType(String soldTo) async {
    final billingTypes = <dynamic>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "targetName": "F00092",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F00092.UKID",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "value": [
                  {"content": "BT", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.SDB",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "BT", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.TYDT",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": "D", "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.SBA2",
                "operator": "EQUAL"
              },
              {
                "value": [
                  {"content": soldTo, "specialValueId": "LITERAL"}
                ],
                "controlId": "F00092.KY",
                "operator": "EQUAL"
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F00092']['data']['gridData']
            ['rowset'] as List;
        return rowset;
      }
    } catch (e) {
      log('listFiles error - $e');
    }

    return billingTypes;
  }

  static Future<bool> submitDtmOrder({
    required String merchandiserName,
    required String b2bOrderNumber,
    required String soldTo,
    required String shipTo,
    required String branchPlant,
    required String company,
    required String orderTakenBy,
    required List<DraftTableData> dtmEntryLines,
  }) async {
    var billingType = 'B';

    var billingTypeResponse = await getBillingType(soldTo);
    if (billingTypeResponse.isNotEmpty) {
      billingType = 'D';
    }

    final payload = {
      "Detail": dtmEntryLines.map(
        (dtmEntryLine) {
          final isOtherBuyer = dtmEntryLine.buyerCode.isEmpty;

          return {
            "BatchNumber": b2bOrderNumber,
            "Company": company,
            "SoldTo": soldTo,
            "ShipTo": shipTo,
            "BranchPlant": branchPlant,
            "ItemNumber": getItemNumber(
              article: dtmEntryLine.article,
              uom: dtmEntryLine.uom,
              shade: dtmEntryLine.shade,
            ),
            "Quantity": dtmEntryLine.quantity,
            "OrderTakenBy": orderTakenBy,
            "LineNumber": (dtmEntryLines.indexOf(dtmEntryLine) + 1) + 1000,
            "DocumentType": "DT",
            "SourceFlag": "B",
            "MerchandiserName":
                '$merchandiserName|$b2bOrderNumber-${dtmEntryLine.poNumber}',
            "LightSourceRemark": dtmEntryLine.firstLightSource,
            "ColorRemark": dtmEntryLine.colorRemark,
            "BillingType": billingType,
            "EndUse": isOtherBuyer ? 'OTH' : dtmEntryLine.buyerCode,
            "RelatedOrder":
                "| | | |${isOtherBuyer ? 'OTH-${dtmEntryLine.buyer}' : ''}",
            if (dtmEntryLine.requestedDate != null)
              "RequestDate":
                  DateFormat('MM/dd/yyyy').format(dtmEntryLine.requestedDate!),
          };
        },
      ).toList(),
    };

    log(jsonEncode(payload));

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55CreateStagingData',
        data: payload,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(
        'Submit order error',
        error: e,
      );
    }

    return false;
  }

  static Future<bool> submitBulkOrder({
    required String merchandiserName,
    required String b2bOrderNumber,
    required String soldTo,
    required String shipTo,
    required String branchPlant,
    required String company,
    required String orderTakenBy,
    required List<DraftTableData> bulkEntryLines,
  }) async {
    var billingType = 'B';

    var billingTypeResponse = await getBillingType(soldTo);
    if (billingTypeResponse.isNotEmpty) {
      billingType = 'D';
    }
    final payload = {
      "Detail": bulkEntryLines.map(
        (bulkEntryLine) {
          final isOtherBuyer = bulkEntryLine.buyerCode.isEmpty;

          return {
            "BatchNumber": b2bOrderNumber,
            "Company": company,
            "SoldTo": soldTo,
            "ShipTo": shipTo,
            "BranchPlant": branchPlant,
            "ItemNumber": getItemNumber(
              article: bulkEntryLine.article,
              uom: bulkEntryLine.uom,
              shade: bulkEntryLine.shade,
            ),
            "Quantity": bulkEntryLine.quantity,
            "OrderTakenBy": orderTakenBy,
            "LineNumber": (bulkEntryLines.indexOf(bulkEntryLine) + 1) + 1000,
            "DocumentType": "BK",
            "SourceFlag": "B",
            "MerchandiserName":
                '$merchandiserName|$b2bOrderNumber-${bulkEntryLine.poNumber}',
            "LightSourceRemark": bulkEntryLine.firstLightSource,
            "ColorRemark": bulkEntryLine.colorRemark,
            "BillingType": billingType,
            "EndUse": isOtherBuyer ? 'OTH' : bulkEntryLine.buyerCode,
            "RelatedOrder":
                "| | | |${bulkEntryLine.colorName}${isOtherBuyer ? '-OTH-${bulkEntryLine.buyer}' : ''}",
            if (bulkEntryLine.requestedDate != null)
              "RequestDate":
                  DateFormat('MM/dd/yyyy').format(bulkEntryLine.requestedDate!),
          };
        },
      ).toList(),
    };

    log(jsonEncode(payload));

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55CreateStagingData',
        data: payload,
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(
        'Submit order error',
        error: e,
      );
    }

    return false;
  }

  static Future<int> fetchItemQuantity({
    required String branchPlant,
    required String itemNumber,
  }) async {
    int quantity = 0;

    try {
      final response = await _dio.post(
        '/orchestrator/JDE_ORCH_Customersearch_ItemAvailability',
        data: {
          "Branch_Plant": branchPlant,
          "2nd Item Number 1": itemNumber,
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['ServiceRequest2']['fs_P41202_W41202A']
            ['data']['gridData']['rowset'] as List;

        if (rowset.isNotEmpty) {
          quantity = rowset[0]['z_QAVAL_47']['internalValue'];
        }
      }
    } catch (e) {
      log('getItemQuantity error - $e');
    }

    return quantity;
  }

  static Future<bool> isCustomerActive(String soldToNumber) async {
    try {
      final response = await _dio.get(
        '/v2/dataservice/table/F03012?\$field=F03012.AN8&\$field=F03012.CO&\$field=F03012.CUSTS&\$filter=F03012.AN8%20EQ%20$soldToNumber&\$filter=F03012.CO%20EQ%2010901',
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F03012']['data']['gridData']
            ['rowset'] as List;

        if (rowset.isNotEmpty) {
          return rowset[0]['F03012_CUSTS'] != '1';
        }
      }
    } catch (e) {
      log('isCustomerActive error - $e');
    }

    return false;
  }

  static Future<List<String>> listFiles(String directoryName) async {
    final fileNames = <String>[];

    try {
      final response = await _fileDio.get('/list/$directoryName');

      if (response.statusCode == 200) {
        final files = response.data['files'] as List;
        for (var file in files) {
          fileNames.add(file);
        }
      }
    } catch (e) {
      log('listFiles error - $e');
    }

    return fileNames;
  }

  static Future<File?> _downloadFile({
    required String folderName,
    required String fileName,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final localFolder = Directory('${directory.path}/$folderName');

      if (!localFolder.existsSync()) {
        localFolder.createSync(recursive: true);
      }

      final localFile = File('${localFolder.path}/$fileName');

      if (localFile.existsSync()) {
        return localFile;
      }

      final response = await _fileDio.get(
        '/download/MobileApp/$folderName/$fileName',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        await localFile.writeAsBytes(
          response.data,
          flush: true,
        );

        return localFile;
      }
    } catch (e) {
      log('_downloadFile error - $e');
    }

    return null;
  }

  static Future<Uint8List?> _downloadFileWeb({
    required String folderName,
    required String fileName,
  }) async {
    try {
      final response = await _fileDio.get(
        '/download/MobileApp/$folderName/$fileName',
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      log('_downloadFile error - $e');
    }

    return null;
  }

  static Future<Uint8List?> downloadInvoiceWeb({
    required int invoiceNumber,
    required String invoiceType,
  }) async {
    return await _downloadFileWeb(
      folderName: 'Invoices',
      fileName: '${invoiceNumber}_$invoiceType.pdf',
    );
  }

  static Future<File?> downloadInvoice({
    required int invoiceNumber,
    required String invoiceType,
  }) async {
    return await _downloadFile(
      folderName: 'Invoices',
      fileName: '${invoiceNumber}_$invoiceType.pdf',
    );
  }

  static Future<String?> encryptInputString(String plainText) async {
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55_ICICIEncrypt', // for PY payments
        // '/orchestrator/ORCH55_ICICIEncryptProd', // for PD payments
        data: {
          "plainText": plainText,
        },
      );

      if (response.statusCode == 200) {
        return response.data["encryptedText"];
      }
    } catch (e) {
      log('encryptInputString error - $e');
    }

    return null;
  }

  static Future<String?> getPaymentStatus(String receiptNumber) async {
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55_GetPaymentWrapper',
        data: {
          "ReceiptNumber": 'txn-id=$receiptNumber|',
        },
      );

      if (response.statusCode == 200) {
        return response.data["decryptedText"];
      }
    } catch (e) {
      log('getPaymentStatus error - $e');
    }

    return null;
  }

  static Future<Map<String, String>> fetchUoMDescriptions() async {
    final uomDescriptions = <String, String>{};

    dynamic responseData;

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "maxPageSize": "No Max",
          "targetName": "F0005",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F0005.KY|F0005.DL01",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "controlId": "F0005.SY",
                "operator": "EQUAL",
                "value": [
                  {"specialValueId": "LITERAL", "content": "55"}
                ]
              },
              {
                "controlId": "F0005.RT",
                "operator": "EQUAL",
                "value": [
                  {"specialValueId": "LITERAL", "content": "K2"}
                ]
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        responseData = response.data;
      }
    } catch (e) {
      log('fetchUoMDescriptions error - $e');

      responseData = uomDescriptionsResponseData;
    }

    final rowset = responseData['fs_DATABROWSE_F0005']['data']['gridData']
        ['rowset'] as List;
    for (var row in rowset) {
      uomDescriptions[row['F0005_KY'].trim()] = row['F0005_DL01'];
    }

    return uomDescriptions;
  }

  static Future<List<ItemMasterCompanion>> fetchItemMaster(
      {required DateTime fromDate}) async {
    final itemMasterCompanions = <ItemMasterCompanion>[];

    dynamic responseData;

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "maxPageSize": "No Max",
          "targetName": "F4101",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F4101.LITM|F4101.URCD|F4101.DSC1|F4101.UPMJ",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "controlId": "F4101.SRP1",
                "operator": "EQUAL",
                "value": [
                  {"specialValueId": "LITERAL", "content": "DOM"}
                ]
              },
              {
                "controlId": "F4101.PRP1",
                "operator": "LIST",
                "value": [
                  {"specialValueId": "LITERAL", "content": "Z"},
                  {"specialValueId": "LITERAL", "content": "M"}
                ]
              },
              {
                "controlId": "F4101.STKT",
                "operator": "NOT_EQUAL",
                "value": [
                  {"specialValueId": "LITERAL", "content": "O"}
                ]
              },
              {"controlId": "F4101.SEG1", "operator": "STR_NOT_BLANK"},
              {"controlId": "F4101.SEG2", "operator": "STR_NOT_BLANK"},
              {"controlId": "F4101.SEG3", "operator": "STR_NOT_BLANK"},
              {
                "controlId": "F4101.UPMJ",
                "operator": "GREATER_EQUAL",
                "value": [
                  {
                    "specialValueId": "LITERAL",
                    "content": DateFormat('MM/dd/yyyy').format(fromDate)
                  }
                ]
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        responseData = response.data;
      }
    } catch (e) {
      log('fetchItemMaster error - $e');

      if (fromDate.isAtSameMomentAs(oldestDateTime)) {
        responseData = itemMasterResponseData;
      }
    }

    if (responseData != null) {
      final uomDescriptions = await fetchUoMDescriptions();

      final rowset = responseData['fs_DATABROWSE_F4101']['data']['gridData']
          ['rowset'] as List;
      for (var row in rowset) {
        String itemNumber = row['F4101_LITM'];

        List<String> itemParts = itemNumber.split(RegExp('\\s+'));

        if (itemParts.length == 3) {
          String article = itemParts[0].trim();

          String uom = itemParts[1].trim();

          String shade = itemParts[2].trim();

          String upmj = row['F4101_UPMJ'];

          itemMasterCompanions.add(
            ItemMasterCompanion(
              itemNumber: Value(row['F4101_LITM']),
              article: Value(article),
              articleDescription: Value(row['F4101_DSC1']),
              uom: Value(uom),
              uomDescription: Value(uomDescriptions[uom] ?? ''),
              shade: Value(shade),
              isInShadeCard: Value(row['F4101_URCD'] == 'Y'),
              lastUpdatedDateTime: Value(
                DateTime(
                  int.parse(upmj.substring(0, 4)),
                  int.parse(upmj.substring(4, 6)),
                  int.parse(upmj.substring(6, 8)),
                ),
              ),
            ),
          );
        } else {
          log('incorrect item - $itemNumber');
        }
      }
    }

    return itemMasterCompanions;
  }

  static Future<List<String>> fetchSalsemanCode({
    required String soldToNumber,
  }) async {
    final salsemanCustomerList = <String>[];
    var salsemanCode = '';

    try {
      final responseSalsemanCode = await _dio.get(
        '/v2/dataservice/table/F03012?\$field=F03012.AN8&\$field=F03012.CO&\$field=F03012.AC02&\$filter=F03012.AN8%20EQ%20$soldToNumber&\$filter=F03012.CO%20EQ%2010901',
      );

      if (responseSalsemanCode.statusCode == 200) {
        final rowset = responseSalsemanCode.data['fs_DATABROWSE_F03012']['data']
            ['gridData']['rowset'] as List;

        for (var row in rowset) {
          salsemanCode = row['F03012_AC02'].toString();
        }
      }

      final responseSalsemanCustomerList = await _dio.get(
        '/v2/dataservice/table/F03012?\$field=F03012.AN8&\$field=F03012.CO&\$field=F03012.AC02&\$filter=F03012.AC02%20EQ%20$salsemanCode&\$filter=F03012.CO%20EQ%2010901',
      );

      if (responseSalsemanCustomerList.statusCode == 200) {
        final rowset = responseSalsemanCustomerList.data['fs_DATABROWSE_F03012']
            ['data']['gridData']['rowset'] as List;

        for (var row in rowset) {
          final customerCode = row['F03012_AN8'].toString();
          salsemanCustomerList.add(customerCode);
        }
      }
    } catch (e) {
      log('fetchAllOrdersByDate error - $e');
    }

    return salsemanCustomerList;
  }

  static Future<Map<String, String>> fetchCustomersName({
    required List<String> salsemanCustomerList,
  }) async {
    final salsemanCustomerNameMap = <String, String>{};

    try {
      final responseSalsemanCustomerNameList = await _dio.post(
        '/v2/dataservice',
        data: {
          "targetName": "F0101",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs": "F0101.AN8|F0101.ALPH",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "controlId": "F47011.AN8",
                "operator": "LIST",
                "value": salsemanCustomerList
                    .map((customerCode) =>
                        {"content": customerCode, "specialValueId": "LITERAL"})
                    .toList()
              }
            ]
          }
        },
      );

      if (responseSalsemanCustomerNameList.statusCode == 200) {
        final rowset = responseSalsemanCustomerNameList
            .data['fs_DATABROWSE_F0101']['data']['gridData']['rowset'] as List;

        for (var row in rowset) {
          final customerCode = row['F0101_AN8'].toString();
          final customerName = row['F0101_ALPH'].toString();

          salsemanCustomerNameMap[customerCode] = customerName;
        }
      }
    } catch (e) {
      log('fetchAllOrdersByDate error - $e');
    }

    return salsemanCustomerNameMap;
  }

  static Future<List<OrderSummary>> fetchOrderCustomersByDate({
    required List<String> salsemanCustomerList,
    required Map<String, String> orderCustomersNameMap,
    required DateTime date,
  }) async {
    var orderSummaryList = <OrderSummary>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
          "targetName": "F47011",
          "targetType": "table",
          "dataServiceType": "BROWSE",
          "returnControlIDs":
              "F47011.AN8|F47011.EDBT|F47011.DOCO|F47011.EDCT|F47011.PNID|F47011.EDDT",
          "query": {
            "autoFind": true,
            "condition": [
              {
                "controlId": "F47011.EDDT",
                "operator": "EQUAL",
                "value": [
                  {
                    "content": DateFormat('MM/dd/yyyy').format(date),
                    "specialValueId": "LITERAL"
                  }
                ]
              },
              {
                "controlId": "F47011.EDCT",
                "operator": "LIST",
                "value": [
                  {"content": "LD", "specialValueId": "LITERAL"},
                  {"content": "DT", "specialValueId": "LITERAL"},
                  {"content": "BK", "specialValueId": "LITERAL"}
                ]
              },
              {
                "controlId": "F47011.AN8",
                "operator": "LIST",
                "value": salsemanCustomerList
                    .map((customerCode) =>
                        {"content": customerCode, "specialValueId": "LITERAL"})
                    .toList()
              }
            ]
          }
        },
      );

      if (response.statusCode == 200) {
        final rowset = response.data['fs_DATABROWSE_F47011']['data']['gridData']
            ['rowset'] as List;

        for (var row in rowset) {
          final customerCode = row['F47011_AN8'].toString();
          final customerName = orderCustomersNameMap[customerCode].toString();
          final portalOrder = row['F47011_EDBT'].toString();
          final jdeOrder = row['F47011_DOCO'].toString();
          final orderType = row['F47011_EDCT'].toString();
          final orderDate = row['F47011_EDDT'].toString();
          final orderRemark = row['F47011_PNID'].toString();

          var orderSummaryItem = OrderSummary(
            customerCode: customerCode,
            customerName: customerName,
            portalOrder: portalOrder,
            jdeOrder: jdeOrder,
            orderType: orderTypeConstants[orderType].toString(),
            orderDate: orderDate,
            orderRemark: orderRemark,
          );
          orderSummaryList.add(orderSummaryItem);
        }
      }
    } catch (e) {
      log('fetchAllOrdersByDate error - $e');
    }

    return orderSummaryList;
  }
}
