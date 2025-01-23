import 'dart:io';
import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:file_saver/file_saver.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pure_ftp/pure_ftp.dart';
import 'package:vardhman_b2b/api/invoice_info.dart' as api;
import 'package:vardhman_b2b/api/item_catalog_info.dart';
import 'package:vardhman_b2b/api/order_detail_line.dart';
import 'package:vardhman_b2b/api/user_address.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'dart:developer';

class Api {
  static final _fileDownloadDio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080',
      headers: {
        'Authorization': 'Basic YXJqdW46YXJqdW4=',
        'Accept': 'application/pdf',
      },
      sendTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(minutes: 5),
      validateStatus: (status) => true,
      receiveDataWhenStatusError: true,
    ),
  );

  static final _dio = Dio(
    BaseOptions(
      baseUrl: 'http://172.22.250.11:7082/jderest',
      headers: {
        'Authorization': 'Basic REVWMTQ6U2VjdXJlQDI=',
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept': '*/*',
      },
      sendTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(minutes: 5),
      validateStatus: (status) => true,
      receiveDataWhenStatusError: true,
    ),
  );

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
              // "MSISDN": mobileNumber,
              "MSISDN": '9623451355',
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
      String orderNumber, String mobileNumber) async {
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
          mobileNumber: Value(userData['MobileNumber']),
          name: Value(userData['UserName']),
          soldToNumber: Value(userData['User']),
          companyCode: Value(userData['Company Code']),
          companyName: Value(userData['Company']),
          role: Value(userData['UserRole']),
          category: Value(userData['UserCategory']),
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

  static Future<List<RelatedCustomersCompanion>> fetchRelatedCustomers({
    required String userCategory,
    required String userAddressNumber,
  }) async {
    final relatedCustomerCompanions = <RelatedCustomersCompanion>[];

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH5503012_Get_Related_Customers ',
        data: {
          'UserCodeInput': userCategory,
          'UserId': userAddressNumber,
        },
      );

      if (response.statusCode == 200) {
        final relatedCustomers = response.data['Related_Customers'] ??
            response.data["Related_Customers "] ??
            [];

        for (var relatedCustomer in relatedCustomers) {
          relatedCustomerCompanions.add(
            RelatedCustomersCompanion(
              managerSoldTo: Value(userAddressNumber),
              customerSoldTo:
                  Value(relatedCustomer['Customer Number'].toString()),
              customerName: Value(relatedCustomer['Customer Name']),
            ),
          );
        }
      }
    } catch (e) {
      log('fetchRelatedCustomers error - $e');
    }

    return relatedCustomerCompanions;
  }

  static Future<List<OrderStatusCompanion>> fetchOrders({
    required String soldToNumber,
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    final orderStatusCompanions = <OrderStatusCompanion>[];

    try {
      final response = await _dio.post(
        '/orchestrator/ORCH5542001_GetOrderStatus',
        data: {
          "SoldTo": soldToNumber,
          "FromOrderDate": DateFormat('MM/dd/yyyy').format(fromDate),
          "ToOrderDate": DateFormat('MM/dd/yyyy').format(toDate),
        },
      );

      if (response.statusCode == 200) {
        for (var orderInfo in response.data["GetOrderStatus"]) {
          final OrderStatusCompanion orderStatusCompanion =
              OrderStatusCompanion(
            soldToNumber: Value(soldToNumber),
            orderNumber: Value(orderInfo['OrderNumber']),
            orderType: Value(orderInfo['OrType']),
            orderCompany: Value(orderInfo['OrderCo']),
            orderDate: Value(
              DateFormat('MM/dd/yyyy').parse(
                orderInfo['OrderDate'],
              ),
            ),
            orderReference: Value(orderInfo['OrderReference']),
            holdCode: Value(orderInfo['HoldCode']),
            shipTo: Value(orderInfo['ShipTo']),
            quantityOrdered: Value(orderInfo['QuantityOrdered']),
            quantityShipped: Value(orderInfo['QuantityShipped']),
            quantityCancelled: Value(orderInfo['QuantityCanceled']),
            orderStatus: Value(orderInfo['OrderStatus']),
            orderAmount: Value(
              double.tryParse(orderInfo['OrderAmount'].toString()) ?? 0.0,
            ),
          );

          orderStatusCompanions.add(orderStatusCompanion);
        }
      }
    } catch (e) {
      log('fetchOrders error - $e');
    }

    return orderStatusCompanions;
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
              nextStatus: orderDetailData['Next Status'],
              nextStatusDescription: orderDetailData['Next Status Desc'],
              lastStatus: orderDetailData['Last Status'],
              lastStatusDescription: orderDetailData['Last Status Desc'],
              quantityOrdered: orderDetailData['Quantity Ordered'],
              quantityCancelled: orderDetailData['Quantity Canceled'],
              quantityBackordered: orderDetailData['Quantity Backordered'],
              invoiceNumber: orderDetailData['Invoice'],
              invoiceType: orderDetailData['Invoice Type'],
              invoiceCompany: orderDetailData['Invoice Company'],
            ),
          );
        }
      }
    } catch (e) {
      log('fetchOrderDetails error - $e');
    }

    return orderDetailLines;
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

  static Future<List<int>> fetchInvoicesInProcessing(
      String soldToNumber) async {
    final docNumbers = <int>[];

    try {
      final response = await _dio.post(
        '/v2/dataservice',
        data: {
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

  static Future<List<api.InvoiceInfo>> fetchInvoices({
    required String customerNumber,
    required String company,
  }) async {
    final invoiceDetailsCompanions = <api.InvoiceInfo>[];

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
          final openInvoiceInfo = api.InvoiceInfo(
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
            status: api.InvoiceStatus.processing,
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
          final paidInvoiceInfo = api.InvoiceInfo(
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
            status: api.InvoiceStatus.processing,
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

  static Future<bool> submitOrder({
    required String mobileOrderNumber,
    required String soldTo,
    required String shipTo,
    required String branchPlant,
    required String company,
    required String orderTakenBy,
    required List<Map<String, String>> itemQuantityMaps,
  }) async {
    try {
      final response = await _dio.post(
        '/orchestrator/ORCH55CreateStagingData',
        data: {
          "Detail": itemQuantityMaps
              .map(
                (mapEntry) => {
                  "BatchNumber": mobileOrderNumber,
                  "Company": company,
                  "SoldTo": soldTo,
                  "ShipTo": shipTo,
                  "BranchPlant": branchPlant,
                  "ItemNumber": mapEntry['2nd_Item_Number'],
                  "Quantity": mapEntry['Quantity_Ordered'],
                  "OrderTakenBy": orderTakenBy,
                  "LineNumber": (itemQuantityMaps.indexOf(mapEntry) + 1) * 1000,
                  "DocumentType": "MO",
                  "SourceFlag": "M"
                },
              )
              .toList(),
        },
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

  static Future<Uint8List?> downloadCatalog({
    required String articleName,
    Function(int, int, double)? onReceiveProgress,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final localPath = '${directory.path}/$articleName-CAT.pdf';
      final localFile = File(localPath);

      if (await localFile.exists()) {
        return await localFile.readAsBytes();
      }

      final ftpClient = FtpClient(
        socketInitOptions: ftpSocketInitOptions,
        authOptions: ftpAuthOptions,
        logCallback: print,
      );

      await ftpClient.connect();

      final file =
          ftpClient.getFile('/MobileApp/Catalogs/$articleName-CAT.pdf');

      final fileData = await FtpFileSystem(client: ftpClient).downloadFile(
        file,
        onReceiveProgress: onReceiveProgress,
      );

      await ftpClient.disconnect();

      await localFile.writeAsBytes(fileData);

      return Uint8List.fromList(fileData);
    } catch (e) {
      log('downloadCatalogPdf error - $e');
    }

    return null;
  }

  static Future<Uint8List?> downloadShadeCard({
    required String articleName,
    Function(int, int, double)? onReceiveProgress,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final localPath = '${directory.path}/$articleName-SHADE.pdf';
      final localFile = File(localPath);

      if (await localFile.exists()) {
        return await localFile.readAsBytes();
      }

      final ftpClient = FtpClient(
        socketInitOptions: ftpSocketInitOptions,
        authOptions: ftpAuthOptions,
        logCallback: print,
      );

      await ftpClient.connect();

      final file =
          ftpClient.getFile('/MobileApp/ShadeCards/$articleName-SHADE.pdf');

      final fileData = await FtpFileSystem(client: ftpClient).downloadFile(
        file,
        onReceiveProgress: onReceiveProgress,
      );

      await ftpClient.disconnect();

      await localFile.writeAsBytes(fileData);

      return Uint8List.fromList(fileData);
    } catch (e) {
      log('downloadShadeCard error - $e');
    }

    return null;
  }

  static Future<Uint8List?> downloadInvoice({
    required int invoiceNumber,
    required String invoiceType,
    Function(int, int, double)? onReceiveProgress,
  }) async {
    try {
      final fileName = '${invoiceNumber}_$invoiceType.pdf';

      // final response = await _fileDownloadDio.get(
      //   '/CAMSInvoicing/$fileName',
      //   options: Options(responseType: ResponseType.bytes),
      // );

      await FileSaver.instance.saveFile(
        name: fileName,
        link: LinkDetails(
          // headers: {"Authorization": 'Basic YXJqdW46YXJqdW4='},
          link: '/download/CAMSInvoicing/$fileName',
        ),
        dioClient: _fileDownloadDio,
      );

      // final fileData = response.data;

      // await localFile.writeAsBytes(fileData);

      // return Uint8List.fromList(fileData);
    } catch (e) {
      log('downloadInvoice error - $e');
    }

    return null;
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
}
