import 'dart:developer';

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

class LabdipEntryController extends GetxController {
  final int orderNumber;

  final _rxMerchandisers = <String>[].obs;

  final rxMerchandiser = ''.obs;

  final rxOtherMerchandiser = ''.obs;

  final rxColor = ''.obs;

  final rxShade = ''.obs;

  final rxBuyerName = ''.obs;

  final _rxBuyerCode = ''.obs;

  final rxFirstLightSource = ''.obs;

  final rxSecondLightSource = ''.obs;

  final rxOtherBuyer = ''.obs;

  final rxSubstrate = ''.obs;

  final rxTicket = ''.obs;

  final rxTex = ''.obs;

  final rxArticle = ''.obs;

  final rxBrand = ''.obs;

  final rxL = ''.obs;

  final rxA = ''.obs;

  final rxB = ''.obs;

  final rxRemark = ''.obs;

  final rxLabdipOrderLines = <DraftTableData>[].obs;

  final catalogController = Get.find<CatalogController>();

  final _rxBuyerInfos = <BuyerInfo>[].obs;

  final rxBillingType = 'Branch'.obs;

  final billingTypes = ['Branch', 'Plant'];

  final rxRequestType = ''.obs;

  final requestTypes = ['Stitching', 'Embroidery'];

  final rxEndUse = ''.obs;

  final rxShades = <String>[].obs;

  final _swatchShades = <String>[
    'SWT',
    ...List.generate(9, (index) => 'SWT${index + 1}'),
  ];

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

  final rxSelectedLabdipOrderLines = <DraftTableData>[].obs;

  final Database _database = Get.find();

  final UserController _userController = Get.find(tag: 'userController');

  String get b2bOrderNumber => 'B2BL-$orderNumber';

  LabdipEntryController({required this.orderNumber}) {
    _database.managers.draftTable
        .filter(
          (f) => f.soldTo.equals(
            _userController.rxUserDetail.value.soldToNumber,
          ),
        )
        .filter(
          (f) => f.orderType.equals('LD'),
        )
        .filter((f) => f.orderNumber.equals(orderNumber))
        .orderBy(
          (o) => o.lineNumber.asc(),
        )
        .watch()
        .listen(
      (draftTableRows) {
        rxLabdipOrderLines.clear();

        rxLabdipOrderLines.addAll(draftTableRows);

        clearInputs();

        _populateInputs(labdipOrderLine: draftTableRows.last);
      },
    );

    Api.fetchBuyerInfos().then(
      (buyerInfos) => _rxBuyerInfos.addAll(buyerInfos),
    );

    Api.fetchMerchandiserNames(
            soldToNumber: _userController.rxUserDetail.value.soldToNumber)
        .then(
      (merchandiserNames) => _rxMerchandisers.addAll(merchandiserNames),
    );

    rxBuyerName.listen(
      (buyerName) {
        if (buyerName.isEmpty || buyerName == 'OTHER') {
          _rxBuyerCode.value = '';
          rxFirstLightSource.value = '';
          rxSecondLightSource.value = '';
        } else {
          final buyerInfo = _rxBuyerInfos.firstWhereOrNull(
            (buyerInfo) => buyerInfo.name == buyerName,
          );

          if (buyerInfo != null) {
            _rxBuyerCode.value = buyerInfo.code;
            rxFirstLightSource.value = buyerInfo.firstLightSource;
            rxSecondLightSource.value = buyerInfo.secondLightSource;
          }
        }
      },
    );

    rxArticle.listen(
      (newArticle) {
        selectIfOnlyOneOption(rxArticle.hashCode);

        rxShade.value = '';

        rxShades.clear();

        final article = newArticle.trim();

        if (article.isNotEmpty) {
          Api.fetchShades(article: article, uom: 'AC').then(
            (shades) {
              rxShades.addAll(_swatchShades);

              rxShades.addAll(shades);
            },
          );
        }
      },
    );

    rxBrand.listen((_) => selectIfOnlyOneOption(rxBrand.hashCode));
    rxSubstrate.listen((_) => selectIfOnlyOneOption(rxSubstrate.hashCode));
    rxTex.listen((_) => selectIfOnlyOneOption(rxTex.hashCode));
  }

  bool get isSwatchShade =>
      rxShade.value.isNotEmpty && _swatchShades.contains(rxShade.value);

  bool get isOtherBuyer => rxBuyerName.value == 'OTHER';

  bool get isOtherMerchandiser => rxMerchandiser.value == 'OTHER';

  List<String> get buyerNames =>
      ['OTHER', ..._rxBuyerInfos.map((buyerInfo) => buyerInfo.name)];

  List<String> get merchandiserNames => ['OTHER', ..._rxMerchandisers];

  List<String> get _allLightSouces => _rxBuyerInfos
      .mapMany((buyerInfo) =>
          [buyerInfo.firstLightSource, buyerInfo.secondLightSource])
      .toSet()
      .toList();

  List<String> get firstLightSources => isOtherBuyer
      ? _allLightSouces
          .where((lightSource) => lightSource != rxSecondLightSource.value)
          .toList()
      : [rxFirstLightSource.value];

  List<String> get secondLightSources => isOtherBuyer
      ? _allLightSouces
          .where((lightSource) => lightSource != rxFirstLightSource.value)
          .toList()
      : [rxSecondLightSource.value];

  void selectIfOnlyOneOption(int hashCode) {
    if (hashCode == rxArticle.hashCode && rxArticle.value.isEmpty) {
      rxBrand.value = '';
      rxSubstrate.value = '';
      rxTex.value = '';
      rxTicket.value = '';
    } else if (hashCode == rxBrand.hashCode && rxBrand.value.isEmpty) {
      rxArticle.value = '';
      rxSubstrate.value = '';
      rxTex.value = '';
      rxTicket.value = '';
    } else if (hashCode == rxSubstrate.hashCode && rxSubstrate.value.isEmpty) {
      rxArticle.value = '';
      rxBrand.value = '';
      rxTex.value = '';
      rxTicket.value = '';
    } else if (hashCode == rxTex.hashCode && rxTex.value.isEmpty) {
      rxArticle.value = '';
      rxBrand.value = '';
      rxSubstrate.value = '';
      rxTicket.value = '';
    } else {
      if (hashCode != rxArticle.hashCode &&
          uniqueFilteredArticles.length == 1) {
        rxArticle.value = uniqueFilteredArticles.first;
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
      _buyerName.isNotEmpty &&
      merchandiser.isNotEmpty &&
      rxFirstLightSource.value.isNotEmpty &&
      rxSecondLightSource.value.isNotEmpty &&
      rxArticle.value.isNotEmpty;

  String get _colorRemark => [
        if (rxColor.value.trim().isNotEmpty) rxColor.value,
        if (rxRemark.value.trim().isNotEmpty) rxRemark.value,
        if (rxL.value.trim().isNotEmpty) rxL.value,
        if (rxRequestType.value.isNotEmpty) rxRequestType.value,
        if (rxEndUse.value.isNotEmpty) rxEndUse.value,
      ].join('|');

  int get _lastLineNumber => rxLabdipOrderLines.lastOrNull?.lineNumber ?? 0;

  void addLapdipOrderLine() {
    if (rxLabdipOrderLines.any(
      (labdipOrderLine) =>
          labdipOrderLine.article == rxArticle.value &&
          labdipOrderLine.shade == rxShade.value,
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
          buyer: _buyerName,
          buyerCode: _rxBuyerCode.value,
          colorName: rxColor.value,
          remark: rxRemark.value,
          endUse: rxEndUse.value,
          firstLightSource: rxFirstLightSource.value,
          lab: '${rxL.value},${rxA.value},${rxB.value}',
          lineNumber: _lastLineNumber + 1,
          orderNumber: orderNumber,
          orderType: 'LD',
          quantity: 1,
          requestType: rxRequestType.value,
          secondLightSource: rxSecondLightSource.value,
          shade: rxShade.value,
          soldTo: _userController.rxUserDetail.value.soldToNumber,
          substrate: rxSubstrate.value,
          tex: rxTex.value,
          ticket: rxTicket.value,
          uom: uom,
          colorRemark: _colorRemark,
          lastUpdated: DateTime.now(),
          merchandiser: merchandiser,
        ),
        mode: drift.InsertMode.insertOrReplace,
      );

      clearInputs();
    }
  }

  String get _buyerName =>
      isOtherBuyer ? rxOtherBuyer.value : rxBuyerName.value;

  String get merchandiser =>
      isOtherMerchandiser ? rxOtherMerchandiser.value : rxMerchandiser.value;

  void updateLapdipOrderLine() {
    final selectedLabdipOrderLine = rxSelectedLabdipOrderLines.firstOrNull;

    if (selectedLabdipOrderLine != null) {
      _database.managers.draftTable
          .filter((f) => f.orderNumber.equals(orderNumber))
          .filter(
              (f) => f.lineNumber.equals(selectedLabdipOrderLine.lineNumber))
          .update(
            (o) => o(
              article: drift.Value(rxArticle.value),
              billingType: drift.Value(rxBillingType.value),
              brand: drift.Value(rxBrand.value),
              buyer: drift.Value(_buyerName),
              buyerCode: drift.Value(_rxBuyerCode.value),
              colorName: drift.Value(rxColor.value),
              remark: drift.Value(rxRemark.value),
              endUse: drift.Value(rxEndUse.value),
              firstLightSource: drift.Value(rxFirstLightSource.value),
              lab: drift.Value('${rxL.value},${rxA.value},${rxB.value}'),
              lineNumber: drift.Value(selectedLabdipOrderLine.lineNumber),
              orderNumber: drift.Value(selectedLabdipOrderLine.orderNumber),
              orderType: drift.Value(selectedLabdipOrderLine.orderType),
              quantity: drift.Value(selectedLabdipOrderLine.quantity),
              requestType: drift.Value(rxRequestType.value),
              secondLightSource: drift.Value(rxSecondLightSource.value),
              shade: drift.Value(rxShade.value),
              soldTo:
                  drift.Value(_userController.rxUserDetail.value.soldToNumber),
              substrate: drift.Value(rxSubstrate.value),
              tex: drift.Value(rxTex.value),
              ticket: drift.Value(rxTicket.value),
              uom: drift.Value(uom),
              colorRemark: drift.Value(_colorRemark),
              lastUpdated: drift.Value(DateTime.now()),
              merchandiser: drift.Value(merchandiser),
            ),
          );
    }

    rxSelectedLabdipOrderLines.clear();

    clearInputs();
  }

  void deleteSelectedLines() {
    for (DraftTableData labdipOrderLine in rxSelectedLabdipOrderLines) {
      _database.managers.draftTable
          .filter((f) => f.orderNumber.equals(orderNumber))
          .filter((f) => f.lineNumber.equals(labdipOrderLine.lineNumber))
          .delete();
    }

    rxSelectedLabdipOrderLines.clear();
  }

  String get uom {
    String? uom;

    final sameArticleIndustryItems = catalogController.industryItems
        .where(
          (itemCatalogInfo) => itemCatalogInfo.article == rxArticle.value,
        )
        .toList();

    try {
      if (sameArticleIndustryItems.any(
        (itemCatalogInfo) => itemCatalogInfo.uom == 'AC',
      )) {
        uom = 'AC';
      } else {
        uom = sameArticleIndustryItems.firstOrNull?.uom;
      }
    } catch (error) {
      log(error.toString());
    }

    return uom ?? '';
  }

  bool get canClearInputs =>
      rxColor.value != '' ||
      rxEndUse.value != '' ||
      rxRequestType.value != '' ||
      rxL.value != '' ||
      rxA.value != '' ||
      rxB.value != '' ||
      rxRemark.value != '' ||
      rxSubstrate.value != '' ||
      rxTicket.value != '' ||
      rxTex.value != '' ||
      rxBrand.value != '' ||
      rxArticle.value != '' ||
      rxShade.value != '' ||
      rxMerchandiser.value != '' ||
      rxOtherMerchandiser.value != '' ||
      rxBuyerName.value != '' ||
      rxOtherBuyer.value != '' ||
      _rxBuyerCode.value != '' ||
      rxFirstLightSource.value != '' ||
      rxSecondLightSource.value != '';

  void clearInputs() {
    rxColor.value = '';
    rxEndUse.value = '';
    rxRequestType.value = '';
    rxL.value = '';
    rxA.value = '';
    rxB.value = '';
    rxRemark.value = '';
    rxSubstrate.value = '';
    rxTicket.value = '';
    rxTex.value = '';
    rxBrand.value = '';
    rxArticle.value = '';
    rxShade.value = '';
    rxMerchandiser.value = '';
    rxOtherMerchandiser.value = '';
    rxBuyerName.value = '';
    rxOtherBuyer.value = '';
    _rxBuyerCode.value = '';
    rxFirstLightSource.value = '';
    rxSecondLightSource.value = '';
  }

  List<String> get uniqueFilteredArticles => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
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

  List<String> get uniqueFilteredBrands => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
            (rxArticle.value.isNotEmpty
                ? itemCatalogInfo.article == (rxArticle.value)
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
            (rxBrand.value.isNotEmpty
                ? itemCatalogInfo.brandDesc == (rxBrand.value)
                : true) &&
            (rxArticle.value.isNotEmpty
                ? itemCatalogInfo.article == (rxArticle.value)
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
            (rxBrand.value.isNotEmpty
                ? itemCatalogInfo.brandDesc == (rxBrand.value)
                : true) &&
            (rxArticle.value.isNotEmpty
                ? itemCatalogInfo.article == (rxArticle.value)
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
            (rxBrand.value.isNotEmpty
                ? itemCatalogInfo.brandDesc == (rxBrand.value)
                : true) &&
            (rxArticle.value.isNotEmpty
                ? itemCatalogInfo.article == (rxArticle.value)
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
    final OrderReviewController orderReviewController =
        Get.find<OrderReviewController>();

    final isSubmitted = await orderReviewController.submitLabdipOrder(
      b2bOrderNumber: b2bOrderNumber,
      merchandiserName: rxMerchandiser.value,
      labdipOrderLines: rxLabdipOrderLines,
    );

    if (isSubmitted) {
      _database.managers.draftTable
          .filter((f) => f.orderNumber.equals(orderNumber))
          .delete();

      Get.back();
    }
  }

  bool get canSubmit =>
      rxMerchandiser.value.isNotEmpty && rxLabdipOrderLines.isNotEmpty;

  void selectLabdipOrderLine(DraftTableData labdipOrderLine) {
    if (rxSelectedLabdipOrderLines.contains(labdipOrderLine)) {
      rxSelectedLabdipOrderLines.remove(labdipOrderLine);
    } else {
      rxSelectedLabdipOrderLines.add(labdipOrderLine);
    }

    if (rxSelectedLabdipOrderLines.length == 1) {
      clearInputs();

      _populateInputs(labdipOrderLine: rxSelectedLabdipOrderLines.first);
    }
  }

  void _populateInputs({required DraftTableData labdipOrderLine}) {
    final labParts = labdipOrderLine.lab.split(',');
    final isOtherBuyer = !buyerNames.contains(labdipOrderLine.buyer);
    final isOtherMerchandiser =
        !merchandiserNames.contains(labdipOrderLine.merchandiser);
    rxMerchandiser.value =
        isOtherMerchandiser ? 'OTHER' : labdipOrderLine.merchandiser;
    rxOtherMerchandiser.value =
        isOtherMerchandiser ? labdipOrderLine.merchandiser : '';
    rxColor.value = labdipOrderLine.colorName;
    rxBuyerName.value = isOtherBuyer ? 'OTHER' : labdipOrderLine.buyer;
    rxOtherBuyer.value = isOtherBuyer ? labdipOrderLine.buyer : '';
    _rxBuyerCode.value = labdipOrderLine.buyerCode;
    rxFirstLightSource.value = labdipOrderLine.firstLightSource;
    rxSecondLightSource.value = labdipOrderLine.secondLightSource;
    rxSubstrate.value = labdipOrderLine.substrate;
    rxTicket.value = labdipOrderLine.ticket;
    rxTex.value = labdipOrderLine.tex;
    rxArticle.value = labdipOrderLine.article;
    rxBrand.value = labdipOrderLine.brand;
    rxL.value = labParts[0];
    rxA.value = labParts[1];
    rxB.value = labParts[2];
    rxRemark.value = labdipOrderLine.remark;
    rxRequestType.value = labdipOrderLine.requestType;
    rxEndUse.value = labdipOrderLine.endUse;
    rxShade.value = labdipOrderLine.shade;
  }
}
