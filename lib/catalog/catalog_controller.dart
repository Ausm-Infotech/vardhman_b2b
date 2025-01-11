import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/api/item_catalog_info.dart';

class CatalogController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<ItemCatalogInfo> _items = [];

  late final TabController tabController =
      TabController(length: 2, vsync: this);

  final brandEditingController = TextEditingController();
  final substrateEditingController = TextEditingController();
  final lengthEditingController = TextEditingController();
  final articleTextEditingController = TextEditingController();

  final rxFilteredItems = RxList<ItemCatalogInfo>();

  CatalogController() {
    brandEditingController.addListener(_filterItems);
    substrateEditingController.addListener(_filterItems);
    lengthEditingController.addListener(_filterItems);
    articleTextEditingController.addListener(_filterItems);

    refreshItems();
  }

  Future<void> refreshItems() async {
    final items = await Api.fetchItemCatalogInfo();

    if (items.isNotEmpty) {
      _items.clear();
      _items.addAll(items);
      _filterItems();
    }
  }

  void _filterItems() {
    final filteredItems = _items.where(
      (item) {
        final brandName = brandEditingController.text.trim().toLowerCase();
        final subStrate = substrateEditingController.text.trim().toLowerCase();
        final length = lengthEditingController.text.trim().toLowerCase();
        final article = articleTextEditingController.text.trim().toLowerCase();

        return item.value2.toLowerCase().contains(length) &&
            item.substrateDesc.toLowerCase().contains(subStrate) &&
            item.brandDesc.toLowerCase().contains(brandName) &&
            item.article.toLowerCase().contains(article);
      },
    ).toList();

    rxFilteredItems.clear();
    rxFilteredItems.addAll(filteredItems);
  }

  Future<void> clearFilters() async {
    brandEditingController.clear();
    substrateEditingController.clear();
    lengthEditingController.clear();
    articleTextEditingController.clear();
    _filterItems();
  }

  bool get hasFilters =>
      lengthEditingController.text.isNotEmpty ||
      substrateEditingController.text.isNotEmpty ||
      brandEditingController.text.isNotEmpty ||
      articleTextEditingController.text.isNotEmpty;

  List<ItemCatalogInfo> get industryItems =>
      rxFilteredItems.where((element) => element.category == 'IND').toList();

  List<ItemCatalogInfo> get domesticItems =>
      rxFilteredItems.where((element) => element.category == 'DOM').toList();
}
