import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/labdip/labdip_order_line.dart';

class LabdipController extends GetxController {
  final rxMerchandiser = ''.obs;

  final rxBuyer = ''.obs;

  final rxFirstLightSource = ''.obs;

  final rxSecondLightSource = ''.obs;

  final rxColor = ''.obs;

  final rxShade = ''.obs;

  final rxSubstrate = ''.obs;

  final rxTex = ''.obs;

  final rxBrand = ''.obs;

  final rxArticle = ''.obs;

  final rxTicket = ''.obs;

  final rxRemarks = ''.obs;

  final merchandiserTextController = TextEditingController();

  final buyerTextController = TextEditingController();

  final firstLightSourceTextController = TextEditingController();

  final secondLightSourceTextController = TextEditingController();

  final colorTextController = TextEditingController();

  final shadeTextController = TextEditingController();

  final substrateTextController = TextEditingController();

  final texTextController = TextEditingController();

  final brandTextController = TextEditingController();

  final articleTextController = TextEditingController();

  final ticketTextController = TextEditingController();

  final remarksTextController = TextEditingController();

  final lapdipOrderLines = <LabdipOrderLine>[].obs;

  final catalogController = Get.find<CatalogController>();

  void addLapdipOrderLine() {
    final labdipOrderLine = LabdipOrderLine(
      merchandiser: merchandiserTextController.text,
      buyer: buyerTextController.text,
      firstLightSource: firstLightSourceTextController.text,
      secondLightSource: secondLightSourceTextController.text,
      color: colorTextController.text,
      shade: shadeTextController.text,
      substrate: rxSubstrate.value,
      tex: texTextController.text,
      brand: brandTextController.text,
      article: rxArticle.value,
      ticket: ticketTextController.text,
      remarks: remarksTextController.text,
      lineNumber: lapdipOrderLines.length.toString(),
    );

    lapdipOrderLines.add(labdipOrderLine);
  }

  List<String> get filteredBrands => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
            itemCatalogInfo.article.contains(rxArticle.value) &&
            itemCatalogInfo.substrateDesc.contains(rxSubstrate.value) &&
            itemCatalogInfo.tex.contains(texTextController.text) &&
            itemCatalogInfo.ticket.contains(ticketTextController.text),
      )
      .map((e) => e.brandDesc)
      .toList();

  List<String> get filteredArticles => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
            itemCatalogInfo.brand.contains(brandTextController.text) &&
            itemCatalogInfo.substrateDesc.contains(rxSubstrate.value) &&
            itemCatalogInfo.tex.contains(texTextController.text) &&
            itemCatalogInfo.ticket.contains(ticketTextController.text),
      )
      .map((e) => e.brandDesc)
      .toList();

  List<String> get filteredSubstrates => catalogController.industryItems
      .where(
        (itemCatalogInfo) =>
            itemCatalogInfo.brandDesc.contains(brandTextController.text) &&
            itemCatalogInfo.article.contains(rxArticle.value) &&
            itemCatalogInfo.tex.contains(texTextController.text) &&
            itemCatalogInfo.ticket.contains(ticketTextController.text),
      )
      .map((e) => e.brandDesc)
      .toList();
}
