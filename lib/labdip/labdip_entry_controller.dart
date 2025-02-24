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

  final List<RxString> inputsInError = <RxString>[].obs;

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

  final rxLabdipOrderLines = <DraftTableData>[].obs;

  final catalogController = Get.find<CatalogController>();

  final _rxBuyerInfos = <BuyerInfo>[].obs;

  final rxBillingType = 'Branch'.obs;

  final billingTypes = ['Branch', 'Plant'];

  final rxRequestType = ''.obs;

  final requestTypes = ['Stitching', 'Embroidery'];

  final rxEndUse = ''.obs;

  final rxShades = <String>[].obs;

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

  final _skipShades = [
    'W32002',
    'W32001',
    'W32109',
    '001',
    '002',
    '012',
    '021',
    'BLACK',
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
      (newArticle) {
        selectIfOnlyOneOption(rxArticle.hashCode);

        rxShade.value = '';

        rxShades.clear();

        final article = newArticle.trim();

        if (article.isNotEmpty) {
          Api.fetchShades(article: article, uom: rxUom.value).then(
            (shades) {
              final validShades = shades
                  .where(
                    (shade) => !_skipShades.contains(shade),
                  )
                  .toList()
                ..sort(
                  (a, b) {
                    if (a.startsWith('SWT') && b.startsWith('SWT')) {
                      final aNum = int.tryParse(a.substring(3)) ?? 0;
                      final bNum = int.tryParse(b.substring(3)) ?? 0;
                      return aNum.compareTo(bNum);
                    } else if (a.startsWith('SWT')) {
                      return -1;
                    } else if (b.startsWith('SWT')) {
                      return 1;
                    } else {
                      return a.compareTo(b);
                    }
                  },
                );

              rxShades.addAll(validShades);
            },
          );
        }
      },
    );

    rxBrand.listen((_) => selectIfOnlyOneOption(rxBrand.hashCode));
    rxSubstrate.listen((_) => selectIfOnlyOneOption(rxSubstrate.hashCode));
    rxTex.listen((_) => selectIfOnlyOneOption(rxTex.hashCode));

    rxBuyerName.listen(buyerNameListener);

    rxOtherBuyerName.listen(otherBuyerListener);
  }

  void uomWithDesc(String newUomWithDesc) {
    if (newUomWithDesc.isNotEmpty) {
      rxUom.value = newUomWithDesc.split(' - ')[0];
    } else {
      rxUom.value = '';
    }
  }

  void shadeListener(String newShade) {
    rxColor.value = '';
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
      rxSubstrate.value = '';
      rxTex.value = '';
      rxTicket.value = '';
    } else if (hashCode == rxSubstrate.hashCode && rxSubstrate.value.isEmpty) {
      rxArticle.value = '';
      rxUom.value = '';
      rxBrand.value = '';
      rxTex.value = '';
      rxTicket.value = '';
    } else if (hashCode == rxTex.hashCode && rxTex.value.isEmpty) {
      rxArticle.value = '';
      rxUom.value = '';
      rxBrand.value = '';
      rxSubstrate.value = '';
      rxTicket.value = '';
    } else {
      if (hashCode != rxArticle.hashCode &&
          uniqueFilteredArticles.length == 1) {
        rxArticle.value = uniqueFilteredArticles.first;
      }

      if (hashCode != rxUom.hashCode && uniqueFilteredUoms.length == 1) {
        rxUom.value = uniqueFilteredUoms.first;
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

  int get _lastLineNumber => rxLabdipOrderLines.lastOrNull?.lineNumber ?? 0;

  bool validateInputs() {
    inputsInError.clear();

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

    if (isSwatchShade && rxColor.value.trim().isEmpty) {
      inputsInError.add(rxColor);
    }

    return inputsInError.isEmpty;
  }

  void addLapdipOrderLine() {
    if (!validateInputs()) {
      // toastification.show(
      //   autoCloseDuration: Duration(seconds: 5),
      //   primaryColor: VardhmanColors.red,
      //   title: Text('Please fill all the required fields'),
      // );
    } else if (rxLabdipOrderLines.any(
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
          buyer: buyerOrOtherName,
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
          uom: rxUom.value,
          colorRemark: _colorRemark,
          lastUpdated: DateTime.now(),
          merchandiser: rxMerchandiser.value,
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
        ],
      );
    }
  }

  String get buyerOrOtherName =>
      isOtherBuyer ? rxOtherBuyerName.value : rxBuyerName.value;

  void updateLapdipOrderLine() {
    if (!validateInputs()) {
      // toastification.show(
      //   autoCloseDuration: Duration(seconds: 5),
      //   primaryColor: VardhmanColors.red,
      //   title: Text('Please fill all the required fields'),
      // );
    } else {
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
                buyer: drift.Value(buyerOrOtherName),
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
                soldTo: drift.Value(
                    _userController.rxUserDetail.value.soldToNumber),
                substrate: drift.Value(rxSubstrate.value),
                tex: drift.Value(rxTex.value),
                ticket: drift.Value(rxTicket.value),
                uom: drift.Value(rxUom.value),
                colorRemark: drift.Value(_colorRemark),
                lastUpdated: drift.Value(DateTime.now()),
                merchandiser: drift.Value(rxMerchandiser.value),
              ),
            );
      }

      rxSelectedLabdipOrderLines.clear();

      clearAllInputs(
        skipHashCodes: [
          rxMerchandiser.hashCode,
          rxBuyerName.hashCode,
          if (isOtherBuyer) rxOtherBuyerName.hashCode,
          rxFirstLightSource.hashCode,
          rxSecondLightSource.hashCode,
          rxEndUse.hashCode,
        ],
      );
    }
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
      rxUom.value != '' ||
      rxShade.value != '' ||
      rxMerchandiser.value != '' ||
      rxBuyerName.value != '' ||
      rxOtherBuyerName.value != '' ||
      _rxBuyerCode.value != '' ||
      rxFirstLightSource.value != '' ||
      rxSecondLightSource.value != '';

  void clearAllInputs({List<int> skipHashCodes = const []}) {
    if (!skipHashCodes.contains(rxColor.hashCode)) {
      rxColor.value = '';
    }
    if (!skipHashCodes.contains(rxEndUse.hashCode)) {
      rxEndUse.value = '';
    }
    if (!skipHashCodes.contains(rxRequestType.hashCode)) {
      rxRequestType.value = '';
    }
    if (!skipHashCodes.contains(rxL.hashCode)) {
      rxL.value = '';
    }
    if (!skipHashCodes.contains(rxA.hashCode)) {
      rxA.value = '';
    }
    if (!skipHashCodes.contains(rxB.hashCode)) {
      rxB.value = '';
    }
    if (!skipHashCodes.contains(rxRemark.hashCode)) {
      rxRemark.value = '';
    }
    if (!skipHashCodes.contains(rxSubstrate.hashCode)) {
      rxSubstrate.value = '';
    }
    if (!skipHashCodes.contains(rxTicket.hashCode)) {
      rxTicket.value = '';
    }
    if (!skipHashCodes.contains(rxTex.hashCode)) {
      rxTex.value = '';
    }
    if (!skipHashCodes.contains(rxBrand.hashCode)) {
      rxBrand.value = '';
    }
    if (!skipHashCodes.contains(rxArticle.hashCode)) {
      rxArticle.value = '';
    }
    if (!skipHashCodes.contains(rxShade.hashCode)) {
      rxShade.value = '';
    }
    if (!skipHashCodes.contains(rxMerchandiser.hashCode)) {
      rxMerchandiser.value = '';
    }
    if (!skipHashCodes.contains(rxBuyerName.hashCode)) {
      rxBuyerName.value = '';
    }
    if (!skipHashCodes.contains(rxOtherBuyerName.hashCode)) {
      rxOtherBuyerName.value = '';
    }
    if (!skipHashCodes.contains(_rxBuyerCode.hashCode)) {
      _rxBuyerCode.value = '';
    }
    if (!skipHashCodes.contains(rxFirstLightSource.hashCode)) {
      rxFirstLightSource.value = '';
    }
    if (!skipHashCodes.contains(rxSecondLightSource.hashCode)) {
      rxSecondLightSource.value = '';
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

      if (rxSelectedLabdipOrderLines.length == 1) {
        clearAllInputs();

        _populateInputs(labdipOrderLine: rxSelectedLabdipOrderLines.first);
      }
    }
  }

  void _populateInputs({required DraftTableData labdipOrderLine}) {
    final labParts = labdipOrderLine.lab.split(',');
    final isOtherBuyer = !buyerNames.contains(labdipOrderLine.buyer);
    rxMerchandiser.value = labdipOrderLine.merchandiser;
    rxBuyerName.value = isOtherBuyer ? 'OTHER' : labdipOrderLine.buyer;
    rxOtherBuyerName.value = isOtherBuyer ? labdipOrderLine.buyer : '';
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
    rxColor.value = labdipOrderLine.colorName;
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
}
