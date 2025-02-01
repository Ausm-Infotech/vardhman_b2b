import 'dart:developer';

import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/buyer_info.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/labdip/labdip_entry_line.dart';
import 'package:vardhman_b2b/orders/order_review_controller.dart';

class LabdipEntryController extends GetxController {
  final rxMerchandiser = ''.obs;

  final rxColor = ''.obs;

  final rxShade = 'SWT'.obs;

  final rxBuyer = ''.obs;

  final rxBuyerInfo = Rxn<BuyerInfo>();

  final rxSubstrate = ''.obs;

  final rxTicket = ''.obs;

  final rxTex = ''.obs;

  final rxArticle = ''.obs;

  final rxBrand = ''.obs;

  final rxRemark = ''.obs;

  final rxLAB = ''.obs;

  final rxComment = ''.obs;

  final rxLabdipOrderLines = <LabdipEntryLine>[].obs;

  final catalogController = Get.find<CatalogController>();

  final rxBuyerInfos = <BuyerInfo>[].obs;

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

  final rxSelectedLabdipOrderLines = <LabdipEntryLine>[].obs;

  LabdipEntryController() {
    Api.fetchBuyerInfos().then(
      (buyerInfos) => rxBuyerInfos.addAll(buyerInfos),
    );

    rxBuyer.listen(
      (buyer) {
        if (rxBuyerInfos.any((buyerInfo) => buyerInfo.name == buyer)) {
          rxBuyerInfo.value = rxBuyerInfos.firstWhere(
            (buyerInfo) => buyerInfo.name == buyer,
          );
        } else {
          rxBuyerInfo.value = null;
        }
      },
    );
  }

  bool get canAddOrderLine =>
      rxMerchandiser.value.isNotEmpty &&
      rxShade.value.isNotEmpty &&
      rxBuyerInfo.value != null &&
      rxSubstrate.value.isNotEmpty &&
      rxTicket.value.isNotEmpty &&
      rxTex.value.isNotEmpty &&
      rxArticle.value.isNotEmpty &&
      rxBrand.value.isNotEmpty;

  void addLapdipOrderLine() {
    rxLabdipOrderLines.add(currentLabdipOrderLine);

    _clearInputs();
  }

  void updateLapdipOrderLine() {
    final index = rxLabdipOrderLines.indexOf(rxSelectedLabdipOrderLines.first);

    rxLabdipOrderLines.replaceRange(index, index + 1, [currentLabdipOrderLine]);

    rxSelectedLabdipOrderLines.clear();

    _clearInputs();
  }

  void deleteSelectedLines() {
    rxLabdipOrderLines.removeWhere(
      (labdipOrderLine) => rxSelectedLabdipOrderLines.contains(labdipOrderLine),
    );

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
                : true) &&
            (rxTicket.value.isNotEmpty
                ? itemCatalogInfo.ticket == (rxTicket.value)
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
                : true) &&
            (rxTicket.value.isNotEmpty
                ? itemCatalogInfo.ticket == (rxTicket.value)
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
                : true) &&
            (rxTicket.value.isNotEmpty
                ? itemCatalogInfo.ticket == (rxTicket.value)
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
                : true) &&
            (rxTicket.value.isNotEmpty
                ? itemCatalogInfo.ticket == (rxTicket.value)
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

  LabdipEntryLine get currentLabdipOrderLine => LabdipEntryLine(
        colorName: rxColor.value,
        firstLightSource: rxBuyerInfo.value?.firstLightSource ?? '',
        secondLightSource: rxBuyerInfo.value?.secondLightSource ?? '',
        substrate: rxSubstrate.value,
        ticket: rxTicket.value,
        tex: rxTex.value,
        article: rxArticle.value,
        brand: rxBrand.value,
        comment: rxComment.value,
        billingType: rxBillingType.value,
        buyerCode: rxBuyerInfo.value?.code ?? '',
        lab: rxLAB.value,
        requestType: rxRequestType.value,
        shade: rxShade.value,
        uom: uom,
        endUse: rxEndUse.value,
      );

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
