import 'dart:developer';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';
import 'package:vardhman_b2b/common/excel_dialog.dart';
import 'package:vardhman_b2b/constants.dart';
import 'package:vardhman_b2b/drift/database.dart';
import 'package:vardhman_b2b/orders/item_master_controller.dart';
import 'package:vardhman_b2b/user/user_controller.dart';

class Article {
  final String name, description;

  final RxMap<String, Uom> uomMap;

  Article({
    required this.name,
    required this.description,
    required this.uomMap,
  });
}

class Uom {
  final String name, description;

  final RxMap<String, int> shadeQuantitiesMap;

  Uom({
    required this.name,
    required this.description,
    required this.shadeQuantitiesMap,
  });
}

const shadeCardIdentifier = 'SHADE-CARD';

const errorText = 'NOT FOUND!';

class OrderEntryController extends GetxController {
  final Database _database = Get.find<Database>();

  final UserController _userController = Get.find(tag: 'userController');

  final ItemMasterController itemMasterController = Get.find();

  final TextEditingController articleTextEditingController =
          TextEditingController(),
      uomTextEditingController = TextEditingController(),
      shadeTextEditingController = TextEditingController(),
      quantityTextEditingController = TextEditingController.fromValue(
        TextEditingValue(text: '1'),
      );

  final FocusNode articleFocusNode = FocusNode(),
      uomFocusNode = FocusNode(),
      shadeFocusNode = FocusNode(),
      quantityFocusNode = FocusNode();

  final articleMap = <String, Article>{};

  final carticleMap = <String, Article>{}.obs;

  final shadeCardMap = <String, bool>{};

  final suggestions = <String>[].obs;

  final articleInput = ''.obs, uomInput = ''.obs, shadeInput = ''.obs;

  final articleError = ''.obs,
      uomError = ''.obs,
      shadeError = ''.obs,
      quantityError = ''.obs;

  final articleDescription = ''.obs, uomDescription = ''.obs;

  final shouldUpdate = false.obs;

  final scrollController = ScrollController();

  // final speechToText = SpeechToText();

  final speechToTextStatus = 'done'.obs;

  OrderEntryController() {
    // speechToText.initialize(
    //   onError: (errorNotification) {
    //     log('Speech error - $errorNotification');
    //   },
    //   onStatus: (status) {
    //     log('Speech status - $status');

    //     speechToTextStatus.value = status;
    //   },
    // );

    itemMasterController.rxItems.listen(
      (items) {
        loadItemData(items);
      },
    );

    articleTextEditingController.addListener(articleEditListener);
    uomTextEditingController.addListener(uomEditListener);
    shadeTextEditingController.addListener(shadeEditListener);

    articleFocusNode.addListener(articleFocusListener);
    uomFocusNode.addListener(uomFocusListener);
    shadeFocusNode.addListener(shadeFocusListener);
    quantityFocusNode.addListener(quantityFocusListener);

    _userController.rxCustomerDetail.listenAndPump(
      (customerDetail) async {
        carticleMap.clear();

        final cartItems = await _database.managers.cartTable
            .filter(
              (f) => f.soldTo.equals(
                customerDetail.soldToNumber,
              ),
            )
            .get();

        for (final cartItem in cartItems) {
          addExcelItemToCart(
            article: cartItem.article,
            uom: cartItem.uom,
            shade: cartItem.shade,
            quantity: cartItem.quantity,
            replace: false,
          );
        }
      },
    );
  }

  // Future<void> listen() async {
  //   if (canListen()) {
  //     if (speechToTextStatus.value == 'listening') {
  //       return;
  //     } else if (speechToTextStatus.value == 'notListening') {
  //       await speechToText.stop();
  //     } else if (speechToTextStatus.value == 'done') {
  //       final regExp = quantityFocusNode.hasFocus
  //           ? RegExp(r'[^0-9]')
  //           : RegExp(r'[^a-zA-Z0-9]');

  //       speechToText.listen(
  //         listenOptions: SpeechListenOptions(
  //           cancelOnError: true,
  //           listenMode: ListenMode.dictation,
  //           partialResults: false,
  //         ),
  //         listenFor: Duration(seconds: 20),
  //         pauseFor: Duration(seconds: 20),
  //         onResult: (result) {
  //           final foundAlternates = <String>[];

  //           for (SpeechRecognitionWords alternate in result.alternates) {
  //             log(alternate.recognizedWords);

  //             final recognizedWords = alternate.recognizedWords
  //                 .replaceAll(regExp, '')
  //                 .toUpperCase();

  //             if (suggestions.any(
  //               (suggestion) =>
  //                   suggestion.toUpperCase().contains(recognizedWords),
  //             )) {
  //               foundAlternates.add(recognizedWords);
  //             }
  //           }

  //           log('Found alternates - ${foundAlternates.toString()}');

  //           final bestFoundAlternate = foundAlternates.fold(
  //             '',
  //             (value, element) {
  //               return value.length > element.length ? value : element;
  //             },
  //           );

  //           final finalResult = bestFoundAlternate.isNotEmpty
  //               ? bestFoundAlternate
  //               : result.recognizedWords.replaceAll(regExp, '').toUpperCase();

  //           final shouldFocusNextField = suggestions
  //                   .where(
  //                     (suggestion) => suggestion.contains(finalResult),
  //                   )
  //                   .length ==
  //               1;

  //           if (articleFocusNode.hasFocus) {
  //             articleTextEditingController.value = TextEditingValue(
  //               text: finalResult,
  //             );

  //             if (shouldFocusNextField) {
  //               uomFocusNode.requestFocus();
  //             }
  //           } else if (uomFocusNode.hasFocus) {
  //             uomTextEditingController.value = TextEditingValue(
  //               text: finalResult,
  //             );

  //             if (shouldFocusNextField) {
  //               shadeFocusNode.requestFocus();
  //             }
  //           } else if (shadeFocusNode.hasFocus) {
  //             shadeTextEditingController.value = TextEditingValue(
  //               text: finalResult,
  //             );

  //             if (shouldFocusNextField) {
  //               quantityFocusNode.requestFocus();
  //             }
  //           } else if (quantityFocusNode.hasFocus) {
  //             quantityTextEditingController.value = TextEditingValue(
  //               text: finalResult,
  //             );
  //           }
  //         },
  //       );
  //     }
  //   } else if (speechToTextStatus.value != 'done') {
  //     await speechToText.stop();
  //   }
  // }

  void loadItemData(List<ItemMasterData> items) {
    shadeCardMap.clear();

    articleMap.clear();

    DateTime startTime = DateTime.now();

    for (ItemMasterData item in items) {
      String article = item.article;

      String uom = item.uom;

      String shade = item.shade;

      shadeCardMap[getItemNumber(article: article, uom: uom, shade: shade)] =
          item.isInShadeCard;

      if (article.isNotEmpty && uom.isNotEmpty && shade.isNotEmpty) {
        final articleObject = articleMap[article];

        if (articleObject != null) {
          final uomObject = articleObject.uomMap[uom];

          if (uomObject != null) {
            if (!uomObject.shadeQuantitiesMap.containsKey(shade)) {
              uomObject.shadeQuantitiesMap[shade] = 1;
            }
          } else {
            articleObject.uomMap[uom] = Uom(
              name: uom,
              description: item.uomDescription,
              shadeQuantitiesMap: {shade: 1}.obs,
            );
          }
        } else {
          articleMap[article] = Article(
            name: article,
            description: item.articleDescription,
            uomMap: {
              uom: Uom(
                name: uom,
                description: item.uomDescription,
                shadeQuantitiesMap: {shade: 1}.obs,
              )
            }.obs,
          );
        }
      }
    }

    DateTime endTime = DateTime.now();

    int timeTakenInSeconds = endTime.difference(startTime).inSeconds;

    log('Processing items took $timeTakenInSeconds seconds');
  }

  void suggestArticles() {
    final filteredArticles = articleMap.keys.where(
      (element) => element.contains(articleInput.value),
    );

    suggestions.clear();

    suggestions.addAll(filteredArticles);
  }

  void suggestUoms() {
    if (articleError.isEmpty && articleInput.value.isNotEmpty) {
      final articleObject = articleMap[articleInput.value];

      if (articleObject != null) {
        final uomsWithDescriptions = articleObject.uomMap.keys.map(
          (uom) => '$uom - ${itemMasterController.getUomDescription(uom)}',
        );

        final filteredUoms = uomsWithDescriptions.where(
          (uomDesc) =>
              uomDesc.toLowerCase().contains(uomInput.value.toLowerCase()),
        );

        suggestions.clear();

        suggestions.addAll(
          filteredUoms,
        );
      }
    }
  }

  void suggestShades() {
    if (articleError.isEmpty &&
        uomError.isEmpty &&
        articleInput.value.isNotEmpty &&
        uomInput.value.isNotEmpty) {
      final article = articleInput.value;

      final uom = uomInput.value;

      final shade = shadeInput.value;

      final filteredShades =
          articleMap[article]!.uomMap[uom]!.shadeQuantitiesMap.keys.where(
                (element) => element.contains(shade),
              );

      suggestions.clear();

      if (filteredShades.any(
        (shadeName) {
          final itemNumber = getItemNumber(
            article: article,
            uom: uom,
            shade: shadeName,
          );

          return shadeCardMap[itemNumber] == true;
        },
      )) {
        suggestions.add(shadeCardIdentifier);
      }

      suggestions.addAll(filteredShades);
    }
  }

  void selectSuggestion(String suggestion) {
    if (articleFocusNode.hasFocus) {
      articleTextEditingController.value = TextEditingValue(text: suggestion);

      uomTextEditingController.clear();

      shadeTextEditingController.clear();

      quantityTextEditingController.clear();

      uomFocusNode.requestFocus();
    } else if (uomFocusNode.hasFocus) {
      uomTextEditingController.value =
          TextEditingValue(text: suggestion.split(' - ')[0]);

      shadeTextEditingController.clear();

      quantityTextEditingController.clear();

      shadeFocusNode.requestFocus();
    } else if (shadeFocusNode.hasFocus) {
      shadeTextEditingController.value = TextEditingValue(text: suggestion);

      quantityFocusNode.requestFocus();
    }
  }

  void articleEditListener() {
    articleInput.value = articleTextEditingController.text;

    articleError.value = '';

    articleDescription.value = '';

    if (articleInput.value.isEmpty) {
      uomTextEditingController.clear();

      shadeTextEditingController.clear();
    } else if (articleMap.containsKey(articleInput.value)) {
      articleDescription.value =
          itemMasterController.getArticleDescription(articleInput.value);
    } else {
      articleError.value = errorText;
    }

    suggestArticles();

    if (carticleMap[articleInput.value] != null) {
      scrollToTop();
    }
  }

  void uomEditListener() {
    uomInput.value = uomTextEditingController.text;

    uomError.value = '';

    uomDescription.value = '';

    final articleObject = articleMap[articleInput.value];

    if (uomInput.value.isEmpty) {
      shadeTextEditingController.clear();
    } else if ((articleObject != null &&
        articleObject.uomMap.containsKey(uomInput.value))) {
      uomDescription.value =
          itemMasterController.getUomDescription(uomInput.value);
    } else {
      uomError.value = errorText;
    }

    suggestUoms();

    if (carticleMap[articleInput.value]?.uomMap[uomInput.value] != null) {
      scrollToTop();
    }
  }

  void shadeEditListener() {
    shadeInput.value = shadeTextEditingController.text;

    final uomObject = articleMap[articleInput.value]?.uomMap[uomInput.value];

    shadeError.value = '';

    if (shadeInput.value.isEmpty ||
        (uomObject != null &&
            uomObject.shadeQuantitiesMap.containsKey(shadeInput.value))) {
      final quantity = carticleMap[articleInput.value]
          ?.uomMap[uomInput.value]
          ?.shadeQuantitiesMap[shadeInput.value];

      if (quantity != null) {
        quantityTextEditingController.value = TextEditingValue(
          text: quantity.toString(),
        );

        shouldUpdate.value = true;
      } else {
        quantityTextEditingController.value = TextEditingValue(
          text: '1',
        );

        shouldUpdate.value = false;
      }
    } else if (shadeInput.value != shadeCardIdentifier) {
      shadeError.value = errorText;
    }

    suggestShades();

    if (carticleMap[articleInput.value]
            ?.uomMap[uomInput.value]
            ?.shadeQuantitiesMap[shadeInput.value] !=
        null) {
      scrollToTop();
    }
  }

  void articleFocusListener() {
    // listen();

    if (articleFocusNode.hasFocus) {
      articleTextEditingController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: articleInput.value.length,
      );

      suggestArticles();
    } else {
      clearSuggestions();
    }
  }

  void uomFocusListener() {
    // listen();

    if (uomFocusNode.hasFocus) {
      uomTextEditingController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: uomInput.value.length,
      );

      suggestUoms();
    } else {
      clearSuggestions();
    }
  }

  void shadeFocusListener() {
    // listen();

    if (shadeFocusNode.hasFocus) {
      shadeTextEditingController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: shadeInput.value.length,
      );

      suggestShades();
    } else {
      clearSuggestions();
    }
  }

  void quantityFocusListener() {
    // listen();

    if (quantityFocusNode.hasFocus) {
      quantityTextEditingController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: quantityTextEditingController.text.length,
      );
    } else {
      quantityTextEditingController.value = TextEditingValue(
        text: parseQuantity().toString(),
      );
    }
  }

  void clearSuggestions() {
    if (!articleFocusNode.hasFocus &&
        !uomFocusNode.hasFocus &&
        !shadeFocusNode.hasFocus) {
      suggestions.clear();
    }
  }

  void addAllShadesToCart() {
    String article = articleInput.value, uom = uomInput.value;

    int quantity = parseQuantity();

    final articleObject = articleMap[article];

    if (articleObject != null) {
      final uomObject = articleObject.uomMap[uom];

      if (uomObject != null) {
        for (String shade in uomObject.shadeQuantitiesMap.keys) {
          if (shadeCardMap[
                  getItemNumber(article: article, uom: uom, shade: shade)] ==
              true) {
            addExcelItemToCart(
              article: article,
              uom: uom,
              shade: shade,
              quantity: quantity,
            );
          }
        }
      }
    }

    shadeTextEditingController.clear();

    shadeFocusNode.requestFocus();
  }

  Future<void> addItemToCart() async {
    String article = articleInput.value,
        uom = uomInput.value,
        shade = shadeInput.value;

    int quantity = parseQuantity();

    if (shade == shadeCardIdentifier) {
      addAllShadesToCart();

      return;
    }

    if (carticleMap.containsKey(article)) {
      final articleObject = carticleMap[article]!;

      if (articleObject.uomMap.containsKey(uom)) {
        final uomObject = articleObject.uomMap[uom]!;

        uomObject.shadeQuantitiesMap.addAll(
          {
            shade: quantity,
          },
        );
      } else {
        articleObject.uomMap.addAll(
          {
            uom: Uom(
              name: uom,
              description: itemMasterController.getUomDescription(uom),
              shadeQuantitiesMap: {shade: quantity}.obs,
            ),
          },
        );
      }
    } else {
      carticleMap[article] = Article(
        name: article,
        description: itemMasterController.getArticleDescription(article),
        uomMap: {
          uom: Uom(
            name: uom,
            description: itemMasterController.getUomDescription(uom),
            shadeQuantitiesMap: {shade: quantity}.obs,
          ),
        }.obs,
      );
    }

    await _database.managers.cartTable.create(
      (o) => o(
        soldTo: _userController.rxCustomerDetail.value.soldToNumber,
        article: article,
        uom: uom,
        shade: shade,
        quantity: quantity,
      ),
    );

    shadeTextEditingController.clear();

    shadeFocusNode.requestFocus();
  }

  void addExcelItemToCart({
    required String article,
    required String uom,
    required String shade,
    required int quantity,
    bool replace = true,
  }) {
    if (carticleMap.containsKey(article)) {
      final articleObject = carticleMap[article]!;

      if (articleObject.uomMap.containsKey(uom)) {
        final uomObject = articleObject.uomMap[uom]!;

        if (!uomObject.shadeQuantitiesMap.containsKey(shade) || replace) {
          uomObject.shadeQuantitiesMap.addAll(
            {
              shade: quantity,
            },
          );
        }
      } else {
        articleObject.uomMap.addAll(
          {
            uom: Uom(
              name: uom,
              description: itemMasterController.getUomDescription(uom),
              shadeQuantitiesMap: {shade: quantity}.obs,
            ),
          },
        );
      }
    } else {
      carticleMap[article] = Article(
        name: article,
        description: itemMasterController.getArticleDescription(article),
        uomMap: {
          uom: Uom(
            name: uom,
            description: itemMasterController.getUomDescription(uom),
            shadeQuantitiesMap: {shade: quantity}.obs,
          ),
        }.obs,
      );
    }

    _database.managers.cartTable.create(
      (o) => o(
        soldTo: _userController.rxCustomerDetail.value.soldToNumber,
        article: article,
        uom: uom,
        shade: shade,
        quantity: quantity,
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  bool canAddItemToCart() {
    return articleInput.value.isNotEmpty &&
        articleError.isEmpty &&
        uomInput.value.isNotEmpty &&
        uomError.isEmpty &&
        shadeInput.value.isNotEmpty &&
        shadeError.isEmpty;
  }

  int getTotalShades() {
    int totalShades = 0;

    carticleMap.forEach(
      (articleName, articleObject) {
        articleObject.uomMap.forEach(
          (uomName, uomObject) {
            totalShades += uomObject.shadeQuantitiesMap.length;
          },
        );
      },
    );

    return totalShades;
  }

  int getTotalQuantity() {
    int totalQuantity = 0;

    carticleMap.forEach(
      (articleName, articleObject) {
        articleObject.uomMap.forEach(
          (uomName, uomObject) {
            for (var quantity in uomObject.shadeQuantitiesMap.values) {
              totalQuantity += quantity;
            }
          },
        );
      },
    );

    return totalQuantity;
  }

  void onArticleBarTap({
    required String article,
  }) {
    articleTextEditingController.value = TextEditingValue(
      text: article,
    );

    uomTextEditingController.clear();

    shadeTextEditingController.clear();

    scrollToTop();

    uomFocusNode.requestFocus();
  }

  void onUomLabelTap({
    required String article,
    required String uom,
  }) {
    articleTextEditingController.value = TextEditingValue(
      text: article,
    );

    uomTextEditingController.value = TextEditingValue(text: uom);

    shadeTextEditingController.clear();

    scrollToTop();

    shadeFocusNode.requestFocus();
  }

  void onShadeCardTap({
    required String article,
    required String uom,
    required String shade,
  }) {
    articleTextEditingController.value = TextEditingValue(
      text: article,
    );

    uomTextEditingController.value = TextEditingValue(text: uom);

    shadeTextEditingController.value = TextEditingValue(text: shade);

    scrollToTop();

    quantityFocusNode.requestFocus();

    suggestions.clear();
  }

  void updateCart({
    String? article,
    String? uom,
    String? shade,
    int? quantity,
  }) {
    final _article = article ?? articleInput.value;

    final _uom = uom ?? uomInput.value;

    final _shade = shade ?? shadeInput.value;

    final _quantity = quantity ?? parseQuantity();

    carticleMap[_article]?.uomMap[_uom]?.shadeQuantitiesMap[_shade] = _quantity;

    shadeTextEditingController.clear();

    suggestions.clear();

    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> deleteShade({
    String? article,
    String? uom,
    String? shade,
  }) async {
    final _article = article ?? articleInput.value;

    final _uom = uom ?? uomInput.value;

    final _shade = shade ?? shadeInput.value;

    final articleObject = carticleMap[_article];

    if (articleObject != null) {
      final uomObject = articleObject.uomMap[_uom];

      if (uomObject != null) {
        uomObject.shadeQuantitiesMap.remove(_shade);

        shadeTextEditingController.clear();

        if (uomObject.shadeQuantitiesMap.isEmpty) {
          articleObject.uomMap.remove(uomObject.name);

          uomTextEditingController.clear();
        }
      }

      if (articleObject.uomMap.isEmpty) {
        carticleMap.remove(articleObject.name);

        articleTextEditingController.clear();
      }
    }

    final deletedRowsCount = await _database.managers.cartTable
        .filter((f) => f.soldTo
            .equals(_userController.rxCustomerDetail.value.soldToNumber))
        .filter((f) => f.article.equals(_article))
        .filter((f) => f.uom.equals(_uom))
        .filter((f) => f.shade.equals(_shade))
        .delete();

    log('$deletedRowsCount rows deleted');

    suggestions.clear();

    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> deleteArticle(String article) async {
    carticleMap.remove(article);

    final deletedRowsCount = await _database.managers.cartTable
        .filter((f) => f.soldTo
            .equals(_userController.rxCustomerDetail.value.soldToNumber))
        .filter((f) => f.article.equals(article))
        .delete();

    log('$deletedRowsCount rows deleted');
  }

  List<Article> getSortedArticles() {
    final sortedArticles = carticleMap.values.toList()
      ..sort(
        (a, b) {
          return a.name == articleInput.value
              ? -1
              : b.name == articleInput.value
                  ? 1
                  : a.name.compareTo(b.name);
        },
      );

    return sortedArticles;
  }

  List<Uom> getSortedUoms(Article article) {
    final sortedUoms = article.uomMap.values.toList()
      ..sort(
        (a, b) => a.name == uomInput.value
            ? -1
            : b.name == uomInput.value
                ? 1
                : a.name.compareTo(b.name),
      );

    return sortedUoms;
  }

  List<String> getSortedShades(Uom uom) {
    final sortedShades = uom.shadeQuantitiesMap.keys.toList()
      ..sort(
        (a, b) => a == shadeInput.value
            ? -1
            : b == shadeInput.value
                ? 1
                : a.compareTo(b),
      );

    return sortedShades;
  }

  void clearInputs() {
    quantityTextEditingController.value = TextEditingValue(text: '1');

    shadeTextEditingController.clear();

    uomTextEditingController.clear();

    articleTextEditingController.clear();

    suggestions.clear();

    FocusManager.instance.primaryFocus?.unfocus();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  int parseQuantity() {
    int quantity = 1;

    quantity = int.tryParse(quantityTextEditingController.text) ?? 1;

    if (quantity < 1) {
      quantity = 1;
    }

    return quantity;
  }

  Future<void> importExcel() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.first.path!);

      final bytes = file.readAsBytesSync();

      final excelFile = Excel.decodeBytes(bytes);

      for (final row in excelFile.tables.values.first.rows.sublist(1)) {
        if (row.length == 4) {
          String article = row[0]?.value.toString() ?? '';
          String uom = row[1]?.value.toString() ?? '';
          String shade = row[2]?.value.toString() ?? '';
          String quantity = row[3]?.value.toString() ?? '';

          if (articleMap[article]
                  ?.uomMap[uom]
                  ?.shadeQuantitiesMap
                  .containsKey(shade) ??
              false) {
            var cartQuantity =
                carticleMap[article]?.uomMap[uom]?.shadeQuantitiesMap[shade];

            if (cartQuantity != null) {
              carticleMap[article]?.uomMap[uom]?.shadeQuantitiesMap[shade] =
                  int.tryParse(quantity) ?? cartQuantity;
            } else {
              addExcelItemToCart(
                article: article,
                uom: uom,
                shade: shade,
                quantity: int.tryParse(quantity) ?? 1,
              );
            }
          }
        }
      }
    }
  }

  bool canListen() {
    return articleFocusNode.hasFocus ||
        uomFocusNode.hasFocus ||
        shadeFocusNode.hasFocus ||
        quantityFocusNode.hasFocus;
  }

  Future<void> showExcelDialog() async {
    Get.dialog(ExcelDialog());
  }

  List<String> get articles => articleMap.keys.toList();

  List<String> getUomsForArticle(String article) =>
      articleMap[article]?.uomMap.keys.toList() ?? [];

  List<String> getShadesForArticleAndUom(
          {required String article, required String uom}) =>
      articleMap[article]?.uomMap[uom]?.shadeQuantitiesMap.keys.toList() ?? [];
}
