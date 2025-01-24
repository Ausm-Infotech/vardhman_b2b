import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/buyer_info.dart';
import 'package:vardhman_b2b/catalog/catalog_controller.dart';
import 'package:vardhman_b2b/labdip/labdip_order_line.dart';

class LabdipController extends GetxController {
  final rxMerchandiser = ''.obs;

  final rxColor = ''.obs;

  final rxShade = ''.obs;

  final rxBuyer = ''.obs;

  final rxBuyerInfo = Rxn<BuyerInfo>();

  final rxFirstLightSource = ''.obs;

  final rxSecondLightSource = ''.obs;

  final rxSubstrate = ''.obs;

  final rxTicket = ''.obs;

  final rxTex = ''.obs;

  final rxArticle = ''.obs;

  final rxBrand = ''.obs;

  final rxRemark = ''.obs;

  final lapdipOrderLines = <LabdipOrderLine>[].obs;

  final catalogController = Get.find<CatalogController>();

  final rxBuyerInfos = <BuyerInfo>[].obs;

  LabdipController() {
    Api.fetchBuyerInfos().then(
      (buyerInfos) => rxBuyerInfos.addAll(buyerInfos),
    );

    rxBuyer.listen(
      (buyer) {
        if (buyer.isNotEmpty) {
          final buyerInfo =
              rxBuyerInfos.firstWhere((buyerInfo) => buyerInfo.name == buyer);

          rxFirstLightSource.value = buyerInfo.firstLightSource;

          rxSecondLightSource.value = buyerInfo.secondLightSource;
        } else {
          rxFirstLightSource.value = '';

          rxSecondLightSource.value = '';
        }
      },
    );
  }

  bool get canAddOrderLine =>
      rxMerchandiser.value.isNotEmpty &&
      rxColor.value.isNotEmpty &&
      rxShade.value.isNotEmpty &&
      rxBuyer.value.isNotEmpty &&
      rxFirstLightSource.value.isNotEmpty &&
      rxSecondLightSource.value.isNotEmpty &&
      rxSubstrate.value.isNotEmpty &&
      rxTicket.value.isNotEmpty &&
      rxTex.value.isNotEmpty &&
      rxArticle.value.isNotEmpty &&
      rxBrand.value.isNotEmpty &&
      rxRemark.value.isNotEmpty;

  void addLapdipOrderLine() {
    final labdipOrderLine = LabdipOrderLine(
      merchandiser: rxMerchandiser.value,
      color: rxColor.value,
      shade: rxShade.value,
      buyer: rxBuyer.value,
      firstLightSource: rxFirstLightSource.value,
      secondLightSource: rxSecondLightSource.value,
      substrate: rxSubstrate.value,
      ticket: rxTicket.value,
      tex: rxTex.value,
      article: rxArticle.value,
      brand: rxBrand.value,
      remark: rxRemark.value,
    );

    lapdipOrderLines.add(labdipOrderLine);
  }

  BuyerInfo? get buyerInfo =>
      rxBuyerInfos.firstWhere((buyerInfo) => buyerInfo.name == rxBuyer.value);

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

  List<String> shades = List.generate(9, (index) => 'SWT${index + 1}');
}
