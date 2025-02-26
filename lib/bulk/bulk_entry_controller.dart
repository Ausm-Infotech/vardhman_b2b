import 'dart:typed_data';

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/buyer_info.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class BulkEntryController extends GetxController {
  final OrderReviewController orderReviewController = Get.find();

  final int orderNumber;

  final List<String> _otherLightSouces = [
    'D65',
    'TL84',
    'U35',
    'HORIZON',
    'INCA-A',
    'CWF',
    'UV',
    'U30',
  ];

  final rxPoNumber = ''.obs;

  final rxPoFileName = ''.obs;

  final rxPoFileBytes = Rxn<Uint8List>();

  final List<RxString> inputsInError = <RxString>[].obs;

  final Rxn<DateTime> rxRequestedDate = Rxn<DateTime>(DateTime.now());

  final rxMerchandisers = <String>[].obs;

  final rxMerchandiser = ''.obs;

  final rxColor = ''.obs;

  final rxShade = ''.obs;

  final rxBuyerInfo = Rxn<BuyerInfo>();

  final rxBuyerName = ''.obs;

  final _rxBuyerCode = ''.obs;

  final rxFirstLightSource = ''.obs;

  final rxSecondLightSource = ''.obs;

  final rxOtherBuyerName = ''.obs;

  final rxSubstrate = ''.obs;

  final rxTicket = ''.obs;

  final rxTex = ''.obs;

  final rxArticle = ''.obs;

  final rxUom = ''.obs;

  final rxUomWithDesc = ''.obs;

  final rxBrand = ''.obs;

  final rxL = ''.obs;

  final rxA = ''.obs;

  final rxB = ''.obs;

  final rxRemark = ''.obs;

  final rxQuantity = ''.obs;

  final rxBulkOrderLines = <DraftTableData>[].obs;

  final catalogController = Get.find<CatalogController>();

  final _rxBuyerInfos = <BuyerInfo>[].obs;

  final rxBillingType = 'Branch'.obs;

  final billingTypes = ['Branch', 'Plant'];

  final rxRequestType = ''.obs;

  final requestTypes = ['Stitching', 'Embroidery'];

  final rxEndUse = ''.obs;

  final rxShades = <String>[].obs;

  final rxUnitPrice = ''.obs;

  final endUseOptions = [
    "Active/sportswear",
    "Apparel",
    "Apparel Embroidery",
    "Apparel Knitted Outerwear",
    "Apparel Woven Outerwear",
    "Automotive",
    "Bag Making / Closing",
    "Bedding & Quilting",
    "Children/babywear",
    "Denim / jeans",
    "Embroidery - Comp.Multihead",
    "Embroidery - Multi Needles",
    "Embroidery - Non apparel",
    "END Use",
    "EP Fabrics and Knits",
    "Feminine Hygene",
    "Filtration",
    "Footwear",
    "Footwear - Sports",
    "Furniture & Upholstery",
    "Gloves-Indl. Safety",
    "Hand Bags",
    "Home Textiles",
    "Leather Apparel",
    "Leather Footwear",
    "Luggage",
    "Luggage, Handbags",
    "Made Ups",
    "Marine",
    "Miscellaneous- Speciality",
    "Miscellaneous-Apparel",
    "NonFR workwear/uniform",
    "Outdoor Goods",
    "Protective/FR Clothing",
    "Reseller/Distributor",
    "Saddlery",
    "Shoes & Upholestry",
    "Sports Goods",
    "Tea Bags",
    "Tents",
    "Terry Towels",
    "Travel Goods",
    "Tyre Cord",
    "Underwear/Intimates",
    "Wire & Cable",
  ];

  final rxSelectedBulkOrderLines = <DraftTableData>[].obs;

  final Database _database = Get.find();

  final UserController _userController = Get.find(tag: 'userController');

  String get b2bOrderNumber => 'B2BD-$orderNumber';

  BulkEntryController({required this.orderNumber}) {
    _database.managers.draftTable
        .filter(
          (f) => f.soldTo.equals(
            _userController.rxUserDetail.value.soldToNumber,
          ),
        )
        .filter(
          (f) => f.orderType.equals('DT'),
        )
        .filter((f) => f.orderNumber.equals(orderNumber))
        .orderBy(
          (o) => o.lineNumber.asc(),
        )
        .watch()
        .listen(
      (draftTableRows) {
        rxBulkOrderLines.clear();

        rxBulkOrderLines.addAll(draftTableRows);
      },
    );

    Api.fetchBuyerInfos().then(
      (buyerInfos) => _rxBuyerInfos.addAll(buyerInfos),
    );

    Api.fetchMerchandiserNames(
            soldToNumber: _userController.rxUserDetail.value.soldToNumber)
        .then(
      (merchandiserNames) => rxMerchandisers.addAll(merchandiserNames),
    );

    rxShade.listen(shadeListener);

    rxArticle.listen(
      (_) {
        selectIfOnlyOneOption(rxArticle.hashCode);

        resetShade();
      },
    );

    rxBrand.listen((_) => selectIfOnlyOneOption(rxBrand.hashCode));
    rxSubstrate.listen((_) => selectIfOnlyOneOption(rxSubstrate.hashCode));
    rxTex.listen((_) => selectIfOnlyOneOption(rxTex.hashCode));

    rxBuyerName.listen(buyerNameListener);

    rxOtherBuyerName.listen(otherBuyerListener);

    rxUomWithDesc.listen(uomWithDescListener);

    rxUom.listen((_) => selectIfOnlyOneOption(rxUom.hashCode));

    rxPoFileName.listen(poFileNameListener);
  }

  void poFileNameListener(String newPoFileName) {
    if (newPoFileName.isEmpty) {
      rxPoFileBytes.value = null;
    }
  }

  void uomWithDescListener(String newUomWithDesc) {
    if (newUomWithDesc.isNotEmpty) {
      rxUom.value = newUomWithDesc.split(' - ')[0];
    } else {
      rxUom.value = '';
    }

    resetShade();
  }

  void resetShade() {
    rxShade.value = '';

    rxShades.clear();

    final article = rxArticle.value.trim();

    final uom = rxUom.value.trim();

    if (article.isNotEmpty && uom.isNotEmpty) {
      Api.fetchShades(article: article, uom: uom).then(
        (shades) {
          rxShades.clear();

          rxShades.addAll(
            shades
                .where(
                  (shade) => !shade.startsWith('SWT'),
                )
                .toList()
              ..sort(),
          );
        },
      );
    }
  }

  void shadeListener(String newShade) {
    rxColor.value = '';

    rxUnitPrice.value = '';

    if (newShade.isNotEmpty) {
      final UserController userController = Get.find(tag: 'userController');

      Api.fetchUnitPrice(
        soldToNumber: userController.rxUserDetail.value.soldToNumber,
        shipToNumber: userController.rxUserDetail.value.soldToNumber,
        itemNumber: getItemNumber(
            article: rxArticle.value, uom: rxUom.value, shade: rxShade.value),
        businessUnit: userController.branchPlant,
        effectiveDate: DateTime.now(),
      ).then(
        (unitPrice) => rxUnitPrice.value = unitPrice?.toString() ?? '',
      );
    }
  }

  void buyerNameListener(String newBuyerName) {
    final buyerName = newBuyerName.trim();

    rxBuyerInfo.value = null;
    rxOtherBuyerName.value = '';
    _rxBuyerCode.value = '';
    rxFirstLightSource.value = '';
    rxSecondLightSource.value = '';

    if (buyerName.isNotEmpty && buyerName != 'OTHER') {
      final buyerInfo = _rxBuyerInfos.firstWhereOrNull(
        (buyerInfo) => buyerInfo.name == buyerName,
      );

      if (buyerInfo != null) {
        rxBuyerInfo.value = buyerInfo;
        _rxBuyerCode.value = buyerInfo.code;
        rxFirstLightSource.value = buyerInfo.firstLightSource;
        rxSecondLightSource.value = buyerInfo.secondLightSource;
      }
    }
  }

  void otherBuyerListener(String newOtherBuyerName) {
    final otherBuyerName = newOtherBuyerName.trim();

    rxBuyerInfo.value = null;
    _rxBuyerCode.value = '';
    rxFirstLightSource.value = '';
    rxSecondLightSource.value = '';

    if (otherBuyerName.isNotEmpty && buyerNames.contains(otherBuyerName)) {
      final buyerInfo = _rxBuyerInfos.firstWhereOrNull(
        (buyerInfo) => buyerInfo.name == otherBuyerName,
      );

      if (buyerInfo != null) {
        rxBuyerInfo.value = buyerInfo;
        _rxBuyerCode.value = buyerInfo.code;
        rxFirstLightSource.value = buyerInfo.firstLightSource;
        rxSecondLightSource.value = buyerInfo.secondLightSource;
      }
    }
  }

  bool get isLightSource1Enabled {
    if (rxBuyerInfo.value != null) {
      return rxBuyerInfo.value!.firstLightSource.trim().isEmpty;
    } else {
      return rxOtherBuyerName.value.trim().isNotEmpty;
    }
  }

  bool get isLightSource2Enabled {
    if (rxBuyerInfo.value != null) {
      return rxBuyerInfo.value!.secondLightSource.trim().isEmpty;
    } else {
      return rxOtherBuyerName.value.trim().isNotEmpty;
    }
  }

  bool get isSwatchShade =>
      rxShade.value.isNotEmpty && rxShade.value.startsWith('SWT');

  bool get isOtherBuyer => rxBuyerName.value == 'OTHER';

  List<String> get buyerNames =>
      ['OTHER', ..._rxBuyerInfos.map((buyerInfo) => buyerInfo.name)];

  List<String> get firstLightSources =>
      rxBuyerInfo.value?.firstLightSource.trim().isEmpty ?? true
          ? _otherLightSouces
              .where((lightSource) => lightSource != rxSecondLightSource.value)
              .toList()
          : [rxFirstLightSource.value];

  List<String> get secondLightSources =>
      rxBuyerInfo.value?.secondLightSource.trim().isEmpty ?? true
          ? _otherLightSouces
              .where((lightSource) => lightSource != rxFirstLightSource.value)
              .toList()
          : [rxSecondLightSource.value];

  void selectIfOnlyOneOption(int hashCode) {
    if (hashCode == rxArticle.hashCode && rxArticle.value.isEmpty) {
      rxUom.value = '';
      rxUomWithDesc.value = '';
      rxBrand.value = '';
      rxSubstrate.value = '';
      rxTex.value = '';
      rxTicket.value = '';
    } else if (hashCode == rxUom.hashCode && rxUom.value.isEmpty) {
      rxArticle.value = '';
      rxBrand.value = '';
      rxSubstrate.value = '';
      rxTex.value = '';
      rxTicket.value = '';
    } else if (hashCode == rxBrand.hashCode && rxBrand.value.isEmpty) {
      rxArticle.value = '';
      rxUom.value = '';
      rxUomWithDesc.value = '';
      rxSubstrate.value = '';
      rxTex.value = '';
      rxTicket.value = '';
    } else if (hashCode == rxSubstrate.hashCode && rxSubstrate.value.isEmpty) {
      rxArticle.value = '';
      rxUom.value = '';
      rxUomWithDesc.value = '';
      rxBrand.value = '';
      rxTex.value = '';
      rxTicket.value = '';
    } else if (hashCode == rxTex.hashCode && rxTex.value.isEmpty) {
      rxArticle.value = '';
      rxUom.value = '';
      rxUomWithDesc.value = '';
      rxBrand.value = '';
      rxSubstrate.value = '';
      rxTicket.value = '';
    } else {
      if (hashCode != rxArticle.hashCode &&
          uniqueFilteredArticles.length == 1) {
        rxArticle.value = uniqueFilteredArticles.first;
      }

      if (hashCode != rxUom.hashCode && rxUom.isEmpty) {
        if ((hashCode == rxArticle.hashCode && uniqueFilteredUoms.isNotEmpty) ||
            uniqueFilteredUoms.length == 1) {
          rxUom.value = uniqueFilteredUoms.first;

          rxUomWithDesc.value =
              '${rxUom.value} - ${orderReviewController.getUomDescription(rxUom.value)}';
        }
      }

      if (hashCode != rxBrand.hashCode && uniqueFilteredBrands.length == 1) {
        rxBrand.value = uniqueFilteredBrands.first;
      }

      if (hashCode != rxSubstrate.hashCode &&
          uniqueFilteredSubstrates.length == 1) {
        rxSubstrate.value = uniqueFilteredSubstrates.first;
      }

      if (hashCode != rxTex.hashCode && uniqueFilteredTexs.length == 1) {
        rxTex.value = uniqueFilteredTexs.first;
      }

      if (uniqueFilteredTickets.length == 1) {
        rxTicket.value = uniqueFilteredTickets.first;
      } else {
        rxTicket.value = '';
      }
    }
  }

  bool get canAddOrderLine =>
      rxShade.isNotEmpty &&
      (!isSwatchShade || rxColor.isNotEmpty) &&
      buyerOrOtherName.isNotEmpty &&
      rxMerchandiser.isNotEmpty &&
      rxFirstLightSource.value.isNotEmpty &&
      rxArticle.value.isNotEmpty;

  String get _colorRemark => [
        if (rxColor.value.trim().isNotEmpty) rxColor.value,
        if (rxRemark.value.trim().isNotEmpty) rxRemark.value,
        if (rxL.value.trim().isNotEmpty) rxL.value,
        if (rxRequestType.value.isNotEmpty) rxRequestType.value,
        if (rxEndUse.value.isNotEmpty) rxEndUse.value,
      ].join('|');

  int get _lastLineNumber => rxBulkOrderLines.lastOrNull?.lineNumber ?? 0;

  bool validateInputs() {
    inputsInError.clear();

    if (rxUom.value.trim().isEmpty) {
      inputsInError.add(rxUom);
    }

    if (rxMerchandiser.value.trim().isEmpty) {
      inputsInError.add(rxMerchandiser);
    }

    if (rxBuyerName.value.trim().isEmpty) {
      inputsInError.add(rxBuyerName);
    }

    if (isOtherBuyer && rxOtherBuyerName.value.trim().isEmpty) {
      inputsInError.add(rxOtherBuyerName);
    }

    if (rxFirstLightSource.value.trim().isEmpty) {
      inputsInError.add(rxFirstLightSource);
    }

    if (rxArticle.value.trim().isEmpty) {
      inputsInError.add(rxArticle);
    }

    if (rxShade.value.trim().isEmpty) {
      inputsInError.add(rxShade);
    }

    if (rxQuantity.value.trim().isEmpty) {
      inputsInError.add(rxQuantity);
    }

    if (rxPoNumber.value.trim().isEmpty) {
      inputsInError.add(rxPoNumber);
    }

    return inputsInError.isEmpty;
  }

  void addBulkOrderLine() {
    if (!validateInputs()) {
      // toastification.show(
      //   autoCloseDuration: Duration(seconds: 5),
      //   primaryColor: VardhmanColors.red,
      //   title: Text('Please fill all the required fields'),
      // );
    } else if (rxBulkOrderLines.any(
      (bulkOrderLine) =>
          bulkOrderLine.article == rxArticle.value &&
          bulkOrderLine.shade == rxShade.value,
    )) {
      toastification.show(
        autoCloseDuration: Duration(seconds: 5),
        primaryColor: VardhmanColors.red,
        title: Text('Duplicate Article and Shade combination'),
      );
    } else {
      _database.managers.draftTable.create(
        (o) => o(
          article: rxArticle.value,
          billingType: rxBillingType.value,
          brand: rxBrand.value,
          buyer: buyerOrOtherName,
          buyerCode: _rxBuyerCode.value,
          colorName: rxColor.value,
          remark: rxRemark.value,
          endUse: rxEndUse.value,
          firstLightSource: rxFirstLightSource.value,
          lab: '${rxL.value},${rxA.value},${rxB.value}',
          lineNumber: _lastLineNumber + 1,
          orderNumber: orderNumber,
          orderType: 'DT',
          quantity: int.tryParse(rxQuantity.value) ?? 1,
          requestType: rxRequestType.value,
          secondLightSource: rxSecondLightSource.value,
          shade: rxShade.value,
          soldTo: _userController.rxUserDetail.value.soldToNumber,
          substrate: rxSubstrate.value,
          tex: rxTex.value,
          ticket: rxTicket.value,
          uom: rxUom.value,
          colorRemark: _colorRemark,
          lastUpdated: DateTime.now(),
          merchandiser: rxMerchandiser.value,
          qtxFileName: '',
          requestedDate: drift.Value(rxRequestedDate.value),
          poNumber: rxPoNumber.value,
          poFileName: rxPoFileName.value,
          poFileBytes: drift.Value(rxPoFileBytes.value),
          unitPrice: drift.Value(double.tryParse(rxUnitPrice.value)),
        ),
        mode: drift.InsertMode.insertOrReplace,
      );

      clearAllInputs(
        skipHashCodes: [
          rxMerchandiser.hashCode,
          rxBuyerName.hashCode,
          if (isOtherBuyer) rxOtherBuyerName.hashCode,
          rxFirstLightSource.hashCode,
          rxSecondLightSource.hashCode,
          rxEndUse.hashCode,
          rxRequestedDate.hashCode,
        ],
      );
    }
  }

  String get buyerOrOtherName =>
      isOtherBuyer ? rxOtherBuyerName.value : rxBuyerName.value;

  void updateBulkOrderLine() {
    if (!validateInputs()) {
      // toastification.show(
      //   autoCloseDuration: Duration(seconds: 5),
      //   primaryColor: VardhmanColors.red,
      //   title: Text('Please fill all the required fields'),
      // );
    } else {
      final selectedBulkOrderLine = rxSelectedBulkOrderLines.firstOrNull;

      if (selectedBulkOrderLine != null) {
        _database.managers.draftTable
            .filter((f) => f.orderNumber.equals(orderNumber))
            .filter(
                (f) => f.lineNumber.equals(selectedBulkOrderLine.lineNumber))
            .update(
              (o) => o(
                article: drift.Value(rxArticle.value),
                billingType: drift.Value(rxBillingType.value),
                brand: drift.Value(rxBrand.value),
                buyer: drift.Value(buyerOrOtherName),
                buyerCode: drift.Value(_rxBuyerCode.value),
                colorName: drift.Value(rxColor.value),
                remark: drift.Value(rxRemark.value),
                endUse: drift.Value(rxEndUse.value),
                firstLightSource: drift.Value(rxFirstLightSource.value),
                lineNumber: drift.Value(selectedBulkOrderLine.lineNumber),
                orderNumber: drift.Value(selectedBulkOrderLine.orderNumber),
                orderType: drift.Value(selectedBulkOrderLine.orderType),
                quantity: drift.Value(int.tryParse(rxQuantity.value) ?? 1),
                requestType: drift.Value(rxRequestType.value),
                secondLightSource: drift.Value(rxSecondLightSource.value),
                shade: drift.Value(rxShade.value),
                soldTo: drift.Value(
                    _userController.rxUserDetail.value.soldToNumber),
                substrate: drift.Value(rxSubstrate.value),
                tex: drift.Value(rxTex.value),
                ticket: drift.Value(rxTicket.value),
                uom: drift.Value(rxUom.value),
                colorRemark: drift.Value(_colorRemark),
                lastUpdated: drift.Value(DateTime.now()),
                merchandiser: drift.Value(rxMerchandiser.value),
                requestedDate: drift.Value(rxRequestedDate.value),
                poNumber: drift.Value(rxPoNumber.value),
                poFileName: drift.Value(rxPoFileName.value),
                poFileBytes: drift.Value(rxPoFileBytes.value),
                unitPrice: drift.Value(double.tryParse(rxUnitPrice.value)),
              ),
            );
      }

      rxSelectedBulkOrderLines.clear();

      clearAllInputs(
        skipHashCodes: [
          rxMerchandiser.hashCode,
          rxBuyerName.hashCode,
          if (isOtherBuyer) rxOtherBuyerName.hashCode,
          rxFirstLightSource.hashCode,
          rxSecondLightSource.hashCode,
          rxEndUse.hashCode,
          rxRequestedDate.hashCode,
        ],
      );
    }
  }

  void deleteSelectedLines() {
    for (DraftTableData bulkOrderLine in rxSelectedBulkOrderLines) {
      _database.managers.draftTable
          .filter((f) => f.orderNumber.equals(orderNumber))
          .filter((f) => f.lineNumber.equals(bulkOrderLine.lineNumber))
          .delete();
    }

    rxSelectedBulkOrderLines.clear();
  }

  bool get canClearInputs =>
      rxMerchandiser.value != '' ||
      rxBuyerName.value != '' ||
      rxOtherBuyerName.value != '' ||
      rxFirstLightSource.value != '' ||
      rxSecondLightSource.value != '' ||
      rxArticle.value != '' ||
      rxUomWithDesc.value != '' ||
      rxTicket.value != '' ||
      rxBrand.value != '' ||
      rxTex.value != '' ||
      rxSubstrate.value != '' ||
      rxShade.value != '' ||
      rxColor.value != '' ||
      rxQuantity.value != '' ||
      rxRequestedDate.value != null ||
      rxRemark.value != '' ||
      rxPoNumber.value != '' ||
      rxPoFileName.value != '';

  void clearAllInputs({List<int> skipHashCodes = const []}) {
    if (!skipHashCodes.contains(rxMerchandiser.hashCode)) {
      rxMerchandiser.value = '';
    }
    if (!skipHashCodes.contains(rxBuyerName.hashCode)) {
      rxBuyerName.value = '';
    }
    if (!skipHashCodes.contains(rxOtherBuyerName.hashCode)) {
      rxOtherBuyerName.value = '';
    }
    if (!skipHashCodes.contains(rxFirstLightSource.hashCode)) {
      rxFirstLightSource.value = '';
    }
    if (!skipHashCodes.contains(rxSecondLightSource.hashCode)) {
      rxSecondLightSource.value = '';
    }
    if (!skipHashCodes.contains(rxArticle.hashCode)) {
      rxArticle.value = '';
    }
    if (!skipHashCodes.contains(rxUomWithDesc.hashCode)) {
      rxUomWithDesc.value = '';
    }
    if (!skipHashCodes.contains(rxTicket.hashCode)) {
      rxTicket.value = '';
    }
    if (!skipHashCodes.contains(rxBrand.hashCode)) {
      rxBrand.value = '';
    }
    if (!skipHashCodes.contains(rxTex.hashCode)) {
      rxTex.value = '';
    }
    if (!skipHashCodes.contains(rxSubstrate.hashCode)) {
      rxSubstrate.value = '';
    }
    if (!skipHashCodes.contains(rxShade.hashCode)) {
      rxShade.value = '';
    }
    if (!skipHashCodes.contains(rxColor.hashCode)) {
      rxColor.value = '';
    }
    if (!skipHashCodes.contains(rxQuantity.hashCode)) {
      rxQuantity.value = '';
    }
    if (!skipHashCodes.contains(rxRequestedDate.hashCode)) {
      rxRequestedDate.value = null;
    }
    if (!skipHashCodes.contains(rxRemark.hashCode)) {
      rxRemark.value = '';
    }
    if (!skipHashCodes.contains(rxPoNumber.hashCode)) {
      rxPoNumber.value = '';
    }
    if (!skipHashCodes.contains(rxPoFileName.hashCode)) {
      rxPoFileName.value = '';
    }
  }

  List<String> get uniqueFilteredArticles => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
            (rxUom.value.isNotEmpty
                ? itemCatalogInfo.uom == (rxUom.value)
                : true) &&
            (rxBrand.value.isNotEmpty
                ? itemCatalogInfo.brandDesc == (rxBrand.value)
                : true) &&
            (rxSubstrate.value.isNotEmpty
                ? itemCatalogInfo.substrateDesc == (rxSubstrate.value)
                : true) &&
            (rxTex.value.isNotEmpty
                ? itemCatalogInfo.tex == (rxTex.value)
                : true),
      )
      .map((e) => e.article)
      .toSet()
      .toList();

  List<String> get uniqueFilteredUoms => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
            (rxArticle.value.isNotEmpty
                ? itemCatalogInfo.article == (rxArticle.value)
                : true) &&
            (rxBrand.value.isNotEmpty
                ? itemCatalogInfo.brandDesc == (rxBrand.value)
                : true) &&
            (rxSubstrate.value.isNotEmpty
                ? itemCatalogInfo.substrateDesc == (rxSubstrate.value)
                : true) &&
            (rxTex.value.isNotEmpty
                ? itemCatalogInfo.tex == (rxTex.value)
                : true),
      )
      .map((e) => e.uom)
      .toSet()
      .toList();

  List<String> get uniqueFilteredBrands => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
            (rxArticle.value.isNotEmpty
                ? itemCatalogInfo.article == (rxArticle.value)
                : true) &&
            (rxUom.value.isNotEmpty
                ? itemCatalogInfo.uom == (rxUom.value)
                : true) &&
            (rxSubstrate.value.isNotEmpty
                ? itemCatalogInfo.substrateDesc == (rxSubstrate.value)
                : true) &&
            (rxTex.value.isNotEmpty
                ? itemCatalogInfo.tex == (rxTex.value)
                : true),
      )
      .map((e) => e.brandDesc)
      .toSet()
      .toList();

  List<String> get uniqueFilteredSubstrates => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
            (rxArticle.value.isNotEmpty
                ? itemCatalogInfo.article == (rxArticle.value)
                : true) &&
            (rxUom.value.isNotEmpty
                ? itemCatalogInfo.uom == (rxUom.value)
                : true) &&
            (rxBrand.value.isNotEmpty
                ? itemCatalogInfo.brandDesc == (rxBrand.value)
                : true) &&
            (rxTex.value.isNotEmpty
                ? itemCatalogInfo.tex == (rxTex.value)
                : true),
      )
      .map((e) => e.substrateDesc)
      .toSet()
      .toList();

  List<String> get uniqueFilteredTexs => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
            (rxArticle.value.isNotEmpty
                ? itemCatalogInfo.article == (rxArticle.value)
                : true) &&
            (rxUom.value.isNotEmpty
                ? itemCatalogInfo.uom == (rxUom.value)
                : true) &&
            (rxBrand.value.isNotEmpty
                ? itemCatalogInfo.brandDesc == (rxBrand.value)
                : true) &&
            (rxSubstrate.value.isNotEmpty
                ? itemCatalogInfo.substrateDesc == (rxSubstrate.value)
                : true),
      )
      .map((e) => e.tex)
      .toSet()
      .toList();

  List<String> get uniqueFilteredTickets => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
            (rxArticle.value.isNotEmpty
                ? itemCatalogInfo.article == (rxArticle.value)
                : true) &&
            (rxUom.value.isNotEmpty
                ? itemCatalogInfo.uom == (rxUom.value)
                : true) &&
            (rxBrand.value.isNotEmpty
                ? itemCatalogInfo.brandDesc == (rxBrand.value)
                : true) &&
            (rxSubstrate.value.isNotEmpty
                ? itemCatalogInfo.substrateDesc == (rxSubstrate.value)
                : true) &&
            (rxTex.value.isNotEmpty
                ? itemCatalogInfo.tex == (rxTex.value)
                : true),
      )
      .map((e) => e.ticket)
      .toSet()
      .toList();

  Future<void> submitOrder() async {
    for (var bulkOrderLine in rxBulkOrderLines) {
      if (bulkOrderLine.poFileName.isNotEmpty &&
          bulkOrderLine.poFileBytes != null) {
        final lineNumber = (rxBulkOrderLines.indexOf(bulkOrderLine) + 1) + 1000;

        await Api.uploadMediaAttachment(
          fileBytes: bulkOrderLine.poFileBytes!,
          fileName: bulkOrderLine.poFileName,
          moKey: 'QTX|QT|||$lineNumber|0|DT|$b2bOrderNumber',
          moStructure: 'GT00092',
          version: 'VYTL0016',
          formName: 'P00092_W00092D',
        );
      }
    }

    final isSubmitted = await orderReviewController.submitBulkOrder(
      b2bOrderNumber: b2bOrderNumber,
      merchandiserName: rxMerchandiser.value,
      bulkEntryLines: rxBulkOrderLines,
    );

    if (isSubmitted) {
      _database.managers.draftTable
          .filter((f) => f.orderNumber.equals(orderNumber))
          .delete();

      Get.back();
    }
  }

  bool get canSubmit =>
      rxMerchandiser.value.isNotEmpty && rxBulkOrderLines.isNotEmpty;

  void selectBulkOrderLine(DraftTableData bulkOrderLine) {
    if (rxSelectedBulkOrderLines.contains(bulkOrderLine)) {
      rxSelectedBulkOrderLines.remove(bulkOrderLine);
    } else {
      rxSelectedBulkOrderLines.add(bulkOrderLine);

      if (rxSelectedBulkOrderLines.length == 1) {
        clearAllInputs();

        _populateInputs(bulkOrderLine: rxSelectedBulkOrderLines.first);
      }
    }
  }

  void _populateInputs({required DraftTableData bulkOrderLine}) {
    final isOtherBuyer = !buyerNames.contains(bulkOrderLine.buyer);
    rxMerchandiser.value = bulkOrderLine.merchandiser;
    rxBuyerName.value = isOtherBuyer ? 'OTHER' : bulkOrderLine.buyer;
    rxOtherBuyerName.value = isOtherBuyer ? bulkOrderLine.buyer : '';
    _rxBuyerCode.value = bulkOrderLine.buyerCode;
    rxFirstLightSource.value = bulkOrderLine.firstLightSource;
    rxSecondLightSource.value = bulkOrderLine.secondLightSource;
    rxSubstrate.value = bulkOrderLine.substrate;
    rxTicket.value = bulkOrderLine.ticket;
    rxTex.value = bulkOrderLine.tex;
    rxArticle.value = bulkOrderLine.article;
    rxBrand.value = bulkOrderLine.brand;
    rxRemark.value = bulkOrderLine.remark;
    rxRequestType.value = bulkOrderLine.requestType;
    rxEndUse.value = bulkOrderLine.endUse;
    rxShade.value = bulkOrderLine.shade;
    rxColor.value = bulkOrderLine.colorName;
    rxQuantity.value = bulkOrderLine.quantity.toString();
    rxUomWithDesc.value =
        '${bulkOrderLine.uom} - ${orderReviewController.getUomDescription(bulkOrderLine.uom)}';
    rxRequestedDate.value = bulkOrderLine.requestedDate;
    rxPoFileName.value = bulkOrderLine.poFileName;
    rxPoNumber.value = bulkOrderLine.poNumber;
    rxPoFileBytes.value = bulkOrderLine.poFileBytes;
  }

  bool get merchandiserHasError => inputsInError.contains(rxMerchandiser);

  bool get buyerNameHasError => inputsInError.contains(rxBuyerName);

  bool get otherBuyerNameHasError => inputsInError.contains(rxOtherBuyerName);

  bool get firstLightSourceHasError =>
      inputsInError.contains(rxFirstLightSource);

  bool get articleHasError => inputsInError.contains(rxArticle);

  bool get shadeHasError => inputsInError.contains(rxShade);

  bool get colorHasError => inputsInError.contains(rxColor);

  bool get uomHasError => inputsInError.contains(rxUom);

  bool get quantityHasError => inputsInError.contains(rxQuantity);

  bool get poNumberHasError => inputsInError.contains(rxPoNumber);
}
