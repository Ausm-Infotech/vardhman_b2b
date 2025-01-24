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
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: VardhmanColors.dividerGrey,
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              labelText,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SearchField(
                hint: searchList.isNotEmpty
                    ? 'select $labelText'.toLowerCase()
                    : 'no $labelText to select'.toLowerCase(),
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
            const SizedBox(width: 16),
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
