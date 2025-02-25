import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getx;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/buyer_info.dart';
import 'package:vardhman_b2b/api/invoice_info.dart';
import 'package:vardhman_b2b/api/item_catalog_info.dart';
import 'package:vardhman_b2b/api/labdip_table_row.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/order_header_line.dart';
import 'package:vardhman_b2b/api/user_address.dart';
import 'package:vardhman_b2b/bulk/bulk_entry_line.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'dart:developer';
import 'package:vardhman_b2b/sample_data.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

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
      baseUrl: 'https://erpdev.vardhmanthreads.in/jderest',
      headers: {
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept': '*/*',
      },
      sendTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
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

            if (getx.Get.isRegistered<UserController>(tag: 'userController')) {
              final UserController userController =
                  getx.Get.find<UserController>(tag: 'userController');

              userController.logOut();

              toastification.show(
                autoCloseDuration: Duration(seconds: 5),
                primaryColor: VardhmanColors.red,
                title: Text('Session Expired'),
              );
            }
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
          "username": "JDEMAPPNP",
          "password": "AppSecure#1",
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

      if (response.statusCode == 200) {
        _dio.options.headers.remove('JDE-AIS-Auth');
        _dio.options.headers.remove('JDE-AIS-Auth-Device');

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
          soldToNumber: Value(userData['User']),
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

  static Future<UserAddress?> fetchBillingAddress(
    String addressNumber,
  ) async {
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

  static Future<List<OrderHeaderLine>> fetchOrders({
    required String soldToNumber,
  }) async {
    final orderHeaderLines = <OrderHeaderLine>[];

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH5542001_GetOrderStatus',
        data: {
          "SoldTo": soldToNumber,
        },
      );

      if (response.statusCode == 200) {
        for (var orderStatus in response.data["GetOrderStatus"]) {
          final OrderHeaderLine orderHeaderLine = OrderHeaderLine(
            orderNumber: orderStatus['OrderNumber'],
            orderType: orderStatus['OrType'],
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
              workOrderType: orderDetailData['WorkOrderType'],
              buyerCode: orderDetailData['End Use'],
            ),
          );
        }
      }
    } catch (e) {
      log('fetchOrderDetails error - $e');
    }

    return orderDetailLines;
  }

  static Future<List<LabdipTableRow>> fetchLabdipTableRows(
      int orderNumber) async {
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
                "controlId": "F5630111.QSMP",
                "operator": "EQUAL",
                "value": [
                  {"specialValueId": "LITERAL", "content": orderNumber}
                ]
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
          itemCatalogInfos.add(
            ItemCatalogInfo(
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
            ),
          );
        }
      }
    } catch (e) {
      log('fetchItemCatalogInfo error - $e');
    }

    return itemCatalogInfos;
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
          'file': MultipartFile.fromBytes(
            fileBytes,
            filename: fileName,
          ),
          'moAdd':
              '{\n    "moStructure":"GT00092",\n    "moKey":[\n        "QTX|QT|||1011|0|LD|B2BL-90920"\n    ],\n    "formName":"P00092_W00092D",\n    "version":"TEST1",\n"file":{"fileName":"UploadTest3.txt", "sequence":3\n    }\n\n}'
        },
      );

      // var dio = Dio();
      var response = await _dio.request(
        '/v2/file/upload',
        options: Options(method: 'POST', contentType: 'multipart/form-data'),
        data: data,
      );

      if (response.statusCode == 200) {
        log(json.encode(response.data));
      } else {
        log(response.statusMessage ?? 'Error');
      }

      // final formData = FormData.fromMap(
      //   {
      //     'file': MultipartFile.fromBytes(fileBytes, filename: 'abcd.txt'),
      //     // 'moAdd': MultipartFile.fromString(
      //     //   jsonEncode(
      //     //     {
      //     //       "moStructure": moStructure,
      //     //       "moKey": [moKey],
      //     //       "formName": formName,
      //     //       "version": version,
      //     //       "file": {"fileName": fileName}
      //     //     },
      //     //   ),
      //     //   filename: 'moAdd.txt',
      //     //   contentType: DioMediaType.parse('application/json'),
      //     // ),
      //   },
      // );

      // formData.fields.add(
      //   MapEntry(
      //     'moAdd',
      //     jsonEncode(
      //       {
      //         "moStructure": moStructure,
      //         "moKey": [moKey],
      //         "formName": formName,
      //         "version": version,
      //         "file": {"fileName": fileName}
      //       },
      //     ),
      //   ),
      // );

      // final response = await _dio.post(
      //   '/v2/file/upload',
      //   options: Options(
      //     contentType: 'multipart/form-data',
      //   ),
      //   data: formData,
      // );

      // if (response.statusCode == 200) {
      //   return true;
      // }
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
            {"id": 1, "value": "00"},
            {"id": 2, "value": "01"}
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
      "Detail": labdipOrderLines
          .map(
            (labdipOrderLine) => {
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
              "MerchandiserName": merchandiserName,
              "LightSourceRemark":
                  "${labdipOrderLine.firstLightSource} ${labdipOrderLine.secondLightSource}",
              "ColorRemark": labdipOrderLine.colorRemark,
              "EndUse": labdipOrderLine.buyerCode,
              "BillingType":
                  labdipOrderLine.billingType == "Branch" ? "B" : "D",
            },
          )
          .toList(),
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

  static Future<bool> submitRematchOrder({
    required String merchandiserName,
    required String b2bOrderNumber,
    required String soldTo,
    required String shipTo,
    required String branchPlant,
    required String company,
    required String orderTakenBy,
    required List<OrderDetailLine> orderDetailLines,
    required Map<OrderDetailLine, String> selectedOrderDetailLinesReasonMap,
  }) async {
    final payload = {
      "Detail": orderDetailLines
          .map(
            (orderDetailLine) => {
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
              "MerchandiserName": merchandiserName,
              "LightSourceRemark": "",
              "ColorRemark": selectedOrderDetailLinesReasonMap[orderDetailLine],
              "EndUse": orderDetailLine.buyerCode,
              "BillingType": "B",
              "RelatedOrder":
                  "${orderDetailLine.orderNumber}|${orderDetailLine.orderType}|${orderDetailLine.company}|${orderDetailLine.lineNumber}"
            },
          )
          .toList(),
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
    final payload = {
      "Detail": dtmEntryLines
          .map(
            (dtmEntryLine) => {
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
              "MerchandiserName": merchandiserName,
              "LightSourceRemark":
                  "${dtmEntryLine.firstLightSource} ${dtmEntryLine.secondLightSource}",
              "ColorRemark": dtmEntryLine.colorRemark,
              "EndUse": dtmEntryLine.buyerCode,
              "BillingType": dtmEntryLine.billingType == "Branch" ? "B" : "D",
            },
          )
          .toList(),
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
    required List<BulkEntryLine> bulkEntryLines,
  }) async {
    final payload = {
      "Detail": bulkEntryLines
          .map(
            (bulkEntryLine) => {
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
              "MerchandiserName": merchandiserName,
              "LightSourceRemark":
                  "${bulkEntryLine.firstLightSource} ${bulkEntryLine.secondLightSource}",
              "ColorRemark": bulkEntryLine.colorRemark,
              "EndUse": bulkEntryLine.buyerCode,
              "BillingType": bulkEntryLine.billingType == "Branch" ? "B" : "D",
            },
          )
          .toList(),
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
        '/orchestrator/ORCH55_ICICIEncrypt',
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
}
