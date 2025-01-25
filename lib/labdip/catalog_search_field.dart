import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:vardhman_b2b/common/secondary_button.dart';
import 'package:vardhman_b2b/constants.dart';

class CatalogSearchField extends StatelessWidget {
  const CatalogSearchField({
    super.key,
    required this.labelText,
    required this.rxString,
    required this.searchList,
  });

  final String labelText;
  final RxString rxString;
  final List<String> searchList;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: VardhmanColors.dividerGrey,
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: SearchField(
                searchInputDecoration: SearchInputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.5,
                      color: VardhmanColors.dividerGrey,
                    ),
                  ),
                  label: Text(labelText),
                ),
                enabled: searchList.isNotEmpty,
                suggestions: searchList
                    .map(
                      (e) => SearchFieldListItem(e),
                    )
                    .toList(),
                onSuggestionTap: (searchFieldListItem) {
                  rxString.value = searchFieldListItem.searchKey;
                },
                selectedValue:
                    rxString.isEmpty || !searchList.contains(rxString.value)
                        ? null
                        : SearchFieldListItem(rxString.value),
              ),
            ),
            const SizedBox(width: 8),
            SecondaryButton(
              wait: false,
              iconData: Icons.clear,
              text: '',
              onPressed: rxString.value.isEmpty
                  ? null
                  : () async {
                      rxString.value = '';
                    },
            ),
          ],
        ),
      ),
    );
  }
}
