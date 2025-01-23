import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:vardhman_b2b/common/primary_button.dart';

class CreateOrderController extends GetxController {
  var buyers = [
    {
      "F00092_KY": "030",
      "F00092_RMK": "TL1",
      "F00092_RMK2": "TL2",
      "F00092_RMK3": "ARROW"
    },
    {
      "F00092_KY": "029",
      "F00092_RMK": "TL1",
      "F00092_RMK2": "TL2",
      "F00092_RMK3": "ARISTOCAT"
    },
    {
      "F00092_KY": "G03",
      "F00092_RMK": "U35",
      "F00092_RMK2": "Inca",
      "F00092_RMK3": "GAP"
    },
    {
      "F00092_KY": "V00",
      "F00092_RMK": "D65",
      "F00092_RMK2": "TL84",
      "F00092_RMK3": "VAN HEUSEN  (PVH)"
    }
  ].obs;

  final shadeNumbers = List.generate(9, (index) => 'SWT${index + 1}').obs;

  var articles = [
    {
      "Article": "Y0612",
      "Brand": "B0177",
      "Substrate": "COTTON",
      "Tex": "16/60",
      "Ticket": "1"
    },
    {
      "Article": "Y0615",
      "Brand": "B0177",
      "Substrate": "FILAMENT",
      "Tex": "16/60",
      "Ticket": "1"
    },
    {
      "Article": "Y0905",
      "Brand": "B00",
      "Substrate": "POLOYSTER",
      "Tex": "16/60",
      "Ticket": "1"
    }
  ].obs;

  var selectedBuyer = ''.obs;
  var selectedShadeNo = ''.obs;
  var selectedArticle = ''.obs;
  var selectedBrand = ''.obs;
  var selectedSubstrate = ''.obs;
  var selectedTex = ''.obs;
  var selectedTicket = ''.obs;
  var merchandiserName = ''.obs;
  var colorName = ''.obs;
  var quantity = '1'.obs;
  var remarks = ''.obs;

  var orderLines = <Map<String, String>>[].obs;

  void addOrderLine() {
    orderLines.add({
      'Buyer': selectedBuyer.value,
      'ShadeNo': selectedShadeNo.value,
      'Article': selectedArticle.value,
      'Brand': selectedBrand.value,
      'Substrate': selectedSubstrate.value,
      'Tex': selectedTex.value,
      'Ticket': selectedTicket.value,
      'MerchandiserName': merchandiserName.value,
      'ColorName': colorName.value,
      'Quantity': quantity.value,
      'Remarks': remarks.value,
    });

    // Clear the inputs and search fields
    selectedBuyer.value = '';
    selectedShadeNo.value = '';
    selectedArticle.value = '';
    selectedBrand.value = '';
    selectedSubstrate.value = '';
    selectedTex.value = '';
    selectedTicket.value = '';
    merchandiserName.value = '';
    colorName.value = '';
    quantity.value = '1';
    remarks.value = '';
  }
}

class CreateOrderView extends StatelessWidget {
  final CreateOrderController controller = Get.put(CreateOrderController());

  CreateOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SearchField(
                        searchInputDecoration: SearchInputDecoration(
                          labelText: 'Buyer Name',
                        ),
                        selectedValue: controller.selectedBuyer.value.isEmpty
                            ? null
                            : SearchFieldListItem(
                                controller.selectedBuyer.value,
                              ),
                        suggestions: controller.buyers
                            .map(
                              (buyer) => SearchFieldListItem(
                                buyer['F00092_RMK3'] ?? '',
                              ),
                            )
                            .toList(),
                        onSuggestionTap: (item) {
                          var selected = controller.buyers.firstWhere((buyer) =>
                              buyer['F00092_RMK3'] == item.searchKey);
                          controller.selectedBuyer.value =
                              selected['F00092_RMK3'] ?? '';
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                            labelText: '1st Light Source'),
                        enabled: false,
                        controller: TextEditingController(
                            text: controller.selectedBuyer.value.isNotEmpty
                                ? controller.buyers.firstWhere((buyer) =>
                                    buyer['F00092_RMK3'] ==
                                    controller
                                        .selectedBuyer.value)['F00092_RMK']
                                : ''),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                            labelText: '2nd Light Source'),
                        enabled: false,
                        controller: TextEditingController(
                            text: controller.selectedBuyer.value.isNotEmpty
                                ? controller.buyers.firstWhere((buyer) =>
                                    buyer['F00092_RMK3'] ==
                                    controller
                                        .selectedBuyer.value)['F00092_RMK2']
                                : ''),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                            labelText: 'Merchandiser Name'),
                        onChanged: (value) {
                          controller.merchandiserName.value = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration:
                            const InputDecoration(labelText: 'Color Name'),
                        onChanged: (value) {
                          controller.colorName.value = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: SearchField(
                        searchInputDecoration: SearchInputDecoration(
                          labelText: 'Shade No',
                        ),
                        selectedValue: controller.selectedShadeNo.value.isEmpty
                            ? null
                            : SearchFieldListItem(
                                controller.selectedShadeNo.value,
                              ),
                        suggestions: controller.shadeNumbers
                            .map((shade) => SearchFieldListItem(shade))
                            .toList(),
                        onSuggestionTap: (item) {
                          controller.selectedShadeNo.value = item.searchKey;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: SearchField(
                      searchInputDecoration: SearchInputDecoration(
                        labelText: 'Substrate',
                      ),
                      selectedValue: controller.selectedSubstrate.value.isEmpty
                          ? null
                          : SearchFieldListItem(
                              controller.selectedSubstrate.value,
                            ),
                      suggestions: controller.articles
                          .map(
                            (article) =>
                                SearchFieldListItem(article['Substrate'] ?? ''),
                          )
                          .toList(),
                      onSuggestionTap: (item) {
                        var selected = controller.articles.firstWhere(
                            (article) =>
                                article['Substrate'] == item.searchKey);
                        controller.selectedSubstrate.value =
                            selected['Substrate'] ?? '';
                      },
                    ),
                  ),
                  Expanded(
                    child: SearchField(
                      searchInputDecoration: SearchInputDecoration(
                        labelText: 'Tex',
                      ),
                      selectedValue: controller.selectedTex.value.isEmpty
                          ? null
                          : SearchFieldListItem(
                              controller.selectedTex.value,
                            ),
                      suggestions: controller.articles
                          .map((article) =>
                              SearchFieldListItem(article['Tex'] ?? ''))
                          .toList(),
                      onSuggestionTap: (item) {
                        var selected = controller.articles.firstWhere(
                            (article) => article['Tex'] == item.searchKey);
                        controller.selectedTex.value = selected['Tex'] ?? '';
                      },
                    ),
                  ),
                  Expanded(
                    child: SearchField(
                      searchInputDecoration: SearchInputDecoration(
                        labelText: 'Brand',
                      ),
                      selectedValue: controller.selectedBrand.value.isEmpty
                          ? null
                          : SearchFieldListItem(
                              controller.selectedBrand.value,
                            ),
                      suggestions: controller.articles
                          .map((article) =>
                              SearchFieldListItem(article['Brand'] ?? ''))
                          .toList(),
                      onSuggestionTap: (item) {
                        var selected = controller.articles.firstWhere(
                            (article) => article['Brand'] == item.searchKey);
                        controller.selectedBrand.value =
                            selected['Brand'] ?? '';
                      },
                    ),
                  ),
                  Expanded(
                    child: SearchField(
                      searchInputDecoration: SearchInputDecoration(
                        labelText: 'Article',
                      ),
                      selectedValue: controller.selectedArticle.value.isEmpty
                          ? null
                          : SearchFieldListItem(
                              controller.selectedArticle.value,
                            ),
                      suggestions: controller.articles
                          .map((article) =>
                              SearchFieldListItem(article['Article'] ?? ''))
                          .toList(),
                      onSuggestionTap: (item) {
                        var selected = controller.articles.firstWhere(
                            (article) => article['Article'] == item.searchKey);
                        controller.selectedArticle.value =
                            selected['Article'] ?? '';
                      },
                    ),
                  ),
                  Expanded(
                    child: SearchField(
                      searchInputDecoration: SearchInputDecoration(
                        labelText: 'Ticket',
                      ),
                      selectedValue: controller.selectedTicket.value.isEmpty
                          ? null
                          : SearchFieldListItem(
                              controller.selectedTicket.value,
                            ),
                      suggestions: controller.articles
                          .map((article) =>
                              SearchFieldListItem(article['Ticket'] ?? ''))
                          .toList(),
                      onSuggestionTap: (item) {
                        var selected = controller.articles.firstWhere(
                            (article) => article['Ticket'] == item.searchKey);
                        controller.selectedTicket.value =
                            selected['Ticket'] ?? '';
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    // Expanded(
                    //   child: TextField(
                    //     decoration:
                    //         const InputDecoration(labelText: 'Quantity'),
                    //     enabled: false,
                    //     controller: TextEditingController(text: '1'),
                    //     onChanged: (value) {
                    //       controller.quantity.value = value;
                    //     },
                    //   ),
                    // ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'Remarks'),
                        onChanged: (value) {
                          controller.remarks.value = value;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        controller.addOrderLine();
                      },
                      child: const Text('Add Line'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(
                  () => DataTable(
                    columns: const [
                      DataColumn(label: Text('Buyer')),
                      DataColumn(label: Text('Shade No')),
                      DataColumn(label: Text('Article')),
                      DataColumn(label: Text('Brand')),
                      DataColumn(label: Text('Substrate')),
                      DataColumn(label: Text('Tex')),
                      DataColumn(label: Text('Ticket')),
                      DataColumn(label: Text('Color Name')),
                      DataColumn(label: Text('Remarks')),
                    ],
                    rows: controller.orderLines.map(
                      (orderLine) {
                        return DataRow(
                          cells: [
                            DataCell(Text(orderLine['Buyer'] ?? '')),
                            DataCell(Text(orderLine['ShadeNo'] ?? '')),
                            DataCell(Text(orderLine['Article'] ?? '')),
                            DataCell(Text(orderLine['Brand'] ?? '')),
                            DataCell(Text(orderLine['Substrate'] ?? '')),
                            DataCell(Text(orderLine['Tex'] ?? '')),
                            DataCell(Text(orderLine['Ticket'] ?? '')),
                            DataCell(Text(orderLine['ColorName'] ?? '')),
                            DataCell(Text(orderLine['Remarks'] ?? '')),
                          ],
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              PrimaryButton(
                text: 'Submit Order',
                onPressed: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
