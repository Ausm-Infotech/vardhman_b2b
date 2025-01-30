import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:get/get.dart';
import 'package:vardhman_b2b/api/api.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';

class ItemMasterController extends GetxController {
  final database = Get.find<Database>();

  final rxItems = <ItemMasterData>[].obs;

  ItemMasterController() {
    init();
  }

  Future<void> init() async {
    database.managers.itemMaster.watch().listen((itemMasterDatas) {
      rxItems.clear();

      rxItems.addAll(itemMasterDatas);
    });

    DateTime newestItemDateTime = oldestDateTime;

    int itemMasterCount = await database.managers.itemMaster.count();

    log('Initial Item Master Count: $itemMasterCount');

    if (itemMasterCount > 0) {
      final lastUpdatedItems = await database.managers.itemMaster
          .orderBy(
            (o) => o.lastUpdatedDateTime.desc(),
          )
          .get(
            limit: 1,
          );

      newestItemDateTime = lastUpdatedItems.first.lastUpdatedDateTime;
    }

    final itemMasterCompanions = await Api.fetchItemMaster(
      fromDate: newestItemDateTime,
    );

    if (itemMasterCompanions.isNotEmpty) {
      database.managers.itemMaster.bulkCreate(
        (o) => itemMasterCompanions,
        mode: InsertMode.insertOrReplace,
      );
    }

    itemMasterCount = await database.managers.itemMaster.count();

    log('Final Item Master Count: $itemMasterCount');
  }

  String getUomDescription(String uom) {
    String description = '';

    try {
      description = rxItems
          .firstWhere(
            (element) => element.uom == uom,
          )
          .uomDescription;
    } catch (e) {
      log(e.toString());
    }

    return description;
  }

  String getArticleDescription(String article) {
    String description = '';

    try {
      description = rxItems
          .firstWhere(
            (element) => element.article == article,
          )
          .articleDescription;
    } catch (e) {
      log(e.toString());
    }

    return description;
  }

  List<String> getShadeCardList(
      {required String article, required String uom}) {
    List<String> shadeCardList = [];

    try {
      shadeCardList = rxItems
          .where(
            (item) =>
                item.article == article &&
                item.uom == uom &&
                item.isInShadeCard,
          )
          .map(
            (item) => item.shade,
          )
          .toList();
    } catch (e) {
      log(e.toString());
    }

    return shadeCardList;
  }
}
