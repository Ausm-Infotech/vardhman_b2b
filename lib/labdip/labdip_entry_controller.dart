import 'dart:developer';

import 'package:drift/drift.dart' as drift;
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/buyer_info.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class LabdipEntryController extends GetxController {
  final int orderNumber;

  final rxMerchandiser = ''.obs;

  final rxColor = ''.obs;

  final rxShade = 'SWT'.obs;

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

  final rxRemark = ''.obs;

  final rxLAB = ''.obs;

  final rxComment = ''.obs;

  final rxLabdipOrderLines = <DraftTableData>[].obs;

  final catalogController = Get.find<CatalogController>();

  final _rxBuyerInfos = <BuyerInfo>[].obs;

  final rxBillingType = 'Branch'.obs;

  final billingTypes = ['Branch', 'Plant'];

  final rxRequestType = ''.obs;

  final requestTypes = ['Stitching', 'Embroidery'];

  final rxEndUse = ''.obs;

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
      },
    );

    Api.fetchBuyerInfos().then(
      (buyerInfos) => _rxBuyerInfos.addAll(buyerInfos),
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

    rxArticle.listen((_) => selectIfOnlyOneOption(rxArticle.hashCode));
    rxBrand.listen((_) => selectIfOnlyOneOption(rxBrand.hashCode));
    rxSubstrate.listen((_) => selectIfOnlyOneOption(rxSubstrate.hashCode));
    rxTex.listen((_) => selectIfOnlyOneOption(rxTex.hashCode));
  }

  bool get isOtherBuyer => rxBuyerName.value == 'OTHER';

  List<String> get buyerNames =>
      ['OTHER', ..._rxBuyerInfos.map((buyerInfo) => buyerInfo.name)];

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
    if (hashCode != rxArticle.hashCode && uniqueFilteredArticles.length == 1) {
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

  bool get canAddOrderLine =>
      rxMerchandiser.value.isNotEmpty &&
      rxShade.value.isNotEmpty &&
      _buyerName.isNotEmpty &&
      rxFirstLightSource.value.isNotEmpty &&
      rxSecondLightSource.value.isNotEmpty &&
      rxSubstrate.value.isNotEmpty &&
      rxTicket.value.isNotEmpty &&
      rxTex.value.isNotEmpty &&
      rxArticle.value.isNotEmpty &&
      rxBrand.value.isNotEmpty;

  String get _colorRemark => [
        if (rxColor.value.trim().isNotEmpty) rxColor.value,
        if (rxComment.value.trim().isNotEmpty) rxComment.value,
        if (rxLAB.value.trim().isNotEmpty) rxLAB.value,
        if (rxRequestType.value.isNotEmpty) rxRequestType.value,
        if (rxEndUse.value.isNotEmpty) rxEndUse.value,
      ].join('|');

  int get _lastLineNumber => rxLabdipOrderLines.lastOrNull?.lineNumber ?? 0;

  void addLapdipOrderLine() {
    _database.managers.draftTable.create(
      (o) => o(
        article: rxArticle.value,
        billingType: rxBillingType.value,
        brand: rxBrand.value,
        buyer: _buyerName,
        buyerCode: _rxBuyerCode.value,
        colorName: rxColor.value,
        comment: rxComment.value,
        endUse: rxEndUse.value,
        firstLightSource: rxFirstLightSource.value,
        lab: rxLAB.value,
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
      ),
      mode: drift.InsertMode.insertOrReplace,
    );

    _clearInputs();
  }

  String get _buyerName =>
      isOtherBuyer ? rxOtherBuyer.value : rxBuyerName.value;

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
              comment: drift.Value(rxComment.value),
              endUse: drift.Value(rxEndUse.value),
              firstLightSource: drift.Value(rxFirstLightSource.value),
              lab: drift.Value(rxLAB.value),
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
            ),
          );
    }

    rxSelectedLabdipOrderLines.clear();

    _clearInputs();
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

  void _clearInputs() {
    rxColor.value = '';
    rxEndUse.value = '';
    rxRequestType.value = '';
    rxLAB.value = '';
    rxComment.value = '';
    rxSubstrate.value = '';
    rxTicket.value = '';
    rxTex.value = '';
    rxBrand.value = '';
    rxArticle.value = '';
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

  List<String> shades = [
    'SWT',
    ...List.generate(9, (index) => 'SWT${index + 1}'),
  ];

  Future<void> submitOrder() async {
    final OrderReviewController orderReviewController =
        Get.find<OrderReviewController>();

    final isSubmitted = await orderReviewController.submitLabdipOrder(
      merchandiserName: rxMerchandiser.value,
      labdipOrderLines: rxLabdipOrderLines,
    );

    if (isSubmitted) {
      rxLabdipOrderLines.clear();
      rxSelectedLabdipOrderLines.clear();
      _clearInputs();
    }
  }

  bool get canSubmit =>
      rxMerchandiser.value.isNotEmpty && rxLabdipOrderLines.isNotEmpty;
}
